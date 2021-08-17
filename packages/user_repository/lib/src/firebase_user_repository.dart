part of 'user_repository.dart';

class FirebaseUserRepository implements UserRepository {
  FirebaseUserRepository({
    FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firestore,
    GoogleSignIn? googleSignIn,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard() {
    _user = _firebaseAuth.authUserChanges(_firestore);
  }

  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  final GoogleSignIn _googleSignIn;

  late final ValueStream<User> _user;

  @override
  Stream<User> get watchUser => _user.asBroadcastStream();

  @override
  User get user => _user.valueOrNull ?? User.none;

  @override
  Future<User> getOpeningUser() {
    return watchUser.first.catchError((Object _) => User.none);
  }

  @override
  Future<void> signInAnonymously() async {
    try {
      final userCredential = await _firebaseAuth.signInAnonymously();
      final firebaseUser = userCredential.user;
      unawaited(_updateUserData(firebaseUser));
    } on FirebaseAuthException {
      throw UserFailure.fromAnonymousSignIn();
    }
  }

  @override
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

      final userCredential =
          await _firebaseAuth.signInWithCredential(oauthCredential);
      final firebaseUser = userCredential.user;
      unawaited(_updateUserData(firebaseUser));
    } on FirebaseAuthException {
      throw UserFailure.fromGoogleSignIn();
    }
  }

  @override
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
      final userCredential =
          await _firebaseAuth.signInWithCredential(oauthCredential);
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

  @override
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

  @override
  Future<void> markQuizCompleted({
    required String quizId,
    required String topicId,
  }) {
    return _firestore.userDoc(user.uid).set(<String, dynamic>{
      'total': FieldValue.increment(1),
      'completedQuizzes': {
        topicId: FieldValue.arrayUnion(<String>[quizId]),
      }
    }, SetOptions(merge: true));
  }

  Future<void> _updateUserData(firebase.User? firebaseUser) async {
    if (firebaseUser == null) {
      return;
    }
    final uid = firebaseUser.uid;
    final user = User.fromFirebaseUser(firebaseUser);
    return _firestore.userDoc(uid).set(
          user.toJson(),
          SetOptions(mergeFields: [
            'uid',
            'lastSignInAt',
            'displayName',
            'photoURL',
            'email',
          ]),
        );
  }
}

extension _FirebaseAuthExtensions on FirebaseAuth {
  ValueStream<User> authUserChanges(FirebaseFirestore firestore) =>
      authStateChanges()
          .onErrorResumeWith((_, __) => null)
          .switchMap<User>(
            (firebaseUser) async* {
              if (firebaseUser == null) {
                yield User.none;
                return;
              }

              yield* firestore
                  .userDoc(firebaseUser.uid)
                  .snapshots()
                  .map((snapshot) {
                if (snapshot.exists) {
                  return User.fromJson(snapshot.data()!);
                }
                return User.none;
              });
            },
          )
          .handleError((Object _) => throw UserFailure.fromAuthUserChanges())
          .logOnEach('USER')
          .shareValue();
}
