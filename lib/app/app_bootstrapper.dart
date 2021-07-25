import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:data_providers/data_providers.dart';
import 'package:flutter/material.dart';

import 'app_bloc_observer.dart';
import 'app_environment.dart';

/// {@template app_bootstrapper}
/// Used for initializations/configurations before running the app.
///
/// Use the `environment` for flavor based initializations/configurations.
/// {@endtemplate}
class AppBootstrapper {
  /// {@macro app_bootstrapper}
  const AppBootstrapper({
    // ignore: avoid_unused_constructor_parameters
    required AppEnvironment environment,
  });

  Future<void> bootstrapApp() {
    _configureFlutter();
    Bloc.observer = AppBlocObserver();
    return Firebase.initializeApp();
  }

  void _configureFlutter() {
    FlutterError.onError = (details) {
      log(details.exceptionAsString(), stackTrace: details.stack);
    };
    WidgetsFlutterBinding.ensureInitialized();
  }
}
