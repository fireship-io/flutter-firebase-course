import 'package:app_core/app_core.dart';

class UserFailure extends Failure {
  const UserFailure._();

  factory UserFailure.fromAuthUserChanges() => const AuthUserChangesFailure();
  factory UserFailure.fromSignOut() => const SignOutFailure();
  factory UserFailure.fromAnonymousSignIn() => const AnonymousSignInFailure();
  factory UserFailure.fromGoogleSignIn() => const GoogleSignInFailure();
  factory UserFailure.fromGoogleSignInCancelled() =>
      const GoogleSignInCancelledFailure();
  factory UserFailure.fromAppleSignIn() => const AppleSignInFailure();
  factory UserFailure.fromSignInWithAppleNotSupported() =>
      const AppleSignInNotSupportedFailure();

  static const none = UserNoFailure();

  bool get requiresReauthentication {
    return this is AuthUserChangesFailure;
  }
}

class UserNoFailure extends UserFailure {
  const UserNoFailure() : super._();
}

class AuthUserChangesFailure extends UserFailure {
  const AuthUserChangesFailure() : super._();
}

class SignOutFailure extends UserFailure {
  const SignOutFailure() : super._();
}

class AnonymousSignInFailure extends UserFailure {
  const AnonymousSignInFailure() : super._();
}

class GoogleSignInFailure extends UserFailure {
  const GoogleSignInFailure() : super._();
}

class GoogleSignInCancelledFailure extends UserFailure {
  const GoogleSignInCancelledFailure() : super._();
}

class AppleSignInFailure extends UserFailure {
  const AppleSignInFailure() : super._();
}

class AppleSignInNotSupportedFailure extends UserFailure {
  const AppleSignInNotSupportedFailure() : super._();
}
