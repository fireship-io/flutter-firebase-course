import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';

import 'package:quizapp/app/app.dart';

import 'app/app_bootstrapper.dart';
import 'app/app_environment.dart';

void mainCommon(AppEnvironment environment) {
  runZonedGuarded(
    () async {
      final bootstrapper = AppBootstrapper(environment: environment);
      await bootstrapper.bootstrapApp();

      runApp(const App());
    },
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
