// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Quiz _$QuizFromJson(Map<String, dynamic> json) => Quiz(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
);

Topic _$TopicFromJson(Map<String, dynamic> json) => Topic(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String? ?? '',
  imageName: json['img'] as String? ?? 'default-cover.png',
  quizzes:
      (json['quizzes'] as List<dynamic>)
          .map((e) => Quiz.fromJson(e as Map<String, dynamic>))
          .toList(),
);
