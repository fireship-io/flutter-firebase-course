import 'package:cloud_firestore/cloud_firestore.dart';

extension FirebaseFirestoreExtensions on FirebaseFirestore {
  String createId() => collection('_').doc().id;

  CollectionReference<Map<String, dynamic>> reportsCollection() =>
      collection('reports');
  DocumentReference<Map<String, dynamic>> reportDoc(String reportId) =>
      reportsCollection().doc(reportId);

  CollectionReference<Map<String, dynamic>> quizzesCollection() =>
      collection('quizzes');
  DocumentReference<Map<String, dynamic>> quizDoc(String quizId) =>
      quizzesCollection().doc(quizId);

  CollectionReference<Map<String, dynamic>> topicsCollection() =>
      collection('topics');
  DocumentReference<Map<String, dynamic>> topicDoc(String topicId) =>
      topicsCollection().doc(topicId);
}
