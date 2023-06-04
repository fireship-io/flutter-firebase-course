import 'dart:async';
import 'dart:developer';

import 'package:app_core/src/failure.dart';
import 'package:rxdart/rxdart.dart';

extension StreamExtensions<T> on Stream<T> {
  Stream<T> logOnEach([String prefix = '']) {
    return doOnListen(() => log('LISTEN', name: prefix))
        .doOnData((data) => log('DATA: $data', name: prefix))
        .doOnCancel(() => log('CANCELLED', name: prefix))
        .doOnPause(() => log('PAUSED', name: prefix))
        .doOnResume(() => log('RESUMED', name: prefix))
        .doOnDone(() => log('DONE', name: prefix))
        .doOnError(
          (error, stackTrace) => log(
            'ERROR',
            error: error,
            stackTrace: stackTrace,
            name: prefix,
          ),
        );
  }

  Stream<T> onErrorResumeWith(
    T Function(Object error, StackTrace stackTrace) valueOnError,
  ) {
    return transform(
      StreamTransformer<T, T>.fromHandlers(
        handleError: (Object error, StackTrace stackTrace, EventSink<T> sink) {
          sink.add(valueOnError(error, stackTrace));
        },
      ),
    );
  }

  Stream<T> handleFailure<F extends Failure>([
    void Function(F failure)? onFailure,
  ]) {
    return handleError(
      (Object error) {
        if (error is F) {
          onFailure?.call(error);
        }
      },
    );
  }
}
