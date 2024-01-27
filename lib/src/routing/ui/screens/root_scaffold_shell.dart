import 'package:constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boolean_template/src/features/settings/application/settings_service.dart';
import 'package:flutter_boolean_template/src/features/settings/data/dto/navigation_type_override.dart';
import 'package:flutter_boolean_template/src/features/settings/data/dto/settings.dart';
import 'package:flutter_boolean_template/src/routing/router/router_extensions.dart';
import 'package:flutter_boolean_template/src/routing/ui/widgets/auto_leading_button.dart';
import 'package:flutter_boolean_template/src/routing/ui/widgets/responsive_scaffold.dart';
import 'package:flutter_boolean_template/utils/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:log/log.dart';

class RootScaffoldShell extends ConsumerStatefulWidget {
  const RootScaffoldShell({
    required this.navigationShell,
    required this.destinations,
    required this.title,
    super.key,
  });

  /// The navigation shell and container for the branch Navigators.
  final StatefulNavigationShell navigationShell;
  final List<RouterDestination> destinations;
  final String title;

  @override
  ConsumerState<RootScaffoldShell> createState() => _RootScaffoldShellState();
}

class _RootScaffoldShellState extends ConsumerState<RootScaffoldShell> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final settings = ref.watch(settingsServiceProvider);
    return LoggerWidget(
      child: SafeArea(
        child: ResponsiveScaffold(
          destinations: widget.destinations,
          currentIndex: widget.navigationShell.currentIndex,
          title: widget.title,
          goToIndex: widget.navigationShell.goBranch,
          willShowLeadingButton: (context) {
            final router = GoRouter.of(context);
            final canPop = router.canGoBack() || router.canPop();
            final ScaffoldState? scaffold = Scaffold.maybeOf(context);
            return canPop || (scaffold?.hasDrawer ?? false);
          },
          buildLeadingButton: (context) {
            return const AutoLeadingButton();
          },
          navigationTypeResolver: (context) {
            final settings = ref.watch(settingsServiceProvider);
            final Orientation currentOrientation =
                MediaQuery.orientationOf(context);
            final autoNavigationType = $resolveNavigationType(context);
            final landscapeNavigationType =
                settings.landscapeNavigationTypeOverride.isAuto
                    ? autoNavigationType
                    : settings.landscapeNavigationTypeOverride.navigationType;
            final portraitNavigationType =
                settings.portraitNavigationTypeOverride.isAuto
                    ? autoNavigationType
                    : settings.portraitNavigationTypeOverride.navigationType;
            return switch (currentOrientation) {
              Orientation.landscape => landscapeNavigationType,
              Orientation.portrait => portraitNavigationType,
            };
          },
          primaryActionExpanded: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: settings.isBannerShowing ? 48 : 0,
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            ),
          ),
          logo: const _StylizedFlutterLogo(),
          logoExpanded: IntrinsicWidth(
            child: Row(
              children: [
                const _StylizedFlutterLogo(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      kAppName,
                      style: theme.textTheme.titleMedium
                          ?.merge(GoogleFonts.robotoMono()),
                      overflow: TextOverflow.clip,
                      maxLines: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
          child: widget.navigationShell,
        ),
      ),
    );
  }
}

class _StylizedFlutterLogo extends StatelessWidget {
  final double? size;

  // ignore: unused_element
  const _StylizedFlutterLogo({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: const ColorFilter.matrix(<double>[
        0.2126,
        0.7152,
        0.0722,
        0,
        0,
        0.2126,
        0.7152,
        0.0722,
        0,
        0,
        0.2126,
        0.7152,
        0.0722,
        0,
        0,
        0,
        0,
        0,
        1,
        0,
      ]),
      child: FlutterLogo(size: size),
    );
  }
}
