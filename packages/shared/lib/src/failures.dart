class AppFailure implements Exception {
  const AppFailure();

  factory AppFailure.fromAuth() => const AuthFailure();
  factory AppFailure.fromLogOut() => const AuthFailure();

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
