import 'package:api_client/api_client.dart';
import 'package:quizzes_repository/src/failures.dart';
import 'package:quizzes_repository/src/models/models.dart';

class QuizzesRepository {
  QuizzesRepository({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  Future<Quiz> getQuiz(String quizId) async {
    try {
      final doc = await _firestore.quizDoc(quizId).get();
      if (doc.exists) {
        return Quiz.fromJson(doc.data()!);
      }
      return Quiz.empty;
    } on FirebaseException {
      throw QuizzesFailure.fromGetQuiz();
    }
  }
}
