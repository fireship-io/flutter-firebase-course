import 'package:shared/shared.dart';

part 'models.g.dart';

// ignore_for_file: sort_constructors_first

@JsonSerializable(createToJson: false)
class Quiz extends Equatable {
  const Quiz({
    required this.id,
    required this.title,
    required this.description,
  });

  final String id;
  final String title;
  final String description;

  @override
  List<Object?> get props => [id, title, description];

  factory Quiz.fromJson(Map<String, dynamic> json) => _$QuizFromJson(json);
}

@JsonSerializable(createToJson: false)
class Topic extends Equatable {
  const Topic({
    required this.id,
    required this.title,
    required this.description,
    required this.imageName,
    required this.quizzes,
  });

  final String id;
  final String title;
  @JsonKey(defaultValue: '')
  final String description;
  @JsonKey(name: 'img', defaultValue: kDefaultImageName)
  final String imageName;
  final List<Quiz> quizzes;

  static const none = Topic(
    id: '',
    title: '',
    description: '',
    imageName: '',
    quizzes: [],
  );

  @override
  List<Object?> get props => [id, title, description, imageName, quizzes];

  factory Topic.fromJson(Map<String, dynamic> json) => _$TopicFromJson(json);
}

extension TopicExtensions on Topic {
  bool get isNone => this == Topic.none;
  bool get isNotNone => !isNone;

  int get totalQuizzes => quizzes.length;

  double completedProgress(int completedQuizzes) {
    if (totalQuizzes == 0) {
      return 0;
    }
    return completedQuizzes / totalQuizzes;
  }

  String progress(int completedQuizzes) {
    return '$completedQuizzes / $totalQuizzes';
  }
}
