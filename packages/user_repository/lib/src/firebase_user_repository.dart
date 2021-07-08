part of 'user_repository.dart';

class FirebaseUserRepository implements UserRepository {
  FirebaseUserRepository({
    FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firestore,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  @override
  Stream<User> get watchUser => _firebaseAuth
      .authStateChanges()
      .onErrorResumeWith((_, __) => null)
      .switchMap<User>(
        (firebaseUser) async* {
          if (firebaseUser == null) {
            yield User.none;
            return;
          }

          yield* _firestore
              .userDoc(firebaseUser.uid)
              .snapshots()
              .map((snapshot) {
            final data = snapshot.data();
            if (data == null) {
              return User.none;
            }
            return User.fromJson(data);
          });
        },
      )
      .handleError((_) => throw AppFailure.fromAuth())
      .logOnEach('USER');

  @override
  Future<User> getOpeningUser() {
    return watchUser.first.catchError((_) => User.none);
  }

  @override
  Future<void> logOut() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException {
      throw AppFailure.fromLogOut();
    }
  }
}
