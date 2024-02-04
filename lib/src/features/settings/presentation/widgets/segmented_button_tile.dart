import 'package:flutter/material.dart';
import 'package:flutter_boolean_template/src/features/settings/data/dto/human_name_enum.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';

class SegmentedButtonTile<T extends HumanReadableEnum>
    extends AbstractSettingsTile {
  const SegmentedButtonTile({
    required this.initial,
    required this.segments,
    this.padding,
    this.enabled = true,
    this.onTap,
    super.key,
  });

  final EdgeInsetsGeometry? padding;
  final T initial;
  final List<T> segments;
  final bool enabled;
  final void Function(T)? onTap;

  @override
  Widget build(BuildContext context) {
    return _SegmentedButtonTileImpl<T>(
      initial: initial,
      segments: segments,
      padding: padding,
      enabled: enabled,
      onTap: onTap,
    );
  }
}

class _SegmentedButtonTileImpl<T extends HumanReadableEnum>
    extends StatefulWidget {
  const _SegmentedButtonTileImpl({
    required this.initial,
    required this.segments,
    this.padding,
    this.enabled = true,
    this.onTap,
    super.key,
  });

  final EdgeInsetsGeometry? padding;
  final T initial;
  final List<T> segments;
  final bool enabled;
  final void Function(T)? onTap;

  @override
  State<_SegmentedButtonTileImpl<T>> createState() =>
      _SegmentedButtonTileImplState<T>();
}

class _SegmentedButtonTileImplState<T extends HumanReadableEnum>
    extends State<_SegmentedButtonTileImpl<T>> {
  late T selected = widget.initial;

  @override
  void didUpdateWidget(covariant _SegmentedButtonTileImpl<T> oldWidget) {
    if (oldWidget.initial != widget.initial) {
      setState(() {
        selected = widget.initial;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final scaleFactor = MediaQuery.textScalerOf(context).scale(1);
    return Padding(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        bottom: 19 * scaleFactor,
        top: 19 * scaleFactor,
      ),
      child: SegmentedButton<T>(
        segments: <ButtonSegment<T>>[
          for (final segment in widget.segments)
            ButtonSegment<T>(
              value: segment,
              label: Text(segment.humanName),
              enabled: widget.enabled,
            ),
        ],
        selected: <T>{selected},
        onSelectionChanged: (Set<T> newSelection) {
          setState(() {
            selected = newSelection.first;
            widget.onTap?.call(selected);
          });
        },
      ),
    );
  }
}
