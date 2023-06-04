import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizapp/l10n/l10n.dart';
import 'package:quizapp/quiz/cubit/quiz_cubit.dart';
import 'package:ui_toolkit/ui_toolkit.dart';

class StartView extends StatelessWidget {
  const StartView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizCubit, QuizState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        if (state.isLoaded) {
          return const Padding(
            padding: kInsets,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                QuizTitle(),
                Divider(),
                QuizDescription(),
                QuizStartButton(),
              ],
            ),
          );
        }
        if (state.isEmpty) {
          return NoContent(context.l10n.noQuizDataMessage);
        }
        if (state.isFailure) {
          return FailureText(context.l10n.getQuizFailureMessage);
        }
        return const Loader();
      },
    );
  }
}

class QuizTitle extends StatelessWidget {
  const QuizTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final title = context.select((QuizCubit cubit) => cubit.state.quiz.title);
    return Text(title, style: context.textTheme.headlineSmall);
  }
}

class QuizDescription extends StatelessWidget {
  const QuizDescription({super.key});

  @override
  Widget build(BuildContext context) {
    final description =
        context.select((QuizCubit cubit) => cubit.state.quiz.description);
    return Expanded(child: Text(description));
  }
}

class QuizStartButton extends StatelessWidget {
  const QuizStartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ActionButton.icon(
      onPressed: context.read<QuizCubit>().incrementStep,
      icon: const Icon(Icons.poll),
      backgroundColor: QuizColors.green,
      label: Text(context.l10n.quizStartButtonLabel),
    );
  }
}
