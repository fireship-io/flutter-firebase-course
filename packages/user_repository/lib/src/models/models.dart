import 'package:data_sources/data_sources.dart' as firebase show User;
import 'package:shared/shared.dart';

part 'models.g.dart';

// ignore_for_file: sort_constructors_first

@JsonSerializable()
class User extends Equatable {
  const User({
    required this.uid,
    this.lastSignInAt,
  });

  factory User.fromFirebaseUser(firebase.User firebaseUser) =>
      User(uid: firebaseUser.uid);

  final String uid;
  @timestamp
  final DateTime? lastSignInAt;

  static const none = User(uid: '');

  @override
  List<Object?> get props => [uid, lastSignInAt];

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

extension UserExtensions on User {
  bool get isNone => this == User.none;
}
