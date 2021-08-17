import 'package:quizapp/app/app.dart';
import 'package:user_repository/user_repository.dart';

void main() {
  bootstrap(
    () async {
      // ? initialize production dependencies
      final userRepository = FirebaseUserRepository();
      await userRepository.getOpeningUser();
      return App(userRepository: userRepository);
    },
  );
}
