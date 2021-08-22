import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'package:shared/shared.dart';

class ProfileCubit extends Cubit<User> {
  ProfileCubit({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(User.none) {
    _watchUser();
  }

  final UserRepository _userRepository;

  @override
  Future<void> close() async {
    await _unwatchUser();
    return super.close();
  }

  void _onUserChanged(User user) => emit(user);

  late final StreamSubscription _userSubscription;
  void _watchUser() {
    _userSubscription = _userRepository.watchUser
        // user/auth failures are handled by the AppCubit
        .handleFailure()
        .listen(_onUserChanged);
  }

  Future<void> _unwatchUser() {
    return _userSubscription.cancel();
  }
}
