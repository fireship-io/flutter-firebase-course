import 'package:data_providers/data_providers.dart' hide User;
import 'package:data_providers/data_providers.dart' as firebase show User;
import 'package:shared/shared.dart';
import 'package:user_repository/src/failures.dart';
import 'package:user_repository/src/models/models.dart';

part 'firebase_user_repository.dart';

abstract interface class UserRepository {
  /// Current user as a stream.
  Stream<User> get watchUser;

  /// Gets the current user synchronously.
  User get user;

  /// Gets the initial `watchUser` emission.
  ///
  /// Returns `User.none` when an error occurs.
  Future<User> getOpeningUser();

  /// Signs the user in anonymously.
  Future<void> signInAnonymously();

  /// Signs the user in using google provider.
  Future<void> signInWithGoogle();

  /// Signs the user in using apple provider.
  Future<void> signInWithApple();

  /// Logs out the current user.
  Future<void> signOut();

  /// Marks a quiz as completed.
  ///
  /// It also increments the total no of completed quizzes.
  Future<void> markQuizCompleted({
    required String quizId,
    required String topicId,
  });
}
