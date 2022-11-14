import 'dart:async';
import 'dart:developer';

import 'package:data_providers/data_providers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:shared/shared.dart';
import 'package:ui_toolkit/ui_toolkit.dart';

Future<void> bootstrap(
  FutureOr<Widget> Function() appDelegate, {
  void Function(Object, StackTrace)? onZoneError,
  FlutterExceptionHandler? onFlutterError,
  BlocObserver? blocObserver,
  Future<FirebaseApp> Function()? firebaseApp,
}) async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = onFlutterError ??
      (details) {
        log(details.exceptionAsString(), stackTrace: details.stack);
      };

  await (firebaseApp ?? Firebase.initializeApp)();

  await Assets.covers.preload();

  if (blocObserver != null) {
    Bloc.observer = blocObserver;
  }

  return runZonedGuarded<void>(
    () async => runApp(await appDelegate()),
    onZoneError ??
        (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
