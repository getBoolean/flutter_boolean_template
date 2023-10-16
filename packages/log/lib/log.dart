library log;

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:log/log.dart';

export 'package:logging/logging.dart';

export 'src/log_config.dart';
export 'src/log_widget.dart';

final logProvider =
    Provider.autoDispose.family((Ref ref, String name) => Logger(name));
