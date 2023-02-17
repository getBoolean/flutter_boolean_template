import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

class LogConfig {
  static void init(String Function(LogRecord)? format) {
    if (kDebugMode) {
      Logger.root.level = Level.ALL;
      Logger.root.onRecord.listen((record) {
        debugPrint(
          format?.call(record) ??
              '${record.level.name} - ${record.time}: ${record.message}',
        );
      });
    } else if (kProfileMode) {
      Logger.root.level = Level.WARNING;
      Logger.root.onRecord.listen((record) {
        // TODO: Write to file and shake to view/export
      });
    } else if (kReleaseMode) {
      Logger.root.level = Level.SEVERE;
      Logger.root.onRecord.listen((record) {
        // TODO: Upload to Sentry
      });
    }
  }
}
