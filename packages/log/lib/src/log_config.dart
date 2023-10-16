import 'package:flutter/foundation.dart';
import 'package:logger_flutter_plus/logger_flutter_plus.dart' as logger;
import 'package:logging/logging.dart' as logging;

class LogConfig {
  final logger.LogConsoleManager consoleManager = logger.LogConsoleManager(
    isDark: true,
  );

  late final logger.Logger appLogger = logger.Logger(
    output: AppLogOutput(
      logConsoleManager: consoleManager,
    ),
  );

  void close() {
    appLogger.close();
  }

  LogConfig(String Function(logging.LogRecord)? format) {
    if (kDebugMode) {
      logging.Logger.root.level = logging.Level.ALL;
      logging.Logger.root.onRecord.listen((record) {
        debugPrint(
          format?.call(record) ??
              '${record.level.name} - ${record.time}: ${record.message}',
        );
      });
    } else if (kProfileMode) {
      logging.Logger.root.level = logging.Level.WARNING;
      logger.Logger.level = logger.Level.warning;

      logging.Logger.root.onRecord.listen((record) {
        final loggerLevel = record.level.toLoggerLevel();
        if (loggerLevel == null) return;

        appLogger.log(
          loggerLevel,
          record.message,
          record.error,
          record.stackTrace,
        );
      });
    } else if (kReleaseMode) {
      logging.Logger.root.level = logging.Level.SEVERE;
      logging.Logger.root.onRecord.listen((record) {
        // TODO: Upload to Sentry
      });
    }
  }
}

extension LoggingLevelToLoggerLevel on logging.Level {
  logger.Level? toLoggerLevel() {
    return <logging.Level, logger.Level?>{
      logging.Level.ALL: logger.Level.verbose,
      logging.Level.FINEST: logger.Level.verbose,
      logging.Level.FINER: logger.Level.debug,
      logging.Level.FINE: logger.Level.debug,
      logging.Level.CONFIG: logger.Level.debug,
      logging.Level.INFO: logger.Level.info,
      logging.Level.WARNING: logger.Level.warning,
      logging.Level.SEVERE: logger.Level.error,
      logging.Level.SHOUT: logger.Level.wtf,
      logging.Level.OFF: null,
    }[this];
  }
}

class AppLogOutput extends logger.LogOutput {
  AppLogOutput({
    required this.logConsoleManager,
  });
  final logger.LogConsoleManager logConsoleManager;

  @override
  void output(logger.OutputEvent event) {
    logConsoleManager.addLog(event);
  }

  @override
  void destroy() {
    logConsoleManager.dispose();
    super.destroy();
  }
}
