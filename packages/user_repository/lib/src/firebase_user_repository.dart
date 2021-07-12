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
    return watchUser.first.catchError((_) => User.none);
  }

  @override
  Future<void> signInAnonymously() async {
    try {
      final userCredential = await _firebaseAuth.signInAnonymously();
      final firebaseUser = userCredential.user;
      unawaited(_updateUserData(firebaseUser));
    } on FirebaseAuthException {
      throw AppFailure.fromAnonymousSignIn();
    }
  }

  @override
  Future<void> signInWithGoogle() async {
    try {
      final googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount == null) {
        return;
      }
      final googleSignInAuth = await googleSignInAccount.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuth.accessToken,
        idToken: googleSignInAuth.idToken,
      );

      final userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      final firebaseUser = userCredential.user;
      unawaited(_updateUserData(firebaseUser));
    } on FirebaseAuthException {
      throw AppFailure.fromGoogleSignIn();
    }
  }

  @override
  Future<void> signInWithApple() {
    // TODO: implement signInWithApple
    throw UnimplementedError();
    // final firebaseUser = userCredential.user;
    //   unawaited(_updateUserData(firebaseUser));
  }

  @override
  Future<void> logOut() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException {
      throw AppFailure.fromLogOut();
    }
  }

  Future<void> _updateUserData(firebase.User? firebaseUser) async {
    if (firebaseUser == null) {
      return;
    }
    final uid = firebaseUser.uid;
    final user = User(uid: uid);
    return _firestore.userDoc(uid).set(
          user.toJson(),
          SetOptions(merge: true),
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
          .handleError((_) => throw AppFailure.fromAuth())
          .logOnEach('USER')
          .shareValue();
}
