import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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
    } on AppFailure catch (failure) {
      _onLoginFailed(failure);
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      emit(const LoginState.signingInWithGoogle());
      await _userRepository.signInWithGoogle();
    } on AppFailure catch (failure) {
      _onLoginFailed(failure);
    }
  }

  Future<void> signInWithApple() async {
    try {
      emit(const LoginState.signingInWithApple());
      await _userRepository.signInWithApple();
    } on AppFailure catch (failure) {
      _onLoginFailed(failure);
    }
  }

  void _onLoginFailed(AppFailure failure) {
    emit(LoginState.failure(failure));
    emit(const LoginState.initial());
  }
}
