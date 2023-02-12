# flutter_boolean_template

A new Flutter template project by @getBoolean that acts as a starting point for new Flutter projects.
This project is very opinionated and is meant to make it easier to start a new project with essential
features already setup.

[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/gitpod-io/template-flutter)

## Usage Checklist

1. [ ] Activate FVM, see [FVM](#fvm)
1. [ ] Change the package name, see [Change Package Name](#change-package-name)
1. [ ] Change the app icon, see [Change App Icon](#change-app-icon)
1. [ ] Change the splash screen, see [Change Splash Screen](#change-the-splash-screen)
1. [ ] Change the app name and description in [pubspec.yaml](pubspec.yaml) and
[README.md](README.md)
1. [ ] Setup the release build configuration, see [Building](#building)
1. [ ] Update contribution guidelines at [Contributing](#contributing)
1. [ ] Setup GitPod for your environment, see the
[GitPod](https://www.gitpod.io/docs/quickstart/flutter#flutter-quickstart) docs
1. [ ] Setup Codecov for your repository, see the
[Codecov](https://docs.codecov.com/docs/quick-start) docs
1. [ ] Read about [melos](https://pub.dev/packages/melos) monorepos and the
configured melos scripts in [melos.yaml](melos.yaml)

## Goals

1. FVM configuration (Flutter version manager)
1. Prebuilt flex_color_scheme with support for multiple themes. (other than light and dark themes)
1. Linting preconfigured.
1. CI/CD with GitHub Actions (all platforms)
1. Gitpod support (maybe Zapp too?)
1. Codecov support
1. Template README
1. Authentication with Appwrite and offline support, use a wrapper to make it easy to switch to
other providers.
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
1. Firebase services which DO NOT require Google Play services (or find alternatives for Desktop)
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

Where `com.new.package.name` is the new package name that you want for your app. replace it with
any name you want.

### Change App Icon

Follow the [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons) README
instructions to change the app icon.

### Change the Splash Screen

Follow the instructions in the file [flutter_native_splash.yaml](flutter_native_splash.yaml)

### Run the code generator

Run the following command to generate the code for the entire project:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

Alternatively, you can run the following command to watch for changes and generate code
automatically when changes are made:

```bash
flutter pub run build_runner watch --delete-conflicting-outputs
```

Note: In VSCode, you should disable auto save while running the watch command so that the generated files do not get deleted while modifying a provider or freezed model.

## Libraries

### Melos

This project uses [Melos](https://pub.dev/packages/melos) to manage the monorepo. The following scripts are configured:

* `melos run analyze` - Run `flutter analyze` in all packages.
* `melos run test` - Run all Flutter tests.
* `melos run format` - Run `dart format` in all packages.
* `melos run build` - Run `build_runner build` in all packages.
* `melos run test:selective_unit_test` - Run Flutter tests for a specific package.

### Mason Bricks

This project uses [Mason](https://pub.dev/packages/mason) to generate code for features
and tests using templates. To use the bricks, install the Mason VS Code extension. To create
addition bricks, use [Mason CLI](https://pub.dev/packages/mason_cli).

### Unions and Sealed Classes

This project uses [Freezed](https://pub.dev/packages/freezed) to generate code for immutable
union and sealed classes. See [dart_mappable](https://pub.dev/packages/dart_mappable#freezed)'s documentation on using it with freezed.

### JSON Serialization and copyWith

This is used to generate data classes and json serialization using
[dart_mappable](https://pub.dev/packages/dart_mappable). It also
generates a `copyWith` with `null` assignment support, and provides
[deep copy](https://pub.dev/packages/dart_mappable#deep-copy) forfields which are also
`dart_mappable` objects.

If a `freezed` union or sealed model is also `dart_mappable`, the `descriminatorKey` argument needs
to be added to the `@MappableClass` class annotation, and the `discriminatorValue` argument needs
to be added to the `@MappableClass` factory constructor annotation for each union or sealed class.
See the [dart_mappable#freezed](https://pub.dev/packages/dart_mappable#freezed) documentation for
more information.

### State Management

This project is preconfigured to use [Riverpod generator](https://pub.dev/packages/riverpod_generator).
The normal riverpod syntax is still supported. See Andea's article on
[Riverpod architecture](https://codewithandrea.com/articles/flutter-app-architecture-riverpod-introduction/)
for how to structure your code.

### Async Data Loading and Caching

This project recommends [stock](https://pub.dev/packages/stock) for loading data from both remote and
local sources. Its main goal is to prevent excessive calls to the network and disk cache. By
utilizing it, you eliminate the possibility of flooding your network with the same request
while, at the same time, adding layers of caching.

Although you can use it without a local source, the greatest benefit comes from combining Stock with a local database such as Floor, Drift, Sqflite, Realm, etc. *(excerpt from the README)*

See `stock`'s [Getting started](https://pub.dev/packages/stock#getting-started) section for usage
information.

## Testing

### Mocks

This project uses Mocktail to create mocks and fakes. Follow the instructions in the
[Mocktail README](https://pub.dev/packages/mocktail).

### Widget and Unit Tests

Tests are located in the `test` root directory and each package. To run all tests, run the following command:

```bash
melos run test
```

### Integration Tests

This repository uses `convienent_test`, which provides visual feedback to the tester and
takes screenshots automatically. Integration tests are located in the `integration_test`
directory.

To run the tests, see the instructions in the `convienent_test` docs:
[Getting started](https://github.com/fzyzcjy/flutter_convenient_test#getting-started)

## Building

This project automatically builds for all platforms without code signing using GitHub Actions.
To build the project locally, follow the instructions in the
[Flutter docs](https://flutter.dev/docs). Only Windows, Android, and iOS build files are currently
uploaded to the CI action fragments.

Instructions for building for release are below:

### Build for Windows Release

Consider using the package [msix](https://pub.dev/packages/msix). Read more about
packaging for windows on the [Flutter Windows Deployment](https://docs.flutter.dev/deployment/windows)
documentation.

### Build for Android Release

Follow the instructions in the [Flutter docs for Android](https://docs.flutter.dev/deployment/android).

### Build for iOS Release

Follow the instructions in the [Flutter docs for iOS](https://docs.flutter.dev/deployment/ios).

### Build for MacOS Release

Follow the instructions in the [Flutter docs for MacOS](https://docs.flutter.dev/deployment/macos).

### Build for Linux Release

Follow the instructions in the [Flutter docs for Linux](https://docs.flutter.dev/deployment/linux).

### Build for Web Release

Follow the instructions in the [Flutter docs for Web](https://docs.flutter.dev/deployment/web).

## Contributing

1. Fork it [https://github.com/getBoolean/flutter_boolean_template/fork](https://github.com/getBoolean/flutter_boolean_template/fork)
1. Create your feature branch (git checkout -b feature/fooBar)
1. Commit your changes (git commit -am 'Add some fooBar')
1. Push to the branch (git push origin feature/fooBar)
1. Create a new Pull Request
