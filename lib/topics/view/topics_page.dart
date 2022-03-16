import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizapp/l10n/l10n.dart';
import 'package:quizapp/topics/cubit/topics_cubit.dart';
import 'package:quizapp/topics/view/topic_cover.dart';
import 'package:quizapp/topics/view/topics_flow.dart';
import 'package:topics_repository/topics_repository.dart';
import 'package:ui_toolkit/ui_toolkit.dart';
import 'package:user_repository/user_repository.dart';

class TopicsPage extends StatelessWidget {
  const TopicsPage._({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: TopicsPage._());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.topicsLabel),
        backgroundColor: QuizColors.deepPurple,
      ),
      body: const TopicsGrid(),
    );
  }
}

class TopicsGrid extends StatelessWidget {
  const TopicsGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopicsCubit, TopicsState>(
      builder: (_, state) {
        if (state.isLoaded) {
          final topics = state.topics;
          const insetsValue = 20.0;
          const insets = EdgeInsets.all(insetsValue);
          const spacing = insetsValue / 2;
          return GridView.count(
            primary: false,
            padding: insets,
            crossAxisSpacing: spacing,
            mainAxisSpacing: spacing,
            crossAxisCount: 2,
            children: [for (final topic in topics) TopicItem(topic: topic)],
          );
        }
        if (state.isEmpty) {
          return NoContent(context.l10n.noTopicsMessage);
        }
        if (state.isFailure) {
          return FailureText(context.l10n.getTopicsFailureMessage);
        }
        return const Loader();
      },
    );
  }
}

class TopicItem extends StatelessWidget {
  const TopicItem({Key? key, required this.topic}) : super(key: key);

  final Topic topic;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: topic.id,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => context.flow<TopicsFlowState>().selectTopic(topic),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TopicCover(topic.imageName),
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Text(
                          topic.title,
                          style: const TextStyle(
                            height: 1.5,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.fade,
                          softWrap: false,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: TopicProgress(
                  topic: topic,
                  quizCount: context.select(
                    (TopicsCubit cubit) =>
                        cubit.state.user.totalCompletedQuizzesByTopic(topic.id),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TopicProgress extends StatelessWidget {
  const TopicProgress({
    Key? key,
    required this.topic,
    required this.quizCount,
  }) : super(key: key);

  final Topic topic;
  final int quizCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 8),
        Text(
          topic.progress(quizCount),
          style: const TextStyle(fontSize: 10, color: QuizColors.grey),
        ),
        Expanded(
          child: AnimatedProgressBar.mini(
            value: topic.completedProgress(quizCount),
          ),
        ),
      ],
    );
  }
}
