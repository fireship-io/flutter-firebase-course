import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizapp/topics/cubit/topics_cubit.dart';
import 'package:shared/shared.dart';
import 'package:topics_repository/topics_repository.dart';
import 'package:user_repository/user_repository.dart';

import 'topic_page.dart';
import 'topics_page.dart';

List<Page> onGenerateTopicsPages(
  TopicsFlowState state,
  List<Page<dynamic>> pages,
) {
  return [
    TopicsPage.page(),
    if (state.hasTopicSelected) TopicPage.page(topic: state.selectedTopic),
  ];
}

class TopicsFlowState extends Equatable {
  const TopicsFlowState._({
    required this.selectedTopic,
  });

  const TopicsFlowState.withTopicDeselected()
      : this._(selectedTopic: Topic.none);

  const TopicsFlowState.withTopicSelected(Topic selectedTopic)
      : this._(selectedTopic: selectedTopic);

  final Topic selectedTopic;

  @override
  List<Object?> get props => [selectedTopic];

  bool get hasTopicSelected => selectedTopic.isNotNone;
}

extension TopicsFlowControllerExtensions on FlowController<TopicsFlowState> {
  void selectTopic(Topic topic) => update(
        (_) => TopicsFlowState.withTopicSelected(topic),
      );

  void deselectTopic() => update(
        (_) => const TopicsFlowState.withTopicDeselected(),
      );
}

class TopicsFlow extends StatefulWidget {
  const TopicsFlow({Key? key}) : super(key: key);

  @override
  _TopicsFlowState createState() => _TopicsFlowState();
}

class _TopicsFlowState extends State<TopicsFlow>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (_) => TopicsCubit(
        userRepository: context.read<UserRepository>(),
        topicsRepository: FirebaseTopicsRepository(),
      )..getTopics(),
      child: const TopicsFlowBuilder(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class TopicsFlowBuilder extends StatelessWidget {
  const TopicsFlowBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlowBuilder<TopicsFlowState>(
      state: const TopicsFlowState.withTopicDeselected(),
      onGeneratePages: onGenerateTopicsPages,
      observers: [HeroController()],
    );
  }
}
