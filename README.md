# flutter_boolean_template

A new Flutter template project by @getBoolean that acts as a starting point for new Flutter projects.
This project is very opinionated and is meant to make it easier to start a new project with essential
features already setup.

## Goals

1. Prebuilt flex_color_scheme with support for multiple themes. (other than light and dark themes)
1. CI/CD with GitHub Actions (all platforms)
1. Gitpod support (maybe Zapp too?)
1. Codecov support
1. Template README
1. Authentication with Appwrite and offline support, use a wrapper to make it easy to switch to other
   providers.
1. Localization support
1. Basic project architecture using Riverpod
1. Mason brick setup for easy architecture setup
   1. Bricks for features
   1. Bricks for tests
1. Responsive UI for desktop, web, mobile, tablet, possibly watch (maybe support for TV and Cars??)
   * Must have a unified navigation for when resizing the window
1. Adaptive UI for iOS, Android, Windows, Linux, MacOS, and Web
1. Focus node setup (for keyboard navigation)
1. Biometric/Local authentication
1. App updates
   1. In-app updated for sideloaded apps
   1. Link to app store for apps published to app store
1. Onboarding
1. Feature discovery
1. Firebase services which DO NOT require Google Play services
   1. App Check with custom and debug providers
   1. Crashlytics
   1. In-App Messaging
   1. Performance Monitoring
   1. Remote Config

## Getting Started

### Change Package Name

Run the following command to change the package name:

```bash
flutter pub run change_app_package_name:main com.new.package.name
```

Where `com.new.package.name` is the new package name that you want for your app. replace it with any name you want.

### Change App Icon

Follow the [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons) README instructions to change the app icon.

### Changing the Splash Screen

Follow the instructions in the file [flutter_native_splash.yaml](flutter_native_splash.yaml)

### Mason Bricks

This project uses [Mason](https://pub.dev/packages/mason) to generate code for features and tests.
To use the bricks, install the Mason VS Code extension. To create addition bricks, use the [Mason CLI](https://pub.dev/packages/mason_cli) package.

### Using Freezed

This project uses [Freezed](https://pub.dev/packages/freezed) to generate code for immutable classes with unions.

### Run the code generator

Run the following command to generate the code for the entire project:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

Alternatively, you can run the following command to watch for changes and generate code automatically
when changes are made:

```bash
flutter pub run build_runner watch --delete-conflicting-outputs
```
