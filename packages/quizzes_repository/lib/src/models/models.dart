import 'package:app_core/app_core.dart';

part 'models.g.dart';

@JsonSerializable(createToJson: false)
class Option extends Equatable {
  const Option({
    required this.value,
    required this.detail,
    required this.correct,
  });

  factory Option.fromJson(Map<String, dynamic> json) => _$OptionFromJson(json);

  final String value;
  @JsonKey(defaultValue: '')
  final String detail;
  final bool? correct;

  static const empty = Option(value: '', detail: '', correct: null);

  @override
  List<Object?> get props => [value, detail, correct];
}

extension OptionExtensions on Option {
  bool get isNotEmpty => this != Option.empty;
}

@JsonSerializable(createToJson: false)
class Question extends Equatable {
  const Question({
    required this.text,
    required this.options,
  });

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);

  final String text;
  @JsonKey(defaultValue: <Option>[])
  final List<Option> options;

  static const empty = Question(text: '', options: []);

  @override
  List<Object?> get props => [text, options];
}

@JsonSerializable(createToJson: false)
class Quiz extends Equatable {
  const Quiz({
    required this.id,
    required this.title,
    required this.description,
    required this.topic,
    required this.video,
    required this.questions,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) => _$QuizFromJson(json);

  final String id;
  final String title;
  final String description;
  final String topic;
  @JsonKey(defaultValue: '')
  final String video;
  @JsonKey(defaultValue: <Question>[])
  final List<Question> questions;

  static const empty = Quiz(
    id: '',
    title: '',
    description: '',
    topic: '',
    video: '',
    questions: [],
  );

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        topic,
        video,
        questions,
      ];
}

extension QuizExtensions on Quiz {
  bool get isEmpty => this == Quiz.empty;
}
