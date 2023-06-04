import 'package:api_client/api_client.dart';
import 'package:quizapp/app/app.dart';
import 'package:user_repository/user_repository.dart';

Future<void> main() async {
  await bootstrap(
    init: Firebase.initializeApp,
    builder: () async {
      // ? initialize development dependencies
      final userRepository = UserRepository();
      await userRepository.getOpeningUser();
      return App(userRepository: userRepository);
    },
  );
}
