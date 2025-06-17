import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'arb/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// App title
  ///
  /// In en, this message translates to:
  /// **'QuizApp'**
  String get appTitle;

  /// `AuthFailure` message
  ///
  /// In en, this message translates to:
  /// **'There\'s been an error, please log back in!'**
  String get authFailureMessage;

  /// `LogOutFailure` message
  ///
  /// In en, this message translates to:
  /// **'There\'s been an error while logging out, please try again!'**
  String get signOutFailureMessage;

  /// `AnonymousSignInFailure` message
  ///
  /// In en, this message translates to:
  /// **'You can\'t sign in as a guest at the moment, please try again later!'**
  String get anonymousSignInFailureMessage;

  /// `GoogleSignInFailure` message
  ///
  /// In en, this message translates to:
  /// **'There\'s been an error while signing in with google, please try again!'**
  String get googleSignInFailureMessage;

  /// `AppleSignInFailure` message
  ///
  /// In en, this message translates to:
  /// **'There\'s been an error while signing in with apple, please try again!'**
  String get appleSignInFailureMessage;

  /// `AppleSignInNotSupportedFailure` message
  ///
  /// In en, this message translates to:
  /// **'Apple sign in is not supported on your device!'**
  String get appleSignInNotSupportedFailureMessage;

  /// Unknown failure message
  ///
  /// In en, this message translates to:
  /// **'There\'s been an error, please try again!'**
  String get unknownFailureMessage;

  /// Sign in with google button label
  ///
  /// In en, this message translates to:
  /// **'Login to Start'**
  String get loginPreamble;

  /// `LoginPage` tagline
  ///
  /// In en, this message translates to:
  /// **'Test your app development knowledge with quick bite-sized quizzes from fireship.io'**
  String get loginTagline;

  /// No description provided for @loginWithGoogleButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Login with Google'**
  String get loginWithGoogleButtonLabel;

  /// Sign in with apple button label
  ///
  /// In en, this message translates to:
  /// **'Login with Apple'**
  String get loginWithAppleButtonLabel;

  /// Sign in as guest button label
  ///
  /// In en, this message translates to:
  /// **'Continue as Guest'**
  String get loginAsGuestButtonLabel;

  /// Topics  label
  ///
  /// In en, this message translates to:
  /// **'Topics'**
  String get topicsLabel;

  /// About  label
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get aboutLabel;

  /// Profile  label
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileLabel;

  /// `GetTopicsFailure` message
  ///
  /// In en, this message translates to:
  /// **'There\'s been an error getting the topics 🙄'**
  String get getTopicsFailureMessage;

  /// No topics message
  ///
  /// In en, this message translates to:
  /// **'There are no topics 😏'**
  String get noTopicsMessage;

  /// Congrats message
  ///
  /// In en, this message translates to:
  /// **'Congrats! You completed the {quizTitle} quiz'**
  String congratsMessage(String quizTitle);

  /// `QuizStartButton` label
  ///
  /// In en, this message translates to:
  /// **'Start Quiz!'**
  String get quizStartButtonLabel;

  /// `CompleteQuizButton` label
  ///
  /// In en, this message translates to:
  /// **'Mark Complete!'**
  String get markQuizCompletedButtonLabel;

  /// Message shown when correctly answering a quiz question
  ///
  /// In en, this message translates to:
  /// **'Good Job!'**
  String get correctAnswerMessage;

  /// Message shown when incorrectly answering a quiz question
  ///
  /// In en, this message translates to:
  /// **'Wrong'**
  String get wrongAnswerMessage;

  /// `QuizButton`'s label on a correct answer
  ///
  /// In en, this message translates to:
  /// **'Onward!'**
  String get correctQuizButtonLabel;

  /// `QuizButton`'s label on an incorrect answer
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get wrongQuizButtonLabel;

  /// `QuizButton`'s label on an incorrect answer
  ///
  /// In en, this message translates to:
  /// **'There\'s no quiz data 😏'**
  String get noQuizDataMessage;

  /// `GetQuizFailure` message
  ///
  /// In en, this message translates to:
  /// **'There\'s been an error getting quiz data 🙄'**
  String get getQuizFailureMessage;

  /// Display name on guest profiles
  ///
  /// In en, this message translates to:
  /// **'Guest'**
  String get guestProfileDisplayName;

  /// Total completed quizzes label
  ///
  /// In en, this message translates to:
  /// **'Quizzes Completed'**
  String get totalCompletedQuizzesLabel;

  /// `LogOutButton`'s label on profile view
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logOutButtonLabel;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
