class AppFailure implements Exception {
  const AppFailure();

  factory AppFailure.fromAuth() => const AuthFailure();
  factory AppFailure.fromLogOut() => const LogOutFailure();
  factory AppFailure.fromAnonymousSignIn() => const AnonymousSignInFailure();
  factory AppFailure.fromGoogleSignIn() => const GoogleSignInFailure();
  factory AppFailure.fromAppleSignIn() => const AppleSignInFailure();
  factory AppFailure.fromSignInWithAppleNotSupported() =>
      const AppleSignInNotSupportedFailure();

  static const none = NoFailure();

  bool get requiresReauthentication {
    return this is AuthFailure;
  }
}

class NoFailure extends AppFailure {
  const NoFailure();
}

class AuthFailure extends AppFailure {
  const AuthFailure();
}

class LogOutFailure extends AppFailure {
  const LogOutFailure();
}

class AnonymousSignInFailure extends AppFailure {
  const AnonymousSignInFailure();
}

class GoogleSignInFailure extends AppFailure {
  const GoogleSignInFailure();
}

class AppleSignInFailure extends AppFailure {
  const AppleSignInFailure();
}

class AppleSignInNotSupportedFailure extends AppFailure {
  const AppleSignInNotSupportedFailure();
}
