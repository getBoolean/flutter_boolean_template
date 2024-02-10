import 'package:flutter/material.dart';
import 'package:flutter_boolean_template/src/features/settings/data/dto/human_name_enum.dart';

class SegmentedButtonTile<T extends HumanReadableEnum> extends StatefulWidget {
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
  State<SegmentedButtonTile<T>> createState() => _SegmentedButtonTileState<T>();
}

class _SegmentedButtonTileState<T extends HumanReadableEnum>
    extends State<SegmentedButtonTile<T>> {
  late T selected = widget.initial;

  @override
  void didUpdateWidget(covariant SegmentedButtonTile<T> oldWidget) {
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
        left: 8,
        right: 8,
        bottom: 19 * scaleFactor,
        top: 19 * scaleFactor,
      ),
      child: SegmentedButton<T>(
        segments: <ButtonSegment<T>>[
          for (final segment in widget.segments)
            ButtonSegment<T>(
              value: segment,
              label: Text(
                segment.humanName,
                maxLines: 1,
              ),
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
