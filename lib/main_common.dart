import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';

import 'package:user_repository/user_repository.dart';

import 'app/app.dart';

void mainCommon(AppEnvironment environment) {
  runZonedGuarded(
    () async {
      final bootstrapper = AppBootstrapper(environment: environment);
      await bootstrapper.bootstrapApp();

      final userRepository = FirebaseUserRepository();
      await userRepository.getOpeningUser();
      runApp(App(userRepository: userRepository));
    },
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
