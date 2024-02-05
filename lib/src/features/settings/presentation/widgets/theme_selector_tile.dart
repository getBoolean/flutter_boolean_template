import 'package:constants/constants.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boolean_template/src/common_widgets/prototype_height.dart';
import 'package:flutter_boolean_template/utils/utils.dart';

class ThemeSelectorTile extends StatefulWidget {
  const ThemeSelectorTile({
    required this.selected,
    required this.schemes,
    required this.colorProvider,
    this.onTap,
  });

  final FlexSchemeData selected;
  final List<FlexSchemeData> schemes;
  final void Function(FlexSchemeData)? onTap;
  final FlexSchemeColor Function(FlexSchemeData) colorProvider;

  @override
  State<ThemeSelectorTile> createState() => _ThemeSelectorTileState();
}

class _ThemeSelectorTileState extends State<ThemeSelectorTile> {
  late ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int selectedIndex = widget.schemes.indexOf(widget.selected);
    const double height = 45;
    const double width = height * 1.5;
    final ThemeData theme = Theme.of(context);
    final ColorScheme scheme = theme.colorScheme;
    return PrimaryScrollController(
      controller: _scrollController,
      child: Scrollbar(
        scrollbarOrientation: ScrollbarOrientation.bottom,
        controller: _scrollController,
        thumbVisibility: $deviceType.isDesktop,
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {
              PointerDeviceKind.mouse,
            }..addAll(ScrollConfiguration.of(context).dragDevices),
          ),
          child: PrototypeHeight(
            prototype: ThemeItem(
              selectedIndex: selectedIndex,
              theme: theme,
              scheme: scheme,
              width: width,
              height: height,
              selected: widget.selected,
              schemes: widget.schemes,
              onTap: widget.onTap,
              colorProvider: widget.colorProvider,
              index: 0,
            ),
            listView: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsetsDirectional.only(start: 8, end: 16),
              scrollDirection: Axis.horizontal,
              itemCount: widget.schemes.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return ThemeItem(
                  selectedIndex: selectedIndex,
                  index: index,
                  theme: theme,
                  scheme: scheme,
                  width: width,
                  height: height,
                  selected: widget.selected,
                  schemes: widget.schemes,
                  onTap: widget.onTap,
                  colorProvider: widget.colorProvider,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class ThemeItem extends StatelessWidget {
  const ThemeItem({
    required this.selectedIndex,
    required this.theme,
    required this.scheme,
    required this.width,
    required this.height,
    required this.selected,
    required this.schemes,
    required this.onTap,
    required this.colorProvider,
    required this.index,
    super.key,
  });

  final int index;
  final int selectedIndex;
  final ThemeData theme;
  final ColorScheme scheme;
  final double width;
  final double height;
  final FlexSchemeData selected;
  final List<FlexSchemeData> schemes;
  final void Function(FlexSchemeData)? onTap;
  final FlexSchemeColor Function(FlexSchemeData) colorProvider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 16),
      child: Stack(
        children: [
          Column(
            children: [
              FlexThemeModeOptionButton(
                flexSchemeColor: colorProvider(
                  schemes[index],
                ),
                semanticLabel: 'Select ${schemes[index].name} theme',
                selected: selectedIndex == index,
                selectedBorder: BorderSide(
                  color: theme.primaryColor,
                  width: 4,
                ),
                unselectedBorder: BorderSide.none,
                borderRadius: 8,
                width: width,
                height: height,
                onSelect: () {
                  onTap?.call(schemes[index]);
                },
              ),
              gap4,
              Text(
                schemes[index].name,
                style: theme.textTheme.bodySmall?.merge(
                  const TextStyle(
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ],
          ),
          // Checkbox from here: https://github.com/kodjodevf/mangayomi/blob/main/lib/modules/more/settings/appearance/widgets/theme_selector.dart
          if (selectedIndex == index)
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 10),
              child: CircleAvatar(
                radius: 14,
                backgroundColor: theme.primaryColorDark,
                child: Icon(
                  Icons.check,
                  color: scheme.secondary,
                  size: 16,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
