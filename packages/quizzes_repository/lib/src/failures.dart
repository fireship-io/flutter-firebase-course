import 'package:app_core/app_core.dart';

class QuizzesFailure extends Failure {
  const QuizzesFailure._();

  factory QuizzesFailure.fromGetQuiz() => const GetQuizFailure();

  static const empty = EmptyQuizzesFailure();
}

class EmptyQuizzesFailure extends QuizzesFailure {
  const EmptyQuizzesFailure() : super._();
}

class GetQuizFailure extends QuizzesFailure {
  const GetQuizFailure() : super._();
}
