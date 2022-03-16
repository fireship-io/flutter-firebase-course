import 'package:data_providers/data_providers.dart';
import 'package:topics_repository/src/failures.dart';
import 'package:topics_repository/src/models/models.dart';

part 'firebase_topics_repository.dart';

// ignore: one_member_abstracts
abstract class TopicsRepository {
  Future<List<Topic>> getTopics();
}
