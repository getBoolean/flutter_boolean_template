# Routing with AutoRoute

## Introduction

AutoRouter is a Flutter Navigator 2.0 routing library that generates type-safe routes based on a set of Router and Route classes.

## Getting Started

This `routing` package provides the core routing funcitonality to the application.
A bottom navigation bar is preconfigured with example routes to demonstrate the routing functionality.

## Routing

The [router.dart](./lib/src/router/app_router.dart) file contains the `Router` definition class which
defines the routes for the app. If any change is made to `AppRouter` or any class annotated with `@RoutePage`,
the `build_runner` must be run to generate the new/updated routes.

```bash
# This command will prompt for which package to generate code for, choose `routing`.
melos run generate:pkg
```

See the [AutoRoute documentation](https://pub.dev/packages/auto_route) for more information.
