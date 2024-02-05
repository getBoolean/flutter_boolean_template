import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

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
                                  flexSchemeColor: widget.colorProvider(
                                    widget.schemes[index],
                                  ),
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
                                    widget.onTap?.call(widget.schemes[index]);
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
