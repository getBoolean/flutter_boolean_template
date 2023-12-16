import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ImplicitlyAnimatedPageView extends StatefulHookWidget {
  const ImplicitlyAnimatedPageView({
    super.key,
    required this.currentIndex,
    required this.children,
    this.duration = kTabScrollDuration,
    this.curve = Curves.easeInOut,
    this.scrollDirection = Axis.horizontal,
    this.physics,
    this.animatePageTransition = true,
    this.dragStartBehavior = DragStartBehavior.start,
    required this.goToIndex,
  });

  /// Whether to use [PageController.animateToPage] or [PageController.jumpToPage]
  final bool animatePageTransition;

  final int currentIndex;

  final List<Widget> children;

  /// The duration of the transition animation passed to [PageController.animateToPage]
  final Duration duration;

  final Curve curve;

  /// The scroll direction of the [PageView]
  /// see [PageView.scrollDirection]
  final Axis scrollDirection;

  /// How the page view should respond to user input.
  ///
  /// For example, determines how the page view continues to animate after the
  /// user stops dragging the page view.
  ///
  /// The physics are modified to snap to page boundaries using
  /// [PageScrollPhysics] prior to being used.
  ///
  /// Defaults to matching platform conventions.
  final ScrollPhysics? physics;

  /// {@macro flutter.widgets.scrollable.dragStartBehavior}
  final DragStartBehavior dragStartBehavior;

  final void Function(int index) goToIndex;

  @override
  State<ImplicitlyAnimatedPageView> createState() =>
      _ImplicitlyAnimatedPageViewState();
}

class _ImplicitlyAnimatedPageViewState extends State<ImplicitlyAnimatedPageView>
    with SingleTickerProviderStateMixin {
  late PageController _controller;
  int _warpUnderwayCount = 0;

  @override
  Widget build(BuildContext context) {
    final currentIndex = widget.currentIndex;
    _controller = usePageController(
      initialPage: currentIndex,
      keepPage: false,
    );
    useValueChanged(
      currentIndex,
      // (oldValue, __) => widget.animatePageTransition
      //     ? _controller.animateToPage(currentIndex,
      //         duration: widget.duration, curve: widget.curve)
      //     : _controller.jumpToPage(currentIndex),
      (oldValue, _) => _warpToCurrentIndex(currentIndex, oldValue),
    );
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: PageView(
        scrollDirection: widget.scrollDirection,
        allowImplicitScrolling: false,
        controller: _controller,
        dragStartBehavior: widget.dragStartBehavior,
        physics: widget.physics == null
            ? const PageScrollPhysics().applyTo(const ClampingScrollPhysics())
            : const PageScrollPhysics().applyTo(widget.physics),
        children: widget.children,
      ),
    );
  }

  // Called when the PageView scrolls
  bool _handleScrollNotification(ScrollNotification notification) {
    if (_warpUnderwayCount > 0) return false;
    if (notification.depth != 0) return false;
    _warpUnderwayCount += 1;
    if (notification is ScrollUpdateNotification) {
      widget.goToIndex(_controller.page!.round());
    }
    _warpUnderwayCount -= 1;
    return false;
  }

  Future<void> _warpToCurrentIndex(int activeIndex, int previousIndex) async {
    if (!mounted) return Future<void>.value();

    final bool animatePageTransition = widget.animatePageTransition;

    if ((activeIndex - previousIndex).abs() == 1) {
      _warpUnderwayCount += 1;
      if (animatePageTransition) {
        await _controller.animateToPage(activeIndex,
            duration: widget.duration, curve: Curves.ease);
      } else {
        _controller.jumpToPage(activeIndex);
      }
      _warpUnderwayCount -= 1;
      return Future<void>.value();
    }
    assert((activeIndex - previousIndex).abs() > 1,
        'active and previous index should not be the same');
    final int initialPage =
        activeIndex > previousIndex ? activeIndex - 1 : activeIndex + 1;

    setState(() {
      _warpUnderwayCount += 1;
    });
    _controller.jumpToPage(initialPage);

    if (animatePageTransition) {
      await _controller.animateToPage(activeIndex,
          duration: widget.duration, curve: widget.curve);
    } else {
      _controller.jumpToPage(activeIndex);
    }
    if (!mounted) return Future<void>.value();
    setState(() {
      _warpUnderwayCount -= 1;
    });
  }
}
