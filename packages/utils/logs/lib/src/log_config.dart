import 'package:flutter/foundation.dart';
import 'package:leak_tracker/leak_tracker.dart';
import 'package:logger_flutter_plus/logger_flutter_plus.dart' as logger;
import 'package:logging/logging.dart';

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
    dispatchObjectDisposed(object: this);
  }

  static const _library = 'package:logs/src/log_config.dart';

  LogConfig(String Function(LogRecord)? format) {
    dispatchObjectCreated(
      library: _library,
      className: '$LogConfig',
      object: this,
    );

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
      logger.Logger.level = logger.Level.warning;

      Logger.root.onRecord.listen((record) {
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
      Logger.root.level = Level.SEVERE;
      Logger.root.onRecord.listen((record) {
        // TODO: Upload to Sentry
      });
    }
  }
}

extension LoggingLevelToLoggerLevel on Level {
  logger.Level? toLoggerLevel() {
    return <Level, logger.Level?>{
      Level.ALL: logger.Level.verbose,
      Level.FINEST: logger.Level.verbose,
      Level.FINER: logger.Level.debug,
      Level.FINE: logger.Level.debug,
      Level.CONFIG: logger.Level.debug,
      Level.INFO: logger.Level.info,
      Level.WARNING: logger.Level.warning,
      Level.SEVERE: logger.Level.error,
      Level.SHOUT: logger.Level.wtf,
      Level.OFF: null,
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
