// ignore_for_file: constant_identifier_names

import 'dart:io' as io;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_boolean_template/src/routing/data/navigation_type.dart';
import 'package:path_provider/path_provider.dart';
import 'package:universal_html/html.dart' as html;

enum DeviceType {
  iOS,
  Android,
  Windows,
  MacOS,
  Linux,

  /// Only available on web
  ChromeOS,

  /// Only available on web
  AppleTV,

  /// Only available on web
  Roku;

  bool get isMobile => this == DeviceType.iOS || this == DeviceType.Android;

  bool get isDesktop =>
      this == DeviceType.Windows ||
      this == DeviceType.MacOS ||
      this == DeviceType.Linux ||
      this == DeviceType.ChromeOS;
}

const $breakpointMediumSmall = WidthPlatformBreakpoint(begin: 600, end: 700);

enum DeviceForm {
  /// Computer screens
  large(Breakpoints.large),

  /// Large tablets in landscape
  medium(Breakpoints.medium),

  /// Phones and small tablets in portrait
  small(WidthPlatformBreakpoint(begin: 0, end: 600));

  const DeviceForm(this.breakpoint);

  final Breakpoint breakpoint;

  static DeviceForm of(BuildContext context) {
    return DeviceForm.values.firstWhere(
      (form) => form.breakpoint.isActive(context),
    );
  }
}

typedef DeviceDetails = (DeviceType, DeviceForm, Orientation);

/// Returns the current device type, form and orientation
///
/// If the app is running on the web, the device type is determined by the user agent.
DeviceDetails $deviceDetails(BuildContext context) {
  final Orientation currentOrientation = MediaQuery.orientationOf(context);
  final DeviceForm deviceForm = $deviceForm(context);
  final DeviceType deviceType = $deviceType;
  return (deviceType, deviceForm, currentOrientation);
}

DeviceType get $deviceType =>
    kIsWeb ? _deviceTypeByUserAgent : _deviceTypeByPlatform;

DeviceForm $deviceForm(BuildContext context) {
  return DeviceForm.of(context);
}

DeviceType get _deviceTypeByPlatform {
  final DeviceType deviceType;
  if (io.Platform.isAndroid) {
    deviceType = DeviceType.Android;
  } else if (io.Platform.isIOS) {
    deviceType = DeviceType.iOS;
  } else if (io.Platform.isMacOS) {
    deviceType = DeviceType.MacOS;
  } else if (io.Platform.isWindows) {
    deviceType = DeviceType.Windows;
  } else if (io.Platform.isLinux) {
    deviceType = DeviceType.Linux;
  } else {
    deviceType = DeviceType.Android;
  }
  return deviceType;
}

/// Returns the current device type by user agent
DeviceType get _deviceTypeByUserAgent {
  final DeviceType deviceType;
  final userAgent = html.window.navigator.userAgent.toLowerCase();
  // Smartphone
  if (userAgent.contains('iphone')) {
    deviceType = DeviceType.iOS;
  } else if (userAgent.contains('android') || userAgent.contains('crkey')) {
    deviceType = DeviceType.Android;
  }

  // Desktop
  else if (userAgent.contains('macintosh')) {
    deviceType = DeviceType.MacOS;
  } else if (userAgent.contains('windows')) {
    deviceType = DeviceType.Windows;
  } else if (userAgent.contains('linux')) {
    deviceType = DeviceType.Linux;
  } else if (userAgent.contains('cros')) {
    deviceType = DeviceType.ChromeOS;
  } else if (userAgent.contains('roku')) {
    deviceType = DeviceType.Roku;
  } else if (userAgent.contains('appletv')) {
    deviceType = DeviceType.AppleTV;
  } else {
    deviceType = DeviceType.Android;
  }
  return deviceType;
}

NavigationType $resolveNavigationType(BuildContext context) {
  final (_, form, orientation) = $deviceDetails(context);
  return switch (orientation) {
    Orientation.portrait => switch (form) {
        DeviceForm.large => NavigationType.top,
        DeviceForm.medium => NavigationType.sidebar,
        DeviceForm.small => NavigationType.bottom,
      },
    Orientation.landscape => switch (form) {
        DeviceForm.large => NavigationType.top,
        DeviceForm.medium => NavigationType.sidebar,
        DeviceForm.small => NavigationType.drawer,
      },
  };
}

extension ListSwap<T> on List<T> {
  List<T> swap(int activeIndex, int initialPage) {
    final items = List<T>.of(this, growable: false);
    final T temp = items[activeIndex];
    items[activeIndex] = items[initialPage];
    items[initialPage] = temp;

    return items;
  }
}

Future<io.Directory?> $applicationDocumentsDirectory() async {
  return kIsWeb ? null : await getApplicationDocumentsDirectory();
}

extension BuildContextExtensions on BuildContext {
  /// Shows a [SnackBar] with [message] only if the user is using an accessibility
  /// service like TalkBack or VoiceOver to interact with the application.
  void showAccessibilitySnackBar(String message) {
    final isAccessible = MediaQuery.accessibleNavigationOf(this);
    if (!isAccessible) {
      return;
    }

    showSnackBar(message);
  }

  /// Shows a [SnackBar] with [message]
  void showSnackBar(String message) {
    final messenger = ScaffoldMessenger.maybeOf(this);
    messenger?.clearSnackBars();
    messenger?.showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
