import 'dart:developer';
import 'dart:isolate';

import 'package:app_core/app_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:quizapp/app/app_bloc_observer.dart';
import 'package:ui_toolkit/ui_toolkit.dart';

Future<void> bootstrap({
  required FutureOr<Widget> Function() builder,
  FutureOr<void> Function()? init,
}) async {
  await runZonedGuarded(
    () async {
      BindingBase.debugZoneErrorsAreFatal = true;
      WidgetsFlutterBinding.ensureInitialized();
      await init?.call();

      FlutterError.onError = (details) {
        log(details.exceptionAsString(), stackTrace: details.stack);
      };
      PlatformDispatcher.instance.onError = (error, stackTrace) {
        log(error.toString(), stackTrace: stackTrace);
        return true;
      };
      Isolate.current.addErrorListener(
        RawReceivePort((dynamic pair) async {
          final errorAndStackTrace = pair as List<dynamic>;
          final error = errorAndStackTrace.first;
          final rawStackTrace = errorAndStackTrace.last;
          final stackTrace = rawStackTrace is StackTrace
              ? rawStackTrace
              : StackTrace.fromString(rawStackTrace.toString());
          log(error.toString(), stackTrace: stackTrace);
        }).sendPort,
      );

      Bloc.observer = AppBlocObserver();

      await Assets.covers.preload();

      final app = await builder();
      runApp(app);
    },
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
