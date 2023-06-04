import 'package:app_core/app_core.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/topics/cubit/topics_cubit.dart';
import 'package:quizapp/topics/view/topic_cover.dart';
import 'package:quizapp/topics/view/topics_flow.dart';
import 'package:topics_repository/topics_repository.dart';
import 'package:user_repository/user_repository.dart';

class TopicPage extends StatelessWidget {
  const TopicPage._();

  static Page<void> page({required Topic topic}) => MaterialPage<void>(
        key: const ValueKey('topic_page'),
        child: Provider.value(
          value: topic,
          child: const TopicPage._(),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.flow<TopicsFlowState>().deselectTopic();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: QuizColors.transparent,
          leading: BackButton(
            onPressed: () {
              context.flow<TopicsFlowState>().deselectTopic();
            },
          ),
        ),
        body: ListView(
          children: const [
            TopicImage(),
            TopicTitle(),
            QuizList(),
          ],
        ),
      ),
    );
  }
}

class TopicImage extends StatelessWidget {
  const TopicImage({super.key});

  @override
  Widget build(BuildContext context) {
    final topicId = context.select((Topic topic) => topic.id);
    final imageName = context.select((Topic topic) => topic.imageName);
    return Hero(
      tag: topicId,
      child: TopicCover(imageName),
    );
  }
}

class TopicTitle extends StatelessWidget {
  const TopicTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final title = context.select((Topic topic) => topic.title);
    return Text(
      title,
      style: const TextStyle(
        height: 2,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class QuizList extends StatelessWidget {
  const QuizList({super.key});

  @override
  Widget build(BuildContext context) {
    final topicId = context.select((Topic topic) => topic.id);
    final quizzes = context.select((Topic topic) => topic.quizzes);
    return Column(
      children: [
        for (final quiz in quizzes) QuizItem(quiz: quiz, topicId: topicId)
      ],
    );
  }
}

class QuizItem extends StatelessWidget {
  const QuizItem({
    required this.quiz,
    required this.topicId,
    super.key,
  });

  final Quiz quiz;
  final String topicId;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const ContinuousRectangleBorder(),
      elevation: 4,
      margin: const EdgeInsets.all(4),
      child: InkWell(
        onTap: () {
          context.flow<TopicsFlowState>().selectQuiz(quiz.id);
        },
        child: ListTile(
          title: Text(
            quiz.title,
            style: context.textTheme.titleLarge,
          ),
          subtitle: Text(
            quiz.description,
            overflow: TextOverflow.fade,
            style: context.textTheme.titleMedium,
          ),
          leading: QuizBadge(quizId: quiz.id, topicId: topicId),
        ),
      ),
    );
  }
}

class QuizBadge extends StatelessWidget {
  const QuizBadge({
    required this.quizId,
    required this.topicId,
    super.key,
  });

  final String quizId;
  final String topicId;

  @override
  Widget build(BuildContext context) {
    final user = context.select((TopicsCubit cubit) => cubit.state.user);
    if (user.hasCompletedQuiz(quizId: quizId, topicId: topicId)) {
      return const Icon(FontAwesomeIcons.checkDouble, color: Colors.green);
    }
    return const Icon(FontAwesomeIcons.solidCircle, color: Colors.grey);
  }
}
