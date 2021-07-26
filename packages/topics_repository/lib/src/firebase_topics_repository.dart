part of 'topics_repository.dart';

class FirebaseTopicsRepository implements TopicsRepository {
  FirebaseTopicsRepository({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  @override
  Future<List<Topic>> getTopics() async {
    try {
      final snapshot = await _firestore.topicsCollection().get();
      return snapshot.docs.map((doc) => Topic.fromJson(doc.data())).toList();
    } on FirebaseException {
      throw TopicsFailure.fromGetTopics();
    }
  }
}
