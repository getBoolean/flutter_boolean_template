import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:log/src/log_config.dart';
import 'package:logger_flutter_plus/logger_flutter_plus.dart';
import 'package:logging/logging.dart';

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
