import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:data_providers/data_providers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_toolkit/ui_toolkit.dart';

void bootstrap(
  FutureOr<Widget> Function() appFn, {
  void Function(Object, StackTrace)? onZoneError,
  FlutterExceptionHandler? onFlutterError,
  BlocObserver? blocObserver,
  Future<FirebaseApp> Function()? firebaseApp,
}) {
  return runZonedGuarded<void>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      FlutterError.onError = onFlutterError ??
          (details) {
            log(details.exceptionAsString(), stackTrace: details.stack);
          };

      if (blocObserver != null) {
        Bloc.observer = blocObserver;
      }

      await (firebaseApp ?? Firebase.initializeApp)();

      await Assets.covers.preload();

      runApp(await appFn());
    },
    onZoneError ??
        (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
