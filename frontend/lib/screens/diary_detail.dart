import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../services/api_service.dart';

class Gap extends StatelessWidget {
  /// Creates a widget that takes a fixed [mainAxisExtent] of space in the
  /// direction of its parent.
  ///
  /// The [mainAxisExtent] must not be null and must be positive.
  /// The [crossAxisExtent] must be either null or positive.
  const Gap(
    this.mainAxisExtent, {
    Key? key,
    this.crossAxisExtent,
    this.color,
  })  : assert(mainAxisExtent >= 0 && mainAxisExtent < double.infinity),
        assert(crossAxisExtent == null || crossAxisExtent >= 0),
        super(key: key);

  /// Creates a widget that takes a fixed [mainAxisExtent] of space in the
  /// direction of its parent and expands in the cross axis direction.
  ///
  /// The [mainAxisExtent] must not be null and must be positive.
  const Gap.expand(
    double mainAxisExtent, {
    Key? key,
    Color? color,
  }) : this(
          mainAxisExtent,
          key: key,
          crossAxisExtent: double.infinity,
          color: color,
        );

  /// The amount of space this widget takes in the direction of its parent.
  ///
  /// For example:
  /// - If the parent is a [Column] this is the height of this widget.
  /// - If the parent is a [Row] this is the width of this widget.
  ///
  /// Must not be null and must be positive.
  final double mainAxisExtent;

  /// The amount of space this widget takes in the opposite direction of the
  /// parent.
  ///
  /// For example:
  /// - If the parent is a [Column] this is the width of this widget.
  /// - If the parent is a [Row] this is the height of this widget.
  ///
  /// Must be positive or null. If it's null (the default) the cross axis extent
  /// will be the same as the constraints of the parent in the opposite
  /// direction.
  final double? crossAxisExtent;

  /// The color used to fill the gap.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    ScrollableState? scrollableState;
    try {
      // TODO: call Scrollable.maybeOf when available on stable.
      scrollableState = Scrollable.of(context);
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      scrollableState = null;
    }

    final AxisDirection? axisDirection = scrollableState?.axisDirection;
    final Axis? fallbackDirection =
        axisDirection == null ? null : axisDirectionToAxis(axisDirection);

    return Padding(
      padding: EdgeInsets.only(
        top: fallbackDirection == Axis.vertical ? mainAxisExtent : 0,
        bottom: fallbackDirection == Axis.vertical ? mainAxisExtent : 0,
        left: fallbackDirection == Axis.horizontal ? mainAxisExtent : 0,
        right: fallbackDirection == Axis.horizontal ? mainAxisExtent : 0,
      ),
      // mainAxisExtent,
      // crossAxisExtent: crossAxisExtent,
      // color: color,
      // fallbackDirection: fallbackDirection,
    );
  }
}

class SeparatedFlex extends StatelessWidget {
  const SeparatedFlex({
    Key? key,
    required this.children,
    required this.direction,
    required this.separatorBuilder,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.max,
    this.verticalDirection = VerticalDirection.down,
    this.textBaseline = TextBaseline.alphabetic,
    this.textDirection = TextDirection.ltr,
    this.padding = EdgeInsets.zero,
  }) : super(key: key);

  final Axis direction;
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;
  final TextBaseline textBaseline;
  final TextDirection textDirection;
  final VerticalDirection verticalDirection;
  final EdgeInsets padding;

  /// Return a widget, to be used in between each child widget
  final Widget Function() separatorBuilder;

  @override
  Widget build(BuildContext context) {
    List<Widget> c = List.of(children);
    for (var i = c.length; i-- > 0;) {
      if (i > 0) c.insert(i, separatorBuilder());
    }
    Widget row = Flex(
      direction: direction,
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      textBaseline: textBaseline,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      children: c,
    );
    return Padding(padding: padding, child: row);
  }
}

/// Allows you to inject a widget between each item in the row
class SeparatedRow extends StatelessWidget {
  const SeparatedRow({
    Key? key,
    required this.children,
    required this.separatorBuilder,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.max,
    this.verticalDirection = VerticalDirection.down,
    this.textBaseline = TextBaseline.alphabetic,
    this.textDirection = TextDirection.ltr,
    this.padding = EdgeInsets.zero,
  }) : super(key: key);

  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;
  final TextBaseline textBaseline;
  final TextDirection textDirection;
  final VerticalDirection verticalDirection;
  final EdgeInsets padding;

  /// Return a widget, to be used in between each child widget
  final Widget Function() separatorBuilder;

  @override
  Widget build(BuildContext context) => SeparatedFlex(
        separatorBuilder: separatorBuilder,
        direction: Axis.horizontal,
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        mainAxisSize: mainAxisSize,
        textBaseline: textBaseline,
        textDirection: textDirection,
        verticalDirection: verticalDirection,
        padding: padding,
        children: children,
      );
}

class DiaryDetail extends StatefulWidget {
  const DiaryDetail({super.key});

  @override
  State<DiaryDetail> createState() => _DiaryDetailState();
}

class _DiaryDetailState extends State<DiaryDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SeparatedRow(
            padding: EdgeInsets.symmetric(horizontal: 16),
            separatorBuilder: () => Gap(16),
            children: [
              Expanded(
                child: Divider(
                  color: Colors.blue,
                ).animate().scale(curve: Curves.easeOut, delay: 500.ms),
              ),
              Semantics(
                header: true,
                // sortKey: 1,
                child: Text('subtitle'
                        // data.subTitle.toUpperCase(),
                        // style: $styles.text.title2,
                        )
                    .animate()
                    .fade(delay: 100.ms),
              ),
              Expanded(
                child: Divider(
                  color: Colors.yellow,
                ).animate().scale(curve: Curves.easeOut, delay: 500.ms),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
