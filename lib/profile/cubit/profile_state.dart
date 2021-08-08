part of 'profile_cubit.dart';

enum ProfileAction { none, logOut }

extension ProfileActionExtensions on ProfileAction {
  bool get isLogOut => this == ProfileAction.logOut;
}

class ProfileState extends Equatable {
  const ProfileState._({
    this.user = User.none,
    this.action = ProfileAction.none,
  });

  const ProfileState.initial() : this._();

  final User user;
  final ProfileAction action;

  @override
  List<Object> get props => [user, action];

  ProfileState copyWith({
    User? user,
    ProfileAction action = ProfileAction.none,
  }) {
    return ProfileState._(
      user: user ?? this.user,
      action: action,
    );
  }
}
