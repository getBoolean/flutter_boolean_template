library logs;

import 'package:logging/logging.dart';
import 'package:riverpod/riverpod.dart';

export 'package:logging/logging.dart';

export 'src/log_config.dart';
export 'src/logger_widget.dart';

// ignore: avoid_types_on_closure_parameters
final logProvider =
    Provider.autoDispose.family((Ref ref, String name) => Logger(name));
