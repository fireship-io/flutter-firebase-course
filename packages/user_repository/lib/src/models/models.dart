import 'package:data_providers/data_providers.dart' as firebase show User;
import 'package:shared/shared.dart';

part 'models.g.dart';

// ignore_for_file: sort_constructors_first

@JsonSerializable()
class User extends Equatable {
  const User({
    required this.uid,
    this.completedQuizzes = const {},
    this.totalCompletedQuizzes = 0,
    this.lastSignInAt,
  });

  factory User.fromFirebaseUser(firebase.User firebaseUser) =>
      User(uid: firebaseUser.uid);

  final String uid;
  // ? Map<TopicID, List<QuizID>>
  @JsonKey(defaultValue: {})
  final Map<String, List<String>> completedQuizzes;
  @JsonKey(name: 'total', defaultValue: 0)
  final int totalCompletedQuizzes;
  @timestamp
  final DateTime? lastSignInAt;

  static const none = User(uid: '');

  @override
  List<Object?> get props => [
        uid,
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
      completedQuizzes.containsKey(topicId) &&
      completedQuizzes[topicId]!.contains(quizId);
}
