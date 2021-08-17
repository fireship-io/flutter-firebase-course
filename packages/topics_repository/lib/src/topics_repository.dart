import 'package:data_providers/data_providers.dart';
import 'package:topics_repository/src/failures.dart';
import 'package:topics_repository/src/models/models.dart';

part 'firebase_topics_repository.dart';

abstract class TopicsRepository {
  Future<List<Topic>> getTopics();
}
