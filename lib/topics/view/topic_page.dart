import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quizapp/topics/cubit/topics_cubit.dart';
import 'package:shared/shared.dart';
import 'package:topics_repository/topics_repository.dart';
import 'package:ui_toolkit/ui_toolkit.dart';
import 'package:user_repository/user_repository.dart';
import 'package:flow_builder/flow_builder.dart';

import 'package:quizapp/topics/view/topic_cover.dart';
import 'package:quizapp/topics/view/topics_flow.dart';

class TopicPage extends StatelessWidget {
  const TopicPage._({Key? key}) : super(key: key);

  static Page page({required Topic topic}) => MaterialPage<void>(
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
  const TopicImage({Key? key}) : super(key: key);

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
  const TopicTitle({Key? key}) : super(key: key);

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
  const QuizList({Key? key}) : super(key: key);

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
    Key? key,
    required this.quiz,
    required this.topicId,
  }) : super(key: key);

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
            style: context.textTheme.headline6,
          ),
          subtitle: Text(
            quiz.description,
            overflow: TextOverflow.fade,
            style: context.textTheme.subtitle1,
          ),
          leading: QuizBadge(quizId: quiz.id, topicId: topicId),
        ),
      ),
    );
  }
}

class QuizBadge extends StatelessWidget {
  const QuizBadge({
    Key? key,
    required this.quizId,
    required this.topicId,
  }) : super(key: key);

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
