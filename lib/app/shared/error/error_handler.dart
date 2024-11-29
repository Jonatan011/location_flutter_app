import 'failure.dart';

class ErrorHandler {
  static String getMessage(Failure failure) {
    return failure.message;
  }
}
