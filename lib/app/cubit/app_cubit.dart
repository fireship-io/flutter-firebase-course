import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';
import 'package:shared/shared.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit({
    required User openingUser,
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(openingUser.isNone
            ? const AppState.unauthenticated()
            : AppState.newlyAuthenticated(openingUser)) {
    _watchUser();
  }

  final UserRepository _userRepository;

  @override
  Future<void> close() async {
    await _unwatchUser();
    return super.close();
  }

  Future<void> logOut() async {
    try {
      await _userRepository.logOut();
    } on AppFailure catch (failure) {
      _onAppFailed(failure);
    }
  }

  void _onAuthChanged(User user) {
    if (user.isNone) {
      emit(const AppState.unauthenticated());
      return;
    }
    if (state.isUnauthenticated) {
      emit(AppState.newlyAuthenticated(user));
      return;
    }
    emit(AppState.authenticated(user));
  }

  void _onAppFailed(AppFailure failure) {
    emit(AppState.failure(failure: failure, user: state.user));
    if (failure.requiresReauthentication) {
      emit(const AppState.unauthenticated());
    }
  }

  late StreamSubscription? _userSub;
  void _watchUser() {
    _userSub = _userRepository.watchUser
        .handleFailure(_onAppFailed)
        .listen(_onAuthChanged);
  }

  FutureOr<void> _unwatchUser() {
    return _userSub?.cancel();
  }
}
