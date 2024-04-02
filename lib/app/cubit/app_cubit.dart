import 'package:app_core/app_core.dart';
import 'package:user_repository/user_repository.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(
          userRepository.user.isNone
              ? const AppState.unauthenticated()
              : AppState.newlyAuthenticated(userRepository.user),
        ) {
    _watchUser();
  }

  final UserRepository _userRepository;

  @override
  Future<void> close() async {
    await _unwatchUser();
    return super.close();
  }

  Future<void> logOut() async {
    try {
      await _userRepository.signOut();
    } on UserFailure catch (failure) {
      _onUserFailed(failure);
    }
  }

  void _onUserChanged(User user) {
    if (user.isNone) {
      emit(const AppState.unauthenticated());
    } else if (state.isUnauthenticated) {
      emit(AppState.newlyAuthenticated(user));
    } else {
      emit(AppState.authenticated(user));
    }
  }

  void _onUserFailed(UserFailure failure) {
    final currentState = state;
    emit(AppState.failure(failure: failure, user: currentState.user));
    if (failure.needsReauthentication) {
      emit(const AppState.unauthenticated());
    } else {
      emit(currentState);
    }
  }

  late final StreamSubscription<User> _userSubscription;
  void _watchUser() {
    _userSubscription = _userRepository.watchUser
        .handleFailure(_onUserFailed)
        .listen(_onUserChanged);
  }

  Future<void> _unwatchUser() {
    return _userSubscription.cancel();
  }
}
