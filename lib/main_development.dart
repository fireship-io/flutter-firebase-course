import 'package:quizapp/app/app.dart';
import 'package:quizapp/app/app_bloc_observer.dart';
import 'package:user_repository/user_repository.dart';

void main() {
  bootstrap(
    () async {
      // ? initialize development dependencies
      final userRepository = FirebaseUserRepository();
      await userRepository.getOpeningUser();
      return App(userRepository: userRepository);
    },
    blocObserver: AppBlocObserver(),
  );
}
