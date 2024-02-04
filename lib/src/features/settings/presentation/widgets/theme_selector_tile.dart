import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';

class ThemeSelectorTile extends AbstractSettingsTile {
  const ThemeSelectorTile({
    required this.schemes,
    required this.selected,
    required this.isLight,
    this.onTap,
    super.key,
  });

  final FlexSchemeData selected;
  final List<FlexSchemeData> schemes;
  final void Function(FlexSchemeData)? onTap;
  final bool isLight;

  @override
  Widget build(BuildContext context) {
    return _ThemeSelectorTileImpl(
      selected: selected,
      schemes: schemes,
      isLight: isLight,
      onTap: onTap,
    );
  }
}

class _ThemeSelectorTileImpl extends StatefulWidget {
  const _ThemeSelectorTileImpl({
    required this.selected,
    required this.schemes,
    required this.isLight,
    this.onTap,
  });

  final FlexSchemeData selected;
  final List<FlexSchemeData> schemes;
  final void Function(FlexSchemeData)? onTap;
  final bool isLight;

  @override
  State<_ThemeSelectorTileImpl> createState() => __ThemeSelectorTileImplState();
}

class __ThemeSelectorTileImplState extends State<_ThemeSelectorTileImpl> {
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
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return SizedBox(
      height: 130,
      child: Row(
        children: [
          Expanded(
            child: PrimaryScrollController(
              controller: _scrollController,
              child: Scrollbar(
                scrollbarOrientation: ScrollbarOrientation.bottom,
                controller: _scrollController,
                thumbVisibility: true,
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(
                    dragDevices: {
                      PointerDeviceKind.mouse,
                    }..addAll(ScrollConfiguration.of(context).dragDevices),
                  ),
                  child: ListView.builder(
                    controller: _scrollController,
                    padding:
                        const EdgeInsetsDirectional.only(start: 8, end: 16),
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.schemes.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                FlexThemeModeOptionButton(
                                  flexSchemeColor: widget.isLight
                                      ? widget.schemes[index].light
                                      : widget.schemes[index].dark,
                                  selected: selectedIndex == index,
                                  selectedBorder: BorderSide(
                                    color: theme.primaryColorLight,
                                    width: 4,
                                  ),
                                  unselectedBorder: BorderSide.none,
                                  backgroundColor: scheme.background,
                                  width: width,
                                  height: height,
                                  padding: EdgeInsets.zero,
                                  borderRadius: 0,
                                  onSelect: () {
                                    widget.onTap?.call(
                                      widget.isLight
                                          ? widget.schemes[index]
                                          : widget.schemes[index],
                                    );
                                  },
                                  optionButtonPadding: EdgeInsets.zero,
                                  optionButtonMargin: EdgeInsets.zero,
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  widget.schemes[index].name,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                            if (selectedIndex == index)
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: CircleAvatar(
                                  radius: 14,
                                  backgroundColor: theme.primaryColorLight,
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
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
