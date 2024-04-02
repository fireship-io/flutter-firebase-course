import 'package:app_core/app_core.dart';

class TopicsFailure extends Failure {
  const TopicsFailure._();

  factory TopicsFailure.fromGetTopics() => const GetTopicsFailure();

  static const empty = EmptyTopicsFailure();
}

class EmptyTopicsFailure extends TopicsFailure {
  const EmptyTopicsFailure() : super._();
}

class GetTopicsFailure extends TopicsFailure {
  const GetTopicsFailure() : super._();
}
