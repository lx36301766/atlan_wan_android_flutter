import 'package:logger/logger.dart';

var logger = Logger(
  printer: PrettyPrinter(
      methodCount: 2, // number of method calls to be displayed
      errorMethodCount: 8, // number of method calls if stacktrace is provided
      lineLength: 120, // width of the output
      colors: true, // Colorful log messages
      printEmojis: true, // Print an emoji for each log message
      printTime: false // Should each log print contain a timestamp
      ),
);

var loggerNoStack = Logger(
  printer: PrettyPrinter(methodCount: 0),
);

void logv(String message) {
  logger.v(message);
}

void logd(String message) {
  logger.d(message);
}

void logi(String message) {
  logger.i(message);
}

void logw(String message) {
  logger.w(message);
}

void loge(String message) {
  logger.e(message);
}

void logwtf(String message) {
  logger.wtf(message);
}
