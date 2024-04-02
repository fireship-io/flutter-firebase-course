part of 'topics_cubit.dart';

enum TopicsStatus { initial, loading, empty, loaded, failure }

final class TopicsState extends Equatable {
  const TopicsState._({
    this.user = User.empty,
    this.status = TopicsStatus.initial,
    this.topics = const [],
    this.failure = TopicsFailure.empty,
  });

  const TopicsState.initial() : this._();

  final User user;
  final TopicsStatus status;
  final List<Topic> topics;
  final TopicsFailure failure;

  @override
  List<Object> get props => [user, status, topics, failure];

  TopicsState copyWith({
    User? user,
    TopicsStatus? status,
    List<Topic>? topics,
    TopicsFailure? failure,
  }) {
    return TopicsState._(
      user: user ?? this.user,
      status: status ?? this.status,
      topics: topics ?? this.topics,
      failure: failure ?? this.failure,
    );
  }
}

extension TopicsStateExtensions on TopicsState {
  bool get isInitial => status == TopicsStatus.initial;
  bool get isLoading => status == TopicsStatus.loading;
  bool get isEmpty => status == TopicsStatus.empty;
  bool get isLoaded => status == TopicsStatus.loaded;
  bool get isFailure => status == TopicsStatus.failure;
}
