import 'package:assets_repository/assets_repository.dart';
import 'package:quizapp/app/app.dart';
import 'package:quizapp/shared/constants.dart';
import 'package:user_repository/user_repository.dart';

void main() {
  bootstrap(
    () async {
      // ? initialize production dependencies
      final assetsRepository = AssetsRepository();
      await assetsRepository.preloadAssets(kCoversPath);

      final userRepository = FirebaseUserRepository();
      await userRepository.getOpeningUser();
      return App(userRepository: userRepository);
    },
  );
}
