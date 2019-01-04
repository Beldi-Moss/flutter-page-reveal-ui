import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intro/pageer_indicator.dart';

class PageDragger extends StatefulWidget {
  final StreamController<SlideUpdate> slideUpdateStream;
  bool toLeft;
  bool toRight;
  PageDragger({this.slideUpdateStream, this.toLeft, this.toRight});
  _PageDraggerState createState() => _PageDraggerState();
}

class _PageDraggerState extends State<PageDragger> {
  //when t make drag
  static double VALID_TRANSITION = 300.0;
  // get start drag point
  Offset dragstart;
  SlideDirection direction;
  double slidePercent;
  dragStart(DragStartDetails detail) {
    dragstart = detail.globalPosition;
  }

  dragUpdate(DragUpdateDetails detail) {
    if (dragstart != null) {
      final currentPosition = detail.globalPosition;
      final diff = dragstart.dx - currentPosition.dx;
      if (diff > 0.0 && widget.toLeft) {
        this.direction = SlideDirection.rightToLeft;
      } else if (diff < 0.0 && widget.toRight) {
        this.direction = SlideDirection.leftToRight;
      } else
        this.direction = SlideDirection.none;
      if (this.direction != SlideDirection.none) {
        slidePercent = (diff / VALID_TRANSITION).abs().clamp(0.0, 1.0);
      } else
        slidePercent = 0.0;

      SlideUpdate sl = new SlideUpdate(
          updateType: UpdateType.draggin,
          direction: this.direction,
          slidePercent: this.slidePercent);

      widget.slideUpdateStream.add(sl);
    }
  }

  dragEnd(DragEndDetails detail) {
    SlideUpdate sl = new SlideUpdate(
        updateType: UpdateType.doneDraggin,
        direction: SlideDirection.none,
        slidePercent: 0.0);

    widget.slideUpdateStream.add(sl);
    dragstart = null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onHorizontalDragStart: dragStart,
        onHorizontalDragUpdate: dragUpdate,
        onHorizontalDragEnd: dragEnd,
      ),
    );
  }
}

enum UpdateType { doneDraggin, draggin }

// to emit slide update to app use stream
class SlideUpdate {
  final updateType;
  final direction;
  final slidePercent;
  SlideUpdate({this.updateType, this.direction, this.slidePercent});
}
