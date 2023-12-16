// MIT License
//
// Copyright (c) 2019 Milad Akarie
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boolean_template/utils/utils.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// A [PageView] that animates between its children implicitly.
///
/// A partially modified version of `AutoTabView` from the `auto_route` package.
/// These changes fix the children not updating in sync with the changed index
/// from the router.
class ImplicitlyAnimatedPageView extends StatefulHookWidget {
  /// A [PageView] that animates between its children implicitly.
  ///
  /// A partially modified version of `AutoTabView` from the `auto_route` package.
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
    required this.swipeToIndex,
  });

  /// Whether to use [PageController.animateToPage] or [PageController.jumpToPage]
  final bool animatePageTransition;

  /// The index of the currently selected page from the navigator/router
  final int currentIndex;

  /// The widgets bodies to display in the [PageView]
  final List<Widget> children;

  /// The duration of the transition animation passed to [PageController.animateToPage]
  final Duration duration;

  /// The curve of the transition animation passed to [PageController.animateToPage]
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

  /// Callback to change the current index from gesture scrolling
  final void Function(int index) swipeToIndex;

  @override
  State<ImplicitlyAnimatedPageView> createState() =>
      _ImplicitlyAnimatedPageViewState();
}

class _ImplicitlyAnimatedPageViewState extends State<ImplicitlyAnimatedPageView>
    with SingleTickerProviderStateMixin {
  late PageController _controller;
  int _warpUnderwayCount = 0;
  late List<Widget> _children = widget.children;

  @override
  Widget build(BuildContext context) {
    final currentIndex = widget.currentIndex;
    _controller = usePageController(
      initialPage: currentIndex,
      keepPage: false,
    );
    useValueChanged(
      currentIndex,
      (oldValue, _) => _warpToCurrentIndex(currentIndex, oldValue),
    );

    final isIOS = $deviceType == DeviceType.iOS;
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: PageView(
        scrollDirection: widget.scrollDirection,
        allowImplicitScrolling: false,
        controller: _controller,
        dragStartBehavior: widget.dragStartBehavior,
        physics: widget.physics == null
            ? const PageScrollPhysics().applyTo(isIOS
                ? const BouncingScrollPhysics()
                : const ClampingScrollPhysics())
            : const PageScrollPhysics().applyTo(widget.physics),
        children: _children,
      ),
    );
  }

  // Called when the PageView scrolls from gestures
  bool _handleScrollNotification(ScrollNotification notification) {
    if (_warpUnderwayCount > 0) return false;
    if (notification.depth != 0) return false;
    _warpUnderwayCount += 1;
    if (notification is ScrollUpdateNotification) {
      final int newIndex = _controller.page!.round();
      if (newIndex != widget.currentIndex) {
        widget.swipeToIndex(newIndex);
      }
    }
    _warpUnderwayCount -= 1;
    return false;
  }

  Future<void> _warpToCurrentIndex(int activeIndex, int previousIndex) async {
    if (activeIndex == previousIndex) return Future<void>.value();
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

    // If we are going to a page that is not adjacent to the current page,
    // we need to rebuild the children so that the new page is one away
    // from the current page, and then we jump to the new page.
    // Otherwise the PageView will flash quickly as it
    // shows each page in between, and this is undesirable.

    final int initialPage =
        activeIndex > previousIndex ? activeIndex - 1 : activeIndex + 1;

    setState(() {
      _warpUnderwayCount += 1;
      _children = List<Widget>.of(_children, growable: false);
      final Widget temp = _children[initialPage];
      _children[initialPage] = _children[previousIndex];
      _children[previousIndex] = temp;
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
      _children = List<Widget>.of(_children, growable: false);
      final Widget temp = _children[previousIndex];
      _children[previousIndex] = _children[initialPage];
      _children[initialPage] = temp;
      _warpUnderwayCount -= 1;
    });
  }
}
