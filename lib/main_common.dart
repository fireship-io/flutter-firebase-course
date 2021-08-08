import 'dart:async';
import 'dart:developer';

import 'package:assets_repository/assets_repository.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/app/app.dart';
import 'package:quizapp/shared/constants.dart';
import 'package:user_repository/user_repository.dart';

void mainCommon(AppEnvironment environment) {
  runZonedGuarded(
    () async {
      final bootstrapper = AppBootstrapper(environment: environment);
      await bootstrapper.bootstrapApp();

      final assetsRepository = AssetsRepository();
      await assetsRepository.preloadAssets(kCoversPath);

      final userRepository = FirebaseUserRepository();
      await userRepository.getOpeningUser();
      runApp(App(userRepository: userRepository));
    },
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
