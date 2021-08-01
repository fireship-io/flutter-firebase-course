import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared/shared.dart';
import 'package:topics_repository/topics_repository.dart';
import 'package:user_repository/user_repository.dart';

part 'topics_state.dart';

class TopicsCubit extends Cubit<TopicsState> {
  TopicsCubit({
    required UserRepository userRepository,
    required TopicsRepository topicsRepository,
  })  : _userRepository = userRepository,
        _topicsRepository = topicsRepository,
        super(const TopicsState.initial()) {
    _watchUser();
  }

  final UserRepository _userRepository;
  final TopicsRepository _topicsRepository;

  @override
  Future<void> close() async {
    await _unwatchUser();
    return super.close();
  }

  Future<void> getTopics() async {
    try {
      emit(state.fromTopicsLoading());
      final topics = await _topicsRepository.getTopics();
      if (topics.isEmpty) {
        emit(state.fromTopicsEmpty());
        return;
      }
      emit(state.fromTopicsLoaded(topics));
    } on TopicsFailure catch (failure) {
      emit(state.fromTopicsFailure(failure));
    }
  }

  void _onUserChanged(User user) {
    emit(state.fromUser(user));
  }

  late final StreamSubscription _userSubscription;
  void _watchUser() {
    _userSubscription = _userRepository.watchUser
        // user/auth failures are handled by the AppCubit
        .handleFailure(null)
        .listen(_onUserChanged);
  }

  Future<void> _unwatchUser() {
    return _userSubscription.cancel();
  }
}

extension _TopicsStateExtensions on TopicsState {
  TopicsState fromUser(User user) => copyWith(user: user);

  TopicsState fromTopicsLoading() => copyWith(status: TopicsStatus.loading);

  TopicsState fromTopicsEmpty() => copyWith(status: TopicsStatus.empty);

  TopicsState fromTopicsLoaded(List<Topic> topics) => copyWith(
        status: TopicsStatus.loaded,
        topics: topics,
      );

  TopicsState fromTopicsFailure(TopicsFailure failure) => copyWith(
        status: TopicsStatus.failure,
        failure: failure,
      );
}
