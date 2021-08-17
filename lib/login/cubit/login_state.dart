part of 'login_cubit.dart';

enum LoginStatus { initial, signingIn, failure }

extension LoginStatusExtensions on LoginStatus {
  bool get isSigningIn => this == LoginStatus.signingIn;
}

enum SignInMethod { none, anonymous, google, apple }

extension SignInMethodExtensions on SignInMethod {
  bool get isAnonymous => this == SignInMethod.anonymous;
  bool get isGoogle => this == SignInMethod.google;
  bool get isApple => this == SignInMethod.apple;
}

class LoginState extends Equatable {
  const LoginState._({
    this.status = LoginStatus.initial,
    this.signInMethod = SignInMethod.none,
    this.failure = UserFailure.none,
  });

  const LoginState.initial() : this._();

  const LoginState.signingInAnonymously()
      : this._(
          status: LoginStatus.signingIn,
          signInMethod: SignInMethod.anonymous,
        );

  const LoginState.signingInWithGoogle()
      : this._(
          status: LoginStatus.signingIn,
          signInMethod: SignInMethod.google,
        );

  const LoginState.signingInWithApple()
      : this._(
          status: LoginStatus.signingIn,
          signInMethod: SignInMethod.apple,
        );

  const LoginState.failure(UserFailure failure)
      : this._(
          status: LoginStatus.failure,
          failure: failure,
        );

  final LoginStatus status;
  final SignInMethod signInMethod;
  final UserFailure failure;

  @override
  List<Object> get props => [status, signInMethod, failure];
}

extension LoginStateExtensions on LoginState {
  bool get isFailure => status == LoginStatus.failure;

  bool get isSigningInAnonymously =>
      status.isSigningIn && signInMethod.isAnonymous;
  bool get isSigningInWithGoogle => status.isSigningIn && signInMethod.isGoogle;
  bool get isSigningInWithApple => status.isSigningIn && signInMethod.isApple;
}
