import 'package:flutter/material.dart';
import 'package:quizapp/l10n/l10n.dart';
import 'package:quizapp/quiz/cubit/quiz_cubit.dart';
import 'package:shared/shared.dart';
import 'package:ui_toolkit/ui_toolkit.dart';

class CompleteView extends StatelessWidget {
  const CompleteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: kInsets / 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CongratsText(),
          Divider(),
          CongratsGif(),
          Divider(),
          CompleteQuizButton(),
        ],
      ),
    );
  }
}

class CongratsText extends StatelessWidget {
  const CongratsText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final quizTitle = context.select(
      (QuizCubit cubit) => cubit.state.quiz.title,
    );
    return Text(
      context.l10n.congratsMessage(quizTitle),
      textAlign: TextAlign.center,
    );
  }
}

class CongratsGif extends StatelessWidget {
  const CongratsGif({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Assets.congrats.image();
  }
}

class CompleteQuizButton extends StatelessWidget {
  const CompleteQuizButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ActionButton.icon(
      label: Text(context.l10n.markQuizCompletedButtonLabel),
      icon: const Icon(FontAwesomeIcons.check),
      backgroundColor: Colors.green,
      onPressed: () {
        final quizCubit = context.read<QuizCubit>();
        final quiz = quizCubit.state.quiz;
        quizCubit.markQuizCompleted(quizId: quiz.id, topicId: quiz.topic);
      },
    );
  }
}
