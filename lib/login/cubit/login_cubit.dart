import 'package:shared/shared.dart';
import 'package:user_repository/user_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(const LoginState.initial());

  final UserRepository _userRepository;

  Future<void> signInAnonymously() async {
    try {
      emit(const LoginState.signingInAnonymously());
      await _userRepository.signInAnonymously();
    } on UserFailure catch (failure) {
      _onLoginFailed(failure);
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      emit(const LoginState.signingInWithGoogle());
      await _userRepository.signInWithGoogle();
    } on GoogleSignInCancelledFailure {
      emit(const LoginState.initial());
    } on UserFailure catch (failure) {
      _onLoginFailed(failure);
    }
  }

  Future<void> signInWithApple() async {
    try {
      emit(const LoginState.signingInWithApple());
      await _userRepository.signInWithApple();
    } on UserFailure catch (failure) {
      _onLoginFailed(failure);
    }
  }

  void _onLoginFailed(UserFailure failure) {
    emit(LoginState.failure(failure));
    emit(const LoginState.initial());
  }
}
