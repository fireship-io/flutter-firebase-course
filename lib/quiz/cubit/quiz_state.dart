part of 'quiz_cubit.dart';

enum QuizStatus { initial, loading, empty, loaded, failure }

final class QuizState extends Equatable {
  const QuizState._({
    this.status = QuizStatus.initial,
    this.quiz = Quiz.none,
    this.selectedOption = Option.empty,
    this.step = 0,
    this.failure = QuizzesFailure.empty,
  });

  const QuizState.initial() : this._();

  final QuizStatus status;
  final Quiz quiz;
  final Option selectedOption;
  // step is in range [0..quiz.questions.length + 1]
  // 0 = start page
  // + 1 = congrats page
  final int step;
  final QuizzesFailure failure;

  @override
  List<Object> get props => [
        status,
        quiz,
        selectedOption,
        step,
        failure,
      ];

  QuizState copyWith({
    QuizStatus? status,
    Quiz? quiz,
    Option? selectedOption,
    int? step,
    QuizzesFailure? failure,
  }) {
    return QuizState._(
      status: status ?? this.status,
      quiz: quiz ?? this.quiz,
      selectedOption: selectedOption ?? this.selectedOption,
      step: step ?? this.step,
      failure: failure ?? this.failure,
    );
  }
}

extension QuizStateExtensions on QuizState {
  bool get isEmpty => status == QuizStatus.empty;
  bool get isLoaded => status == QuizStatus.loaded;
  bool get isFailure => status == QuizStatus.failure;

  int get steps => quiz.questions.length + 1;
  double get progress => step / steps;

  Question operator [](int step) =>
      quiz.questions.isEmpty ? Question.none : quiz.questions[step - 1];
}
