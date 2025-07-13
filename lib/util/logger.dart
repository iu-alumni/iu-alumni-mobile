import 'package:logger/logger.dart';

final logger = Logger(
  printer: PrettyPrinter(
    // Should each log print contain a timestamp
    dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
  ),
);
