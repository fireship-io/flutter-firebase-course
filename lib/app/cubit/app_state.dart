part of 'app_cubit.dart';

enum AppStatus {
  unauthenticated,
  newlyAuthenticated,
  authenticated,
  failure,
}

extension AppStatusExtensions on AppStatus {
  bool get isUnauthenticated => this == AppStatus.unauthenticated;
  bool get isNewlyAuthenticated => this == AppStatus.newlyAuthenticated;
  bool get isAuthenticated => this == AppStatus.authenticated;
  bool get isFailure => this == AppStatus.failure;
}

class AppState extends Equatable {
  const AppState._({
    required this.status,
    this.user = User.none,
    this.failure = AppFailure.none,
  });

  const AppState.unauthenticated() : this._(status: AppStatus.unauthenticated);

  const AppState.newlyAuthenticated(User user)
      : this._(
          status: AppStatus.newlyAuthenticated,
          user: user,
        );

  const AppState.authenticated(User user)
      : this._(
          status: AppStatus.authenticated,
          user: user,
        );

  const AppState.failure({
    required AppFailure failure,
    required User user,
  }) : this._(
          status: AppStatus.failure,
          user: user,
          failure: failure,
        );

  final AppStatus status;
  final User user;
  final AppFailure failure;

  @override
  List<Object?> get props => [status, user, failure];
}

extension AppStateExtensions on AppState {
  bool get isUnauthenticated => status.isUnauthenticated;
  bool get isNewlyAuthenticated => status.isNewlyAuthenticated;
  bool get isAuthenticated => status.isAuthenticated;
  bool get isFailure => status.isFailure;
}
