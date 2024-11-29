import 'dart:async';

import 'package:flutter/foundation.dart';

class ErrorHandler {
  static void setupErrorHandling() {
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
      if (kReleaseMode) {
        if (details.stack != null) {
          _sendError(details.exception, details.stack!);
        }
      }
    };

    runZonedGuarded<Future<void>>(() async {},
        (Object error, StackTrace stack) {
      _sendError(error, stack);
    });
  }

  static void _sendError(Object error, StackTrace stack) {
    //TODO: Implement external error handling
  }
}
