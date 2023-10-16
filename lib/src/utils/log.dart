import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:leak_tracker/leak_tracker.dart';
import 'package:logger_flutter_plus/logger_flutter_plus.dart' as logger;
import 'package:logger_flutter_plus/logger_flutter_plus.dart';
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

/// A widget that initializes logging for the app.
///
/// This widget should be placed at the top of the widget tree.
class LoggerWidget extends StatefulWidget {
  const LoggerWidget({super.key, required this.child, this.format});

  final String Function(LogRecord)? format;
  final Widget child;

  @override
  State<LoggerWidget> createState() => _LoggerWidgetState();
}

class _LoggerWidgetState extends State<LoggerWidget> {
  late final LogConfig logConfig;
  bool isShowingConsole = false;

  @override
  void initState() {
    logConfig = LogConfig(widget.format);
    super.initState();
  }

  @override
  void dispose() {
    logConfig.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (kProfileMode) {
      return ShakeDetectorWidget(
        shakeDetector: DefaultShakeDetector(
          onPhoneShake: () async {
            if (isShowingConsole) {
              return;
            }
            isShowingConsole = true;
            final theme = Theme.of(context);
            await Navigator.push(
              context,
              MaterialPageRoute<dynamic>(
                builder: (context) => Scaffold(
                  body: LogConsoleWidget(
                    showCloseButton: true,
                    theme: LogConsoleTheme.byTheme(theme),
                    logConsoleManager: logConfig.consoleManager,
                  ),
                ),
              ),
            );
            isShowingConsole = false;
          },
        ),
        child: widget.child,
      );
    }
    return widget.child;
  }
}
