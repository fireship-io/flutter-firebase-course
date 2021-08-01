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

  factory Quiz.fromJson(Map<String, dynamic> json) => _$QuizFromJson(json);

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
