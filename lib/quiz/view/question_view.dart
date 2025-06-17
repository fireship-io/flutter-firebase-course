import 'package:app_core/app_core.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizapp/l10n/l10n.dart';
import 'package:quizapp/quiz/cubit/quiz_cubit.dart';
import 'package:quizzes_repository/quizzes_repository.dart';

class QuestionView extends StatelessWidget {
  const QuestionView({required this.step, super.key});

  final int step;

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: step,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          QuestionText(),
          QuestionOptions(),
        ],
      ),
    );
  }
}

class QuestionText extends StatelessWidget {
  const QuestionText({super.key});

  @override
  Widget build(BuildContext context) {
    final step = context.read<int>();
    return Flexible(
      child: Container(
        padding: kInsets / 2,
        alignment: Alignment.topCenter,
        child: BlocBuilder<QuizCubit, QuizState>(
          buildWhen: (previous, current) =>
              previous[step].text != current[step].text,
          builder: (_, state) {
            final questionText = state[step].text;
            return Text(questionText);
          },
        ),
      ),
    );
  }
}

class QuestionOptions extends StatelessWidget {
  const QuestionOptions({super.key});

  @override
  Widget build(BuildContext context) {
    final step = context.read<int>();
    return Padding(
      padding: kInsets,
      child: BlocBuilder<QuizCubit, QuizState>(
        buildWhen: (previous, current) =>
            previous[step].options != current[step].options,
        builder: (_, state) {
          final options = state[step].options;
          return ListView.separated(
            itemCount: options.length,
            itemBuilder: (_, index) {
              return OptionItem(option: options[index]);
            },
            separatorBuilder: (_, _) => const SizedBox(height: 10),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
          );
        },
      ),
    );
  }
}

class OptionItem extends StatelessWidget {
  const OptionItem({required this.option, super.key});

  final Option option;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: OptionIcon(option: option),
      title: Text(
        option.value,
        style: context.textTheme.bodyLarge,
      ),
      tileColor: Colors.black26,
      contentPadding: kInsets / 2,
      onTap: () => context.read<QuizCubit>().selectOption(option),
    );
  }
}

class OptionIcon extends StatelessWidget {
  const OptionIcon({required this.option, super.key});

  final Option option;

  @override
  Widget build(BuildContext context) {
    final selectedOption = context.select(
      (QuizCubit cubit) => cubit.state.selectedOption,
    );
    return Icon(
      selectedOption == option
          ? FontAwesomeIcons.circleUser
          : FontAwesomeIcons.circle,
      size: 30,
    );
  }
}

class QuizAnswerDetails extends StatelessWidget {
  const QuizAnswerDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final option = context.select(
      (QuizCubit cubit) => cubit.state.selectedOption,
    );
    final correct = option.correct;
    final l10n = context.l10n;
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: correct != null
          ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 32,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      correct
                          ? l10n.correctAnswerMessage
                          : l10n.wrongAnswerMessage,
                    ),
                    Text(
                      option.detail,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white54,
                      ),
                    ),
                    ActionButton(
                      onPressed: () {
                        context.read<QuizCubit>().validateAnswer();
                      },
                      backgroundColor: correct ? Colors.green : Colors.red,
                      label: Text(
                        correct
                            ? l10n.correctQuizButtonLabel
                            : l10n.wrongQuizButtonLabel,
                        style: const TextStyle(
                          color: Colors.white,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
