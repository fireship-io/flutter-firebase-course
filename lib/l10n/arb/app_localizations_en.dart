// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'QuizApp';

  @override
  String get authFailureMessage =>
      'There\'s been an error, please log back in!';

  @override
  String get signOutFailureMessage =>
      'There\'s been an error while logging out, please try again!';

  @override
  String get anonymousSignInFailureMessage =>
      'You can\'t sign in as a guest at the moment, please try again later!';

  @override
  String get googleSignInFailureMessage =>
      'There\'s been an error while signing in with google, please try again!';

  @override
  String get appleSignInFailureMessage =>
      'There\'s been an error while signing in with apple, please try again!';

  @override
  String get appleSignInNotSupportedFailureMessage =>
      'Apple sign in is not supported on your device!';

  @override
  String get unknownFailureMessage =>
      'There\'s been an error, please try again!';

  @override
  String get loginPreamble => 'Login to Start';

  @override
  String get loginTagline =>
      'Test your app development knowledge with quick bite-sized quizzes from fireship.io';

  @override
  String get loginWithGoogleButtonLabel => 'Login with Google';

  @override
  String get loginWithAppleButtonLabel => 'Login with Apple';

  @override
  String get loginAsGuestButtonLabel => 'Continue as Guest';

  @override
  String get topicsLabel => 'Topics';

  @override
  String get aboutLabel => 'About';

  @override
  String get profileLabel => 'Profile';

  @override
  String get getTopicsFailureMessage =>
      'There\'s been an error getting the topics 🙄';

  @override
  String get noTopicsMessage => 'There are no topics 😏';

  @override
  String congratsMessage(String quizTitle) {
    return 'Congrats! You completed the $quizTitle quiz';
  }

  @override
  String get quizStartButtonLabel => 'Start Quiz!';

  @override
  String get markQuizCompletedButtonLabel => 'Mark Complete!';

  @override
  String get correctAnswerMessage => 'Good Job!';

  @override
  String get wrongAnswerMessage => 'Wrong';

  @override
  String get correctQuizButtonLabel => 'Onward!';

  @override
  String get wrongQuizButtonLabel => 'Try Again';

  @override
  String get noQuizDataMessage => 'There\'s no quiz data 😏';

  @override
  String get getQuizFailureMessage =>
      'There\'s been an error getting quiz data 🙄';

  @override
  String get guestProfileDisplayName => 'Guest';

  @override
  String get totalCompletedQuizzesLabel => 'Quizzes Completed';

  @override
  String get logOutButtonLabel => 'Logout';
}
