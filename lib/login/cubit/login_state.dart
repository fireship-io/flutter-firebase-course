part of 'login_cubit.dart';

enum LoginStatus { pure, signingIn, failure }

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
    this.status = LoginStatus.pure,
    this.signInMethod = SignInMethod.none,
    this.failure = AppFailure.none,
  });

  const LoginState.pure() : this._();

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

  const LoginState.failure(AppFailure failure)
      : this._(
          status: LoginStatus.failure,
          failure: failure,
        );

  final LoginStatus status;
  final SignInMethod signInMethod;
  final AppFailure failure;

  @override
  List<Object> get props => [status, signInMethod, failure];
}

extension LoginStateExtensions on LoginState {
  bool get isNotFailure => status != LoginStatus.failure;

  bool get isSigningInAnonymously =>
      status.isSigningIn && signInMethod.isAnonymous;
  bool get isSigningInWithGoogle => status.isSigningIn && signInMethod.isGoogle;
  bool get isSigningInWithApple => status.isSigningIn && signInMethod.isApple;
}
