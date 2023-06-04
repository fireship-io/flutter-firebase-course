import 'package:api_client/api_client.dart';
import 'package:topics_repository/src/failures.dart';
import 'package:topics_repository/src/models/models.dart';

class TopicsRepository {
  TopicsRepository({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  Future<List<Topic>> getTopics() async {
    try {
      final snapshot = await _firestore.topicsCollection().get();
      return snapshot.docs.map((doc) => Topic.fromJson(doc.data())).toList();
    } on FirebaseException {
      throw TopicsFailure.fromGetTopics();
    }
  }
}
