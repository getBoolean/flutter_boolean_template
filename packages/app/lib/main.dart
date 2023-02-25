import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:sentry_logging/sentry_logging.dart';

import 'app.dart';

void main() async {
  await SentryFlutter.init(
    (options) {
      options
      // TODO: Get from environment variables
        ..dsn =
            'https://993cbc6a5d0740598925aa2d28154b39@o4504738766848000.ingest.sentry.io/4504738768224256'
        // Sentry: Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
        // We recommend adjusting this value in production.
        ..tracesSampleRate = 1.0;

      if (kReleaseMode) {
        options.addIntegration(LoggingIntegration());
      }
    },
    appRunner: () => runApp(const ProviderScope(child: App())),
  );
}
