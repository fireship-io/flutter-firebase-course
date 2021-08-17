import 'package:shared/shared.dart';

class TopicsFailure extends Failure {
  const TopicsFailure._();

  factory TopicsFailure.fromGetTopics() => const GetTopicsFailure();

  static const none = TopicsNoFailure();
}

class TopicsNoFailure extends TopicsFailure {
  const TopicsNoFailure() : super._();
}

class GetTopicsFailure extends TopicsFailure {
  const GetTopicsFailure() : super._();
}
