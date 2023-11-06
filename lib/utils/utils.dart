import 'dart:io' as io;

import 'package:adaptive_breakpoints/adaptive_breakpoints.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
  Roku,
}

enum DeviceForm {
  tv(AdaptiveWindowType.xlarge),
  desktop(AdaptiveWindowType.large),
  tablet(AdaptiveWindowType.medium),
  phone(AdaptiveWindowType.small);
  // watch(AdaptiveWindowType.xsmall);

  const DeviceForm(this.adaptiveWindowType);

  final AdaptiveWindowType adaptiveWindowType;

  static DeviceForm from(AdaptiveWindowType adaptiveWindowType) {
    return switch (adaptiveWindowType) {
      _ when adaptiveWindowType >= AdaptiveWindowType.xlarge => DeviceForm.tv,
      _ when adaptiveWindowType >= AdaptiveWindowType.large =>
        DeviceForm.desktop,
      _ when adaptiveWindowType >= AdaptiveWindowType.medium =>
        DeviceForm.tablet,
      _ when adaptiveWindowType >= AdaptiveWindowType.small => DeviceForm.phone,
      // _ when adaptiveWindowType >= AdaptiveWindowType.xsmall =>
      //   DeviceForm.watch,
      _ => DeviceForm.phone,
    };
  }
}

/// Returns the device type using the user agent if on web
(DeviceType, DeviceForm, Orientation) getDeviceDetails(BuildContext context) {
  final Orientation currentOrientation = MediaQuery.of(context).orientation;
  final windowType = getWindowType(context);
  final DeviceForm deviceForm = DeviceForm.from(windowType);

  if (kIsWeb) {
    final userAgent = html.window.navigator.userAgent.toLowerCase();
    final DeviceType deviceType;
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

    return (deviceType, deviceForm, currentOrientation);
  } else {
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

    return (deviceType, deviceForm, currentOrientation);
  }
}
