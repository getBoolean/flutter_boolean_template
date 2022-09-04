# flutter_boolean_template

A new Flutter template project by @getBoolean that acts as a starting point for new Flutter projects.
This project is very opinionated and is meant to make it easier to start a new project with essential
features already setup.

[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/gitpod-io/template-flutter)

## Todo After Using This Template

1. [ ] Activate FVM, see [FVM](#fvm)
1. [ ] Change the package name, see [Change Package Name](#change-package-name)
1. [ ] Change the app icon, see [Change App Icon](#change-app-icon)
1. [ ] Change the splash screen, see [Change Splash Screen](#change-the-splash-screen)
1. [ ] Change the app name and description in [pubspec.yaml](pubspec.yaml) and [README.md](README.md)
1. [ ] Setup the Windows build configuration, see [Build for Windows](#build-for-windows)
1. [ ] Update contribution guidelines at [Contributing](#contributing)
1. [ ] Setup GitPod for your environment, see the [GitPod](https://www.gitpod.io/docs/quickstart/flutter#flutter-quickstart) docs

## Goals

1. FVM configuration (Flutter version manager)
1. Prebuilt flex_color_scheme with support for multiple themes. (other than light and dark themes)
1. Linting preconfigured.
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
   1. Bricks for freezed models
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

### FVM

This project uses [FVM](https://fvm.app/) to manage Flutter versions. The project is
configured to use the latest stable version of Flutter. To activate FVM, run the following:

```bash
dart pub global activate fvm
```

### Change Package Name

Run the following command to change the package name:

```bash
flutter pub run change_app_package_name:main com.new.package.name
```

Where `com.new.package.name` is the new package name that you want for your app. replace it with any name you want.

### Change App Icon

Follow the [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons) README instructions to change the app icon.

### Change the Splash Screen

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

## Testing

### Mocks

This project uses Mocktail to generate mocks for classes. Follow the instructions in the
[Mocktail README](https://pub.dev/packages/mocktail) to generate mocks.

### Widget and Unit Tests

Tests are located in the `test` directory. To run the tests, run the following command:

```bash
flutter test
```

### Integration Tests

Integration tests are located in the `integration_test` directory. To run the tests, see the instructions in the Flutter docs: [Integration Testing](https://docs.flutter.dev/cookbook/testing/integration/introduction#5-run-the-integration-test)

## Building

### All Platforms

See the Flutter Deployment documentation for each platform for detailed instructions.

### Build for Windows

Customize `msix_config` in [pubspec.yaml](pubspec.yaml) to change the app name, publisher, and other options,
according to the documentation for [msix](https://pub.dev/packages/msix).

## Contributing

1. Fork it [https://github.com/getBoolean/flutter_boolean_template/fork](https://github.com/getBoolean/flutter_boolean_template/fork)
1. Create your feature branch (git checkout -b feature/fooBar)
1. Commit your changes (git commit -am 'Add some fooBar')
1. Push to the branch (git push origin feature/fooBar)
1. Create a new Pull Request
