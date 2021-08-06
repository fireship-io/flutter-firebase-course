import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizapp/quiz/cubit/quiz_cubit.dart';
import 'package:quizapp/quiz/view/widgets.dart';
import 'package:quizapp/shared/shared.dart';
import 'package:quizapp/l10n/l10n.dart';

class StartView extends StatelessWidget {
  const StartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizCubit, QuizState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        if (state.isLoaded) {
          return Padding(
            padding: kInsets,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: const [
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
          return Failure(context.l10n.getQuizFailureMessage);
        }
        return const Loader();
      },
    );
  }
}

class QuizTitle extends StatelessWidget {
  const QuizTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = context.select((QuizCubit cubit) => cubit.state.quiz.title);
    return Text(title, style: context.textTheme.headline5);
  }
}

class QuizDescription extends StatelessWidget {
  const QuizDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final description =
        context.select((QuizCubit cubit) => cubit.state.quiz.description);
    return Expanded(child: Text(description));
  }
}

class QuizStartButton extends StatelessWidget {
  const QuizStartButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QuizButton(
      onPressed: context.read<QuizCubit>().incrementStep,
      icon: const Icon(Icons.poll),
      backgroundColor: kGreen,
      label: Text(context.l10n.quizStartButtonLabel),
    );
  }
}
