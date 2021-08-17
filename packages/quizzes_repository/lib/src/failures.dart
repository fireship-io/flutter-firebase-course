import 'package:shared/shared.dart';

class QuizzesFailure extends Failure {
  const QuizzesFailure._();

  factory QuizzesFailure.fromGetQuiz() => const GetQuizFailure();

  static const none = QuizzesNoFailure();
}

class QuizzesNoFailure extends QuizzesFailure {
  const QuizzesNoFailure() : super._();
}

class GetQuizFailure extends QuizzesFailure {
  const GetQuizFailure() : super._();
}
