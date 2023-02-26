# flutter_boolean_template

A new Flutter template project by @getBoolean that acts as a starting point for new Flutter projects.
This project is very opinionated and is meant to make it easier to start a new project with essential
features already setup.

[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/gitpod-io/template-flutter)

## Getting Started

1. [ ] Activate FVM, see [FVM](#fvm)
1. [ ] Activate [Melos](https://pub.dev/packages/melos) globally, see the [Melos](#melos)
section for setup and the configured monorepo scripts
   1. [ ] Run `melos bootstrap` to install dependencies for all packages
1. [ ] Change the package name, see [Change App/Package Name](#change-apppackage-name)
1. [ ] Change the project name using the "replace all" tool.
1. [ ] Update the description in [pubspec.yaml](pubspec.yaml) and [README.md](README.md).
1. [ ] Add needed environment variables, see the [ENVied Environment Variables](#envied-environment-variables)
section for details.
1. [ ] Change the app icon, see [Change App Icon](#change-app-icon)
1. [ ] Change the splash screen, see [Change Splash Screen](#change-the-splash-screen)
1. [ ] Setup the release build configuration, see the [Building](#building) section.
1. [ ] Setup Codecov for your repository, see the
[Codecov](https://docs.codecov.com/docs/quick-start) documentation.
1. [ ] Setup GitPod for your environment, see the
[GitPod](https://www.gitpod.io/docs/quickstart/flutter#flutter-quickstart) documentation.
1. [ ] Update contribution guidelines at the [Contributing](#contributing) section.
1. [ ] Update the [LICENSE](LICENSE) file with your preferred license (**important!**)

## Feature Goals

- [x] Melos monorepo
- [x] FVM configuration (Flutter version manager)
- [x] Presetup `flex_color_scheme` light and dark themes
- ~~`flex_color_scheme` with support for multiple themes. (other than light and dark themes)~~ (Better as a brick or package)
- [x] Linting preconfigured.
- [ ] Code metrics via [dart_code_metrics](https://pub.dev/packages/dart_code_metrics)
- [x] [Assets Gen](https://pub.dev/packages/assets_gen) for assets
- [x] CI/CD with GitHub Actions (all platforms)
- [x] Gitpod support
- [x] Codecov support
- [x] Template README
- ~~Authentication with Appwrite and offline support using stock, use a wrapper to make it easy to switch to
other providers.~~ (Better as a brick)
- [x] Localization support
- [x] Riverpod generator in features package
- [ ] Mason brick setup for easy architecture setup
  - [ ] Brick for feature packages
  - [ ] Brick for freezed models
  - ~~Bricks for tests~~ (Too situational)
- [ ] Responsive UI Widgets for desktop, web, mobile, tablet, and possibly watches and TV
  - Must have a maintain navigation state when resizing the window
- [ ] Adaptive UI Widgets for iOS, Android, Windows, Linux, MacOS, and Web
- [ ] [Sentry](https://pub.dev/packages/sentry_flutter)
  - [ ] [Sentry Logging](https://pub.dev/packages/sentry_logging)
- [ ] Logging ([example](https://github.com/levin-riegner/flutter-template#logging))
  - [x] [logging](https://pub.dev/packages/logging) for development/debug mode
  - [x] `logger` and `logger_flutter_plus` for profile mode
  - [ ] `Sentry` for production
- [x] [leak_tracker](https://pub.dev/packages/leak_tracker)
- [ ] Database for user preferences
  - Offline first, but should be able to use cloud sync with it
- [x] [ENVied](https://pub.dev/packages/envied) for environment variables
- [ ] Firebase services which do not require Google Play services (or use alternatives). Disable safely if not setup properly.
  - [ ] App Check with custom and debug providers
  - [ ] ~~Crashlytics~~ (use Sentry)
  - [ ] In-App Messaging
  - [ ] Performance Monitoring
  - [ ] Remote Config or [Flagsmith](https://flagsmith.com/)
- [ ] Optional firebase services which require Google Play services
  - [ ] Dynamic Links
  - [ ] Cloud Messaging
- [x] GoRouter
  - [ ] StatefullShellRoute ([pending PR](https://github.com/flutter/packages/pull/2650))
- [ ] [Deep Linking](https://docs.flutter.dev/development/ui/navigation/deep-linking) and [AppLinks](https://pub.dev/packages/app_links)
- [ ] Appwrite integration
- [ ] Publishing via Codemagic or GitHub Actions on tag creation
- ~~Focus node setup (for keyboard navigation)~~
- ~~Biometric/Local authentication~~ (Better as a brick)
- ~~App updates~~ (Better as a package/cli)
  - ~~In-app updated for sideloaded apps~~
  - ~~Link to app store for apps published to app store~~
- ~~Onboarding~~
- ~~Feature discovery~~

## Learn More

- Minimal OS Version:
  - iOS: 13.0
  - Android: 4.3 (SDK 18)
  - Other: Flutter default

### FVM

This project uses [FVM](https://fvm.app/) to manage Flutter versions, and is configured to use the latest stable version of Flutter. Either the CLI or the GUI app [Sidekick](https://github.com/fluttertools/sidekick) can be used.

```bash
# FVM CLI
dart pub global activate fvm
```

### Change App/Package Name

1. Run the following command to change the package name, where `com.new.package.name`
is the new package name that you want for your app.

   ```bash
   flutter pub run change_app_package_name:main com.new.package.name
   ```

1. Replace all instances of `flutter_boolean_template` with your new Flutter package name.

### Change App Icon

Follow the [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons) README
instructions to change the app icon.

### Change the Splash Screen

Follow the instructions in the file [flutter_native_splash.yaml](flutter_native_splash.yaml)

### Run the code generator

```bash
# Generate the code for the entire project
melos run generate
```

Alternatively, you can run the following command to watch for changes and generate code
automatically when changes are made:

```bash
flutter pub run build_runner watch --delete-conflicting-outputs
```

Note: In VSCode, you should disable auto save while running the watch command so that the generated files do not get deleted while modifying a provider or freezed model.

## Libraries

### Melos

This project uses [Melos](https://pub.dev/packages/melos) to manage the monorepo.

  ```bash
  # Install melos globally
  dart pub global activate melos
  # Setup local dependency overrides for packages in the monorepo
  melos bootstrap

  # Or if dart executables are not on your path
  dart pub global run melos bootstrap
  ```

The following scripts are configured:

- `melos run analyze` - Run `dart analyze` in all packages.
- `melos run test` - Run all Flutter tests.
- `melos run format` - Run `dart format` in all packages.
- `melos run fix` - Run `dart fix --apply` in all packages.
- `melos run generate` - Run `build_runner build` in all packages that depend on `build_runner`.
- `melos run generate:pkg` - Run `build_runner build` for a specific package.
- `melos run assets` - Run `assets_gen build` in all packages that depend on `assets_gen`.
- `melos run assets:pkg` - Run `assets_gen build` for a specific package.
- `melos run test` - Run all tests in the project.
- `melos run flutter_test` - Run all Flutter tests in the project.
- `melos run dart_test` - Run all Dart tests in the project.
- `melos run flutter_test:pkg` - Run Flutter tests for a specific package.
- `melos run dart_test:pkg` - Run Dart tests for a specific (Dart only) package.
- `melos run loc` - Run `flutter gen-l10n` in the localization package to generate
  the localized strings from the arb files.

### ENVied Environment Variables

Environment variables are setup using [ENVied](https://pub.dev/packages/envied)
in the [utils/env](packages/utils/env/) package. Environment variables need to be
defined for debug, profile, and release modes.

1. Remove the `.example` extension from `.env_debug.example`, `.env_profile.example`,
and `.env_release.example`.
2. Add the values for the environment variables in the respective `.env*` file.
   - Each key must be added to each `.env*` file, unless a non null default value is added
     to the `@EnviedField` annotation.
3. Update [src/env/app_env_fields.dart](packages/utils/env/lib/src/env/app_env_fields.dart)
with the new environment variables.
4. Add the new environment variables to `debug_env.dart`, `profile_env.dart`, and
`release_env.dart` in the [src/env](packages/utils/env/src/env/) directory.
5. Enable `obfuscate` for API keys in the `@EnviedField` annotation.
6. Optionally, add a `defaultValue` to the `@EnviedField` annotation for keys which are
not required in all modes.

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

### Leak Tracking

The package [leak_tracker](https://pub.dev/packages/leak_tracker) is used to track memory leaks.
This works automatically for instrumented Flutter classes, but requires manual instrumentation
for code outside of the Flutter framework. See the [leak_tracker README](https://pub.dev/packages/leak_tracker#instrument-your-code)
for more information.

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

This repository uses `patrol`, which provides visual feedback to the tester and
takes screenshots automatically. Integration tests are located in the `integration_test`
directory.

To run the tests, see the instructions in the [Patrol documentation](https://pub.dev/packages/patrol)

## Building

This project automatically builds for all platforms without code signing using GitHub Actions.
To build the project locally, follow the instructions in the
[Flutter docs](https://flutter.dev/docs). Only Windows, Android, and iOS build files are currently
uploaded to the CI action fragments.

Instructions for building for release are below:

### Build for Windows Release

1. Customize `msix_config` in [pubspec.yaml](pubspec.yaml) according to the documentation
for [msix](https://pub.dev/packages/msix) for your method of publication. The default
configuration is for CI/CD testing builds only, not releases.
1. Run the corresponding command for your method of publication

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
