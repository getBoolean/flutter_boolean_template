import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logger_flutter_plus/logger_flutter_plus.dart';
import 'package:logging/logging.dart';

import 'log_config.dart';

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
          onPhoneShake: () => Navigator.push(
            context,
            MaterialPageRoute<dynamic>(
              builder: (context) => Scaffold(
                body: LogConsoleWidget(
                  logConsoleManager: logConfig.consoleManager,
                ),
              ),
            ),
          ),
        ),
        child: widget.child,
      );
    }
    return widget.child;
  }
}
