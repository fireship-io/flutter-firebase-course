// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Option _$OptionFromJson(Map<String, dynamic> json) {
  return Option(
    value: json['value'] as String,
    detail: json['detail'] as String? ?? '',
    correct: json['correct'] as bool?,
  );
}

Question _$QuestionFromJson(Map<String, dynamic> json) {
  return Question(
    text: json['text'] as String,
    options: (json['options'] as List<dynamic>?)
            ?.map((e) => Option.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
  );
}

Quiz _$QuizFromJson(Map<String, dynamic> json) {
  return Quiz(
    id: json['id'] as String,
    title: json['title'] as String,
    description: json['description'] as String,
    topic: json['topic'] as String,
    video: json['video'] as String? ?? '',
    questions: (json['questions'] as List<dynamic>?)
            ?.map((e) => Question.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
  );
}
