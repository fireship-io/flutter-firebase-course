import 'package:app_core/app_core.dart';

part 'models.g.dart';

@JsonSerializable(createToJson: false)
class Quiz extends Equatable {
  const Quiz({
    required this.id,
    required this.title,
    required this.description,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) => _$QuizFromJson(json);

  final String id;
  final String title;
  final String description;

  static const empty = Quiz(
    id: '',
    title: '',
    description: '',
  );

  @override
  List<Object?> get props => [id, title, description];
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

  factory Topic.fromJson(Map<String, dynamic> json) => _$TopicFromJson(json);

  final String id;
  final String title;
  @JsonKey(defaultValue: '')
  final String description;
  @JsonKey(name: 'img', defaultValue: 'default-cover.png')
  final String imageName;
  final List<Quiz> quizzes;

  static const empty = Topic(
    id: '',
    title: '',
    description: '',
    imageName: '',
    quizzes: [],
  );

  @override
  List<Object?> get props => [id, title, description, imageName, quizzes];
}

extension TopicExtensions on Topic {
  bool get isEmpty => this == Topic.empty;
  bool get isNotEmpty => !isEmpty;

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
