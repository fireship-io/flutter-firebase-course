import 'package:api_client/api_client.dart';
import 'package:json_annotation/json_annotation.dart';

const timestamp = _TimestampConverter._();

class _TimestampConverter implements JsonConverter<DateTime?, Object?> {
  const _TimestampConverter._();

  @override
  DateTime? fromJson(Object? json) {
    return (json as Timestamp?)?.toDate();
  }

  @override
  Object? toJson(DateTime? _) {
    return Timestamp.now();
  }
}
