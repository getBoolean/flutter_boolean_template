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

import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// A [PageView] that animates between its children implicitly.
///
/// A partially modified version of `AutoTabView` from the `auto_route` package,
/// which itself took most of the code from flutter's [TabView].
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
    this.useFadeTransition = false,
    this.dragStartBehavior = DragStartBehavior.start,
    required this.swipeToIndex,
  });

  /// Whether to use [PageController.animateToPage] or [PageController.jumpToPage]
  final bool animatePageTransition;

  /// Whether to use [FadingPageView] or [PageView]
  final bool useFadeTransition;

  /// The index of the currently selected page from the navigator/router
  final int currentIndex;

  /// The widgets bodies to display in the [PageView]
  final List<Widget> children;

  /// The duration of the transition animation passed to [PageController.animateToPage]
  final Duration duration;

  /// The curve of the transition animation passed to [PageController.animateToPage]
  ///
  /// Only used if [animatePageTransition] is true and [useFadeTransition] is false
  final Curve curve;

  /// The scroll direction of the [PageView]
  /// see [PageView.scrollDirection]
  ///
  /// Only used if [useFadeTransition] is false
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
  ///
  /// Only used if [useFadeTransition] is false
  final ScrollPhysics? physics;

  /// {@macro flutter.widgets.scrollable.dragStartBehavior}
  ///
  /// Only used if [useFadeTransition] is false
  final DragStartBehavior dragStartBehavior;

  /// Callback to change the current index from gesture scrolling
  ///
  /// Only used if [animatePageTransition] is true and [useFadeTransition] is false
  final void Function(int index) swipeToIndex;

  @override
  State<ImplicitlyAnimatedPageView> createState() =>
      _ImplicitlyAnimatedPageViewState();
}

class _ImplicitlyAnimatedPageViewState extends State<ImplicitlyAnimatedPageView>
    with SingleTickerProviderStateMixin {
  int _warpUnderwayCount = 0;
  late List<Widget> _children;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    _children = widget.children;
    // _children = [
    //   const ColoredBox(
    //     color: Colors.blue,
    //     child: Center(child: Text('Books Details Screen')),
    //   ),
    //   const ColoredBox(
    //     color: Colors.deepPurpleAccent,
    //     child: Center(child: Text('Profile Details Screen')),
    //   ),
    //   const ColoredBox(
    //     color: Colors.grey,
    //     child: Center(child: Text('Settings Details Screen')),
    //   )
    // ];
  }

  @override
  void didUpdateWidget(covariant ImplicitlyAnimatedPageView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_warpUnderwayCount == 0 && widget.children != oldWidget.children) {
      _children = widget.children;
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = usePageController(
      initialPage: widget.currentIndex,
      keepPage: false,
    );
    useValueChanged(
      widget.currentIndex,
      (oldValue, _) async {
        if (widget.currentIndex == oldValue) return;

        if (!widget.useFadeTransition) {
          await _warpToCurrentIndex(widget.currentIndex, oldValue, controller);
        }
      },
    );

    if (widget.useFadeTransition) {
      return AnimatedSwitcher(
        duration:
            widget.animatePageTransition ? widget.duration : Duration.zero,
        child: widget.children[widget.currentIndex],
      );
    }

    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        if (_warpUnderwayCount > 0) return false;
        if (notification.depth != 0) return false;
        if (notification is ScrollUpdateNotification) {
          final int newIndex = controller.page!.round();
          if (newIndex != widget.currentIndex) {
            widget.swipeToIndex(newIndex);
          }
          _isDragging = true;
        }
        return false;
      },
      child: PageView.builder(
        scrollDirection: widget.scrollDirection,
        onPageChanged: (index) {
          if (_isDragging) {
            widget.swipeToIndex(index);
            _isDragging = false;
          }
        },
        allowImplicitScrolling: false,
        controller: controller,
        dragStartBehavior: widget.dragStartBehavior,
        physics: widget.physics == null
            ? const PageScrollPhysics().applyTo(const ClampingScrollPhysics())
            : const PageScrollPhysics().applyTo(widget.physics),
        itemBuilder: (context, index) => _children[index],
      ),
    );
  }

  Future<void> _warpToCurrentIndex(
      int activeIndex, int previousIndex, PageController controller) async {
    if (activeIndex == previousIndex) return Future<void>.value();
    if (!mounted) return Future<void>.value();

    final bool animatePageTransition = widget.animatePageTransition;

    _warpUnderwayCount += 1;
    // if ((activeIndex - previousIndex).abs() == 1) {
    //   if (_warpUnderwayCount > 0) {
    //     setState(() {
    //       _children = List<Widget>.of(widget.children, growable: false);
    //     });
    //   }
    //   _warpUnderwayCount += 1;
    //   if (animatePageTransition) {
    //     await controller.animateToPage(activeIndex,
    //         duration: widget.duration, curve: widget.curve);
    //   } else {
    //     controller.jumpToPage(activeIndex);
    //   }
    //   _warpUnderwayCount -= 1;
    //   return Future<void>.value();
    // }
    // assert((activeIndex - previousIndex).abs() > 1,
    //     'active and previous index should not be the same');
    //
    // // If we are going to a page that is not adjacent to the current page,
    // // we need to rebuild the children so that the new page is one away
    // // from the current page, and then we jump to the new page.
    // // Otherwise the PageView will flash quickly as it
    // // shows each page in between, and this is undesirable.
    //
    // final int initialPage =
    //     activeIndex > previousIndex ? activeIndex - 1 : activeIndex + 1;
    // if (_warpUnderwayCount > 0) {
    //   setState(() {
    //     _warpUnderwayCount += 1;
    //     _children = List<Widget>.of(widget.children, growable: false);
    //     _children = _children.swap(initialPage, previousIndex);
    //     final position = controller.position;
    //     final double pixels = activeIndex > previousIndex
    //         ? position.extentAfter
    //         : position.extentBefore;
    //     final double pixelsPerPage = position.viewportDimension;
    //     final double pixelsToActiveIndex = activeIndex * pixelsPerPage - pixels;
    //
    //     final double newPositionPixels =
    //         initialPage * pixelsPerPage + pixelsToActiveIndex;
    //     controller.jumpTo(newPositionPixels);
    //   });
    // } else {
    //   setState(() {
    //     _warpUnderwayCount += 1;
    //     _children = _children.swap(initialPage, previousIndex);
    //   });
    //   controller.jumpToPage(initialPage);
    // }
    setState(() {
      _children = List<Widget>.of(_children);
    });
    if (animatePageTransition) {
      await controller.animateToPage(activeIndex,
          duration: widget.duration, curve: widget.curve);
    } else {
      controller.jumpToPage(activeIndex);
    }
    // if (!mounted) return Future<void>.value();
    // setState(() {
    //   if (_warpUnderwayCount > 0) {
    //     _children = _children.swap(initialPage, previousIndex);
    //     _children = _children.swap(activeIndex, initialPage);
    //   } else {
    //     _children = _children.swap(initialPage, previousIndex);
    //   }
    // });

    _warpUnderwayCount -= 1;
    if (!mounted) return Future<void>.value();
    setState(() {});
  }
}
