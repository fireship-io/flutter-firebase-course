import 'package:api_client/api_client.dart' as firebase show User;
import 'package:api_client/api_client.dart';
import 'package:app_core/app_core.dart';

part 'models.g.dart';

// ignore_for_file: sort_constructors_first

@JsonSerializable()
class User extends Equatable {
  const User({
    required this.uid,
    this.displayName = '',
    this.photoURL = '',
    this.email = '',
    this.completedQuizzes = const {},
    this.totalCompletedQuizzes = 0,
    this.lastSignInAt,
  });

  factory User.fromFirebaseUser(firebase.User firebaseUser) => User(
        uid: firebaseUser.uid,
        displayName: firebaseUser.displayName ?? '',
        photoURL: firebaseUser.photoURL ?? '',
        email: firebaseUser.email ?? '',
      );

  final String uid;
  @JsonKey(defaultValue: '')
  final String displayName;
  @JsonKey(defaultValue: '')
  final String photoURL;
  @JsonKey(defaultValue: '')
  final String email;
  // ? Map<TopicID, List<QuizID>>
  @JsonKey(defaultValue: <String, List<String>>{})
  final Map<String, List<String>> completedQuizzes;
  @JsonKey(name: 'total', defaultValue: 0)
  final int totalCompletedQuizzes;
  @timestamp
  final DateTime? lastSignInAt;

  static const none = User(uid: '');

  @override
  List<Object?> get props => [
        uid,
        displayName,
        photoURL,
        email,
        completedQuizzes,
        totalCompletedQuizzes,
        lastSignInAt,
      ];

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

extension UserExtensions on User {
  bool get isNone => this == User.none;

  int totalCompletedQuizzesByTopic(String topicId) =>
      completedQuizzes[topicId]?.length ?? 0;

  bool hasCompletedQuiz({
    required String quizId,
    required String topicId,
  }) =>
      completedQuizzes[topicId]?.contains(quizId) ?? false;
}
