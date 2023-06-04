import 'package:app_core/app_core.dart';
import 'package:quizzes_repository/quizzes_repository.dart';
import 'package:user_repository/user_repository.dart';

part 'quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  QuizCubit({
    required UserRepository userRepository,
    required QuizzesRepository quizzesRepository,
  })  : _userRepository = userRepository,
        _quizzesRepository = quizzesRepository,
        super(const QuizState.initial());

  final UserRepository _userRepository;
  final QuizzesRepository _quizzesRepository;

  Future<void> getQuiz(String quizId) async {
    try {
      emit(state.fromQuizLoading());
      final quiz = await _quizzesRepository.getQuiz(quizId);
      if (quiz.isNone) {
        emit(state.fromQuizEmpty());
        return;
      }
      emit(state.fromQuizLoaded(quiz));
    } on QuizzesFailure catch (failure) {
      emit(state.fromQuizFailure(failure));
    }
  }

  void incrementStep() {
    emit(state.copyWith(step: state.step + 1));
  }

  void selectOption(Option option) {
    emit(state.copyWith(selectedOption: option));
  }

  void unselectOption() {
    emit(state.copyWith(selectedOption: Option.none));
  }

  void validateAnswer() {
    final correct = state.selectedOption.correct!;
    if (correct) {
      incrementStep();
    }
    unselectOption();
  }

  void markQuizCompleted({
    required String quizId,
    required String topicId,
  }) {
    final hasCompletedQuiz =
        _userRepository.user.hasCompletedQuiz(quizId: quizId, topicId: topicId);
    if (!hasCompletedQuiz) {
      unawaited(
        _userRepository.markQuizCompleted(
          quizId: quizId,
          topicId: topicId,
        ),
      );
    }
    emit(const QuizState.initial());
  }
}

extension _TopicsStateExtensions on QuizState {
  QuizState fromQuizLoading() => copyWith(status: QuizStatus.loading);

  QuizState fromQuizEmpty() => copyWith(status: QuizStatus.empty);

  QuizState fromQuizLoaded(Quiz quiz) => copyWith(
        status: QuizStatus.loaded,
        quiz: quiz,
      );

  QuizState fromQuizFailure(QuizzesFailure failure) => copyWith(
        status: QuizStatus.failure,
        failure: failure,
      );
}
