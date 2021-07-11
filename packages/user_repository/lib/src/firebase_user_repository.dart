part of 'user_repository.dart';

class FirebaseUserRepository implements UserRepository {
  FirebaseUserRepository({
    FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firestore,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance {
    _user = _firebaseAuth.authUserChanges(_firestore);
  }

  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

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
  Future<void> logOut() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException {
      throw AppFailure.fromLogOut();
    }
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
