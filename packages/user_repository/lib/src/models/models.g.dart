// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    uid: json['uid'] as String,
    completedQuizzes: (json['completedQuizzes'] as Map<String, dynamic>?)?.map(
          (k, e) => MapEntry(
              k, (e as List<dynamic>).map((e) => e as String).toList()),
        ) ??
        {},
    totalCompletedQuizzes: json['total'] as int? ?? 0,
    lastSignInAt: timestamp.fromJson(json['lastSignInAt']),
  );
}

Map<String, dynamic> _$UserToJson(User instance) {
  final val = <String, dynamic>{
    'uid': instance.uid,
    'completedQuizzes': instance.completedQuizzes,
    'total': instance.totalCompletedQuizzes,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('lastSignInAt', timestamp.toJson(instance.lastSignInAt));
  return val;
}
