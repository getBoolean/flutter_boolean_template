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
  largeDesktop(AdaptiveWindowType.xlarge),
  desktop(AdaptiveWindowType.large),
  tablet(AdaptiveWindowType.medium),
  largePhone(AdaptiveWindowType.small),
  phone(AdaptiveWindowType.xsmall);

  const DeviceForm(this.adaptiveWindowType);

  final AdaptiveWindowType adaptiveWindowType;

  static DeviceForm from(AdaptiveWindowType adaptiveWindowType) {
    return switch (adaptiveWindowType) {
      _ when adaptiveWindowType >= AdaptiveWindowType.xlarge =>
        DeviceForm.largeDesktop,
      _ when adaptiveWindowType >= AdaptiveWindowType.large =>
        DeviceForm.desktop,
      _ when adaptiveWindowType >= AdaptiveWindowType.medium =>
        DeviceForm.tablet,
      _ when adaptiveWindowType >= AdaptiveWindowType.small =>
        DeviceForm.largePhone,
      _ when adaptiveWindowType >= AdaptiveWindowType.xsmall =>
        DeviceForm.phone,
      _ => DeviceForm.phone,
    };
  }

  bool get isSmall => this == DeviceForm.phone || this == DeviceForm.largePhone;
  bool get isNotSmall => !isSmall;
}

typedef DeviceDetails = (DeviceType, DeviceForm, Orientation);

/// Returns the current device type, form and orientation
///
/// If the app is running on the web, the device type is determined by the user agent.
DeviceDetails getDeviceDetails(BuildContext context) {
  final Orientation currentOrientation = MediaQuery.orientationOf(context);
  final DeviceForm deviceForm = getDeviceForm(context);
  final DeviceType deviceType = getDeviceType();
  return (deviceType, deviceForm, currentOrientation);
}

DeviceType getDeviceType() =>
    kIsWeb ? getDeviceTypeByUserAgent() : getDeviceTypeByPlatform();

DeviceForm getDeviceForm(BuildContext context) {
  final windowType = getWindowType(context);
  final DeviceForm deviceForm = DeviceForm.from(windowType);
  return deviceForm;
}

DeviceType getDeviceTypeByPlatform() {
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
DeviceType getDeviceTypeByUserAgent() {
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
