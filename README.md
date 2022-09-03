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
1. Authentication with Appwrite and offline support
1. Translation support
1. Basic project architecture using Riverpod
1. Mason brick setup for easy architecture setup
1. Responsive UI for desktop, web, mobile, tablet, possibly watch (maybe support for TV and Cars??)
   * Must have a unified navigation for when resizing the window
1. Adaptive UI for iOS, Android, Windows, Linux, MacOS, and Web
1. Focus node setup (for keyboard navigation)

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
