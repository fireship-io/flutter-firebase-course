import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';
import 'package:topics_repository/topics_repository.dart';
import 'package:user_repository/user_repository.dart';

import 'package:quizapp/quiz/quiz.dart';
import 'package:quizapp/topics/cubit/topics_cubit.dart';
import 'package:quizapp/topics/view/topic_page.dart';
import 'package:quizapp/topics/view/topics_page.dart';

List<Page> onGenerateTopicsPages(
  TopicsFlowState state,
  List<Page<dynamic>> pages, {
  required VoidCallback onQuizCompleted,
}) {
  return [
    TopicsPage.page(),
    if (state.hasTopicSelected) TopicPage.page(topic: state.selectedTopic),
    if (state.hasQuizSelected)
      QuizPage.page(
        quizId: state.selectedQuizId,
        onQuizCompleted: onQuizCompleted,
      ),
  ];
}

class TopicsFlowState extends Equatable {
  const TopicsFlowState._({
    this.selectedTopic = Topic.none,
    this.selectedQuizId = '',
  });

  const TopicsFlowState.initial() : this._();

  final Topic selectedTopic;
  final String selectedQuizId;

  bool get hasTopicSelected => selectedTopic.isNotNone;
  bool get hasQuizSelected => selectedQuizId.isNotEmpty;

  @override
  List<Object?> get props => [selectedTopic, selectedQuizId];

  TopicsFlowState withTopicDeselected() => const TopicsFlowState.initial();

  TopicsFlowState withTopicSelected(Topic selectedTopic) =>
      copyWith(selectedTopic: selectedTopic);

  TopicsFlowState withQuizSelected(String selectedQuizId) =>
      copyWith(selectedQuizId: selectedQuizId);

  TopicsFlowState copyWith({
    Topic? selectedTopic,
    String? selectedQuizId,
  }) {
    return TopicsFlowState._(
      selectedTopic: selectedTopic ?? this.selectedTopic,
      selectedQuizId: selectedQuizId ?? this.selectedQuizId,
    );
  }
}

extension TopicsFlowControllerExtensions on FlowController<TopicsFlowState> {
  void deselectTopic() => update(
        (state) => state.withTopicDeselected(),
      );

  void selectTopic(Topic topic) => update(
        (state) => state.withTopicSelected(topic),
      );

  void selectQuiz(String quizId) => update(
        (state) => state.withQuizSelected(quizId),
      );
}

class TopicsFlow extends StatefulWidget {
  const TopicsFlow({Key? key}) : super(key: key);

  @override
  _TopicsFlowState createState() => _TopicsFlowState();
}

class _TopicsFlowState extends State<TopicsFlow>
    with AutomaticKeepAliveClientMixin {
  late final FlowController<TopicsFlowState> _controller;

  @override
  void initState() {
    super.initState();
    _controller = FlowController(const TopicsFlowState.initial());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (_) => TopicsCubit(
        userRepository: context.read<UserRepository>(),
        topicsRepository: FirebaseTopicsRepository(),
      )..getTopics(),
      child: FlowBuilder<TopicsFlowState>(
        controller: _controller,
        onGeneratePages: (state, pages) => onGenerateTopicsPages(
          state,
          pages,
          onQuizCompleted: _controller.deselectTopic,
        ),
        observers: [HeroController()],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
