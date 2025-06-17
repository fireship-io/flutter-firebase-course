import 'package:api_client/api_client.dart' as firebase show User;
import 'package:api_client/api_client.dart' hide User;
import 'package:app_core/app_core.dart';
import 'package:user_repository/src/failures.dart';
import 'package:user_repository/src/models/models.dart';

class UserRepository {
  UserRepository({
    FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firestore,
    GoogleSignIn? googleSignIn,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
       _firestore = firestore ?? FirebaseFirestore.instance,
       _googleSignIn = googleSignIn ?? GoogleSignIn.standard() {
    _user = _firebaseAuth.authUserChanges(_firestore);
  }

  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  final GoogleSignIn _googleSignIn;

  late final ValueStream<User> _user;

  /// Current [User] as a stream.
  Stream<User> get watchUser => _user.asBroadcastStream();

  /// Gets the current [User] synchronously.
  User get user => _user.valueOrNull ?? User.empty;

  /// Gets the initial [watchUser] emission.
  ///
  /// Returns [User.empty] when an error occurs.
  Future<User> getOpeningUser() {
    return watchUser.first.catchError((Object _) => User.empty);
  }

  /// Signs the [User] in anonymously.
  Future<void> signInAnonymously() async {
    try {
      final userCredential = await _firebaseAuth.signInAnonymously();
      final firebaseUser = userCredential.user;
      unawaited(_updateUserData(firebaseUser));
    } on FirebaseAuthException {
      throw UserFailure.fromAnonymousSignIn();
    }
  }

  /// Signs the [User] in using google provider.
  Future<void> signInWithGoogle() async {
    try {
      final googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount == null) {
        throw UserFailure.fromGoogleSignInCancelled();
      }
      final googleSignInAuth = await googleSignInAccount.authentication;

      final oauthCredential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuth.accessToken,
        idToken: googleSignInAuth.idToken,
      );

      final userCredential = await _firebaseAuth.signInWithCredential(
        oauthCredential,
      );
      final firebaseUser = userCredential.user;
      unawaited(_updateUserData(firebaseUser));
    } on FirebaseAuthException {
      throw UserFailure.fromGoogleSignIn();
    }
  }

  /// Signs the [User] in using apple provider.
  Future<void> signInWithApple() async {
    try {
      // To prevent replay attacks with the credential returned from Apple, we
      // include a nonce in the credential request. When signing in with
      // Firebase, the nonce in the id token returned by Apple, is expected to
      // match the sha256 hash of `rawNonce`.
      final rawNonce = CryptoUtils.generateNonce();
      final nonce = CryptoUtils.sha256ofString(rawNonce);

      // Request credential for the currently signed in Apple account.
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      // Create an `OAuthCredential` from the credential returned by Apple.
      final oauthCredential = OAuthProvider('apple.com').credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );

      // If the nonce we generated earlier does not match the nonce
      // in `appleCredential.identityToken`, sign in will fail.
      final userCredential = await _firebaseAuth.signInWithCredential(
        oauthCredential,
      );
      final firebaseUser = userCredential.user;
      unawaited(_updateUserData(firebaseUser));
    } on SignInWithAppleNotSupportedException {
      throw UserFailure.fromSignInWithAppleNotSupported();
    } on SignInWithAppleException {
      throw UserFailure.fromAppleSignIn();
    } on FirebaseAuthException {
      throw UserFailure.fromAppleSignIn();
    }
  }

  /// Signs out the current [User].
  Future<void> signOut() async {
    try {
      await Future.wait([
        _googleSignIn.signOut(),
        _firebaseAuth.signOut(),
      ]);
    } on Exception {
      throw UserFailure.fromSignOut();
    }
  }

  /// Marks a `Quiz` as completed.
  ///
  /// It also increments the total no of completed quizzes.
  Future<void> markQuizCompleted({
    required String quizId,
    required String topicId,
  }) {
    return _firestore.userDoc(user.uid).set(
      <String, dynamic>{
        'total': FieldValue.increment(1),
        'completedQuizzes': {
          topicId: FieldValue.arrayUnion(<String>[quizId]),
        },
      },
      SetOptions(merge: true),
    );
  }

  Future<void> _updateUserData(firebase.User? firebaseUser) async {
    if (firebaseUser == null) {
      return;
    }
    final uid = firebaseUser.uid;
    final user = User.fromFirebaseUser(firebaseUser);
    return _firestore
        .userDoc(uid)
        .set(
          user.toJson(),
          SetOptions(
            mergeFields: [
              'uid',
              'lastSignInAt',
              'displayName',
              'photoURL',
              'email',
            ],
          ),
        );
  }
}

extension _FirebaseAuthExtensions on FirebaseAuth {
  ValueStream<User> authUserChanges(FirebaseFirestore firestore) =>
      authStateChanges()
          .onErrorResumeWith((_, _) => null)
          .switchMap<User>(
            (firebaseUser) async* {
              if (firebaseUser == null) {
                yield User.empty;
                return;
              }

              yield* firestore
                  .userDoc(firebaseUser.uid)
                  .snapshots()
                  .map(
                    (snapshot) => snapshot.exists
                        ? User.fromJson(snapshot.data()!)
                        : User.empty,
                  );
            },
          )
          .handleError((Object _) => throw UserFailure.fromAuthUserChanges())
          .logOnEach('USER')
          .shareValue();
}
