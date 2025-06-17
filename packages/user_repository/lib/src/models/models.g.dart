// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
  uid: json['uid'] as String,
  displayName: json['displayName'] as String? ?? '',
  photoURL: json['photoURL'] as String? ?? '',
  email: json['email'] as String? ?? '',
  completedQuizzes:
      (json['completedQuizzes'] as Map<String, dynamic>?)?.map(
        (k, e) =>
            MapEntry(k, (e as List<dynamic>).map((e) => e as String).toList()),
      ) ??
      {},
  totalCompletedQuizzes: (json['total'] as num?)?.toInt() ?? 0,
  lastSignInAt: timestamp.fromJson(json['lastSignInAt']),
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'uid': instance.uid,
  'displayName': instance.displayName,
  'photoURL': instance.photoURL,
  'email': instance.email,
  'completedQuizzes': instance.completedQuizzes,
  'total': instance.totalCompletedQuizzes,
  if (timestamp.toJson(instance.lastSignInAt) case final value?)
    'lastSignInAt': value,
};
