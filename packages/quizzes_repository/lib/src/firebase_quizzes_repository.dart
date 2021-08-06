part of 'quizzes_repository.dart';

class FirebaseQuizzesRepository implements QuizzesRepository {
  FirebaseQuizzesRepository({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  @override
  Future<Quiz> getQuiz(String quizId) async {
    try {
      final doc = await _firestore.quizDoc(quizId).get();
      if (doc.exists) {
        return Quiz.fromJson(doc.data()!);
      }
      return Quiz.none;
    } on FirebaseException {
      throw QuizzesFailure.fromGetQuiz();
    }
  }
}
