import 'package:app_core/app_core.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizapp/quiz/cubit/quiz_cubit.dart';
import 'package:quizapp/quiz/view/complete_view.dart';
import 'package:quizapp/quiz/view/question_view.dart';
import 'package:quizapp/quiz/view/start_view.dart';
import 'package:quizzes_repository/quizzes_repository.dart';
import 'package:user_repository/user_repository.dart';

class QuizPage extends StatelessWidget {
  const QuizPage._({
    required this.quizId,
    required this.onQuizCompleted,
  });

  static const name = '/quizpage';
  static Page<void> page({
    required String quizId,
    required VoidCallback onQuizCompleted,
  }) =>
      MaterialPage<void>(
        key: const ValueKey('quiz_page'),
        fullscreenDialog: true,
        name: name,
        child: QuizPage._(quizId: quizId, onQuizCompleted: onQuizCompleted),
      );

  final String quizId;
  final VoidCallback onQuizCompleted;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => QuizCubit(
        userRepository: context.read<UserRepository>(),
        quizzesRepository: QuizzesRepository(),
      )..getQuiz(quizId),
      child: Provider.value(
        value: onQuizCompleted,
        child: const QuizView(),
      ),
    );
  }
}

class QuizView extends StatelessWidget {
  const QuizView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const QuizProgressBar(),
      ),
      body: const QuizBody(),
    );
  }
}

class QuizBody extends StatefulWidget {
  const QuizBody({super.key});

  @override
  State<QuizBody> createState() => _QuizBodyState();
}

class _QuizBodyState extends State<QuizBody> {
  late final PageController _controller;

  @override
  void initState() {
    _controller = PageController(
      initialPage: context.read<QuizCubit>().state.step,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<QuizCubit, QuizState>(
          listenWhen: (previous, current) =>
              previous.quiz.id != current.quiz.id,
          listener: (_, state) {
            if (state.quiz.isNone) {
              context.read<VoidCallback>()();
            }
          },
        ),
        BlocListener<QuizCubit, QuizState>(
          listenWhen: (previous, current) => previous.step != current.step,
          listener: (_, state) {
            _controller.animateToPage(
              state.step,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOut,
            );
          },
        ),
        BlocListener<QuizCubit, QuizState>(
          listenWhen: (previous, current) =>
              previous.selectedOption != current.selectedOption,
          listener: (_, state) {
            if (state.selectedOption.isNotNone) {
              context.showScrollControlledBottomSheet<void>(
                builder: (_) {
                  return BlocProvider.value(
                    value: context.watch<QuizCubit>(),
                    child: const QuizAnswerDetails(),
                  );
                },
              ).whenComplete(() => context.read<QuizCubit>().unselectOption());
            } else {
              context.popUntil((route) => route.settings.name == QuizPage.name);
            }
          },
        ),
      ],
      child: BlocBuilder<QuizCubit, QuizState>(
        buildWhen: (previous, current) => previous.steps != current.steps,
        builder: (_, state) {
          return PageView.builder(
            controller: _controller,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (_, index) {
              if (index == 0) {
                return const StartView();
              }
              if (index == state.steps) {
                return const CompleteView();
              }
              return QuestionView(step: index);
            },
          );
        },
      ),
    );
  }
}

class QuizProgressBar extends StatelessWidget {
  const QuizProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    final progress = context.select((QuizCubit cubit) => cubit.state.progress);
    return AnimatedProgressBar(value: progress);
  }
}
