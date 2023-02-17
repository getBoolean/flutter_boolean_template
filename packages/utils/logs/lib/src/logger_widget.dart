import 'package:flutter/widgets.dart';
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
  @override
  void initState() {
    LogConfig.init(widget.format);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
