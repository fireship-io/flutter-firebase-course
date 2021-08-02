class AppFailure implements Exception {
  const AppFailure._();

  factory AppFailure.fromAuth() => const AuthFailure();
  factory AppFailure.fromLogOut() => const LogOutFailure();
  factory AppFailure.fromAnonymousSignIn() => const AnonymousSignInFailure();
  factory AppFailure.fromGoogleSignIn() => const GoogleSignInFailure();
  factory AppFailure.fromAppleSignIn() => const AppleSignInFailure();
  factory AppFailure.fromSignInWithAppleNotSupported() =>
      const AppleSignInNotSupportedFailure();

  static const none = AppNoFailure();

  bool get requiresReauthentication {
    return this is AuthFailure;
  }
}

class AppNoFailure extends AppFailure {
  const AppNoFailure() : super._();
}

class AuthFailure extends AppFailure {
  const AuthFailure() : super._();
}

class LogOutFailure extends AppFailure {
  const LogOutFailure() : super._();
}

class AnonymousSignInFailure extends AppFailure {
  const AnonymousSignInFailure() : super._();
}

class GoogleSignInFailure extends AppFailure {
  const GoogleSignInFailure() : super._();
}

class AppleSignInFailure extends AppFailure {
  const AppleSignInFailure() : super._();
}

class AppleSignInNotSupportedFailure extends AppFailure {
  const AppleSignInNotSupportedFailure() : super._();
}

class TopicsFailure implements Exception {
  const TopicsFailure._();

  factory TopicsFailure.fromGetTopics() => const GetTopicsFailure();

  static const none = TopicsNoFailure();
}

class TopicsNoFailure extends TopicsFailure {
  const TopicsNoFailure() : super._();
}

class GetTopicsFailure extends TopicsFailure {
  const GetTopicsFailure() : super._();
}

class QuizzesFailure implements Exception {
  const QuizzesFailure._();

  factory QuizzesFailure.fromGetQuiz() => const GetQuizFailure();

  static const none = QuizzesNoFailure();
}

class QuizzesNoFailure extends QuizzesFailure {
  const QuizzesNoFailure() : super._();
}

class GetQuizFailure extends QuizzesFailure {
  const GetQuizFailure() : super._();
}
