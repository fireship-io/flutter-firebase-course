import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';

import 'package:quizapp/app/app.dart';
import 'package:user_repository/user_repository.dart';

import 'app/app_bootstrapper.dart';
import 'app/app_environment.dart';

void mainCommon(AppEnvironment environment) {
  runZonedGuarded(
    () async {
      final bootstrapper = AppBootstrapper(environment: environment);
      await bootstrapper.bootstrapApp();

      final userRepository = FirebaseUserRepository();
      final openingUser = await userRepository.getOpeningUser();
      runApp(App(
        openingUser: openingUser,
        userRepository: userRepository,
      ));
    },
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
