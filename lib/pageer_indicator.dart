import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intro/pages.dart';

class PageBubble extends StatelessWidget {
  final PagerBubbleViewModel viewModel;
  PageBubble({this.viewModel});
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 55.0,
        height: 65.0,
        child: Center(
          child: Container(
            width: lerpDouble(20.0, 45.0, viewModel.activePercent),
            height: lerpDouble(20.0, 45.0, viewModel.activePercent),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: viewModel.isHollow
                    ? Color(0X88FFFFFF)
                        .withAlpha((0x88 * viewModel.activePercent).round())
                    : Color(0X88FFFFFF),
                border: Border.all(
                    width: 3.0,
                    color: viewModel.isHollow
                        ? Color(0X88FFFFFF).withAlpha(
                            (0x88 * (1.0 - viewModel.activePercent)).round())
                        : Colors.transparent)),
            child: Opacity(
                opacity: viewModel.activePercent,
                child:
                    Image.asset(viewModel.iconAssetPath, color: Colors.blue)),
          ),
        ));
  }
}

class PagerBubbleViewModel {
  final String iconAssetPath;
  final Color color;
  final bool isHollow;
  final double activePercent;

  PagerBubbleViewModel(
      this.iconAssetPath, this.color, this.activePercent, this.isHollow);
}

enum SlideDirection { leftToRight, rightToLeft, none }

class PagerIndicatorViewModel {
  final List<PageViewModel> pages;
  final int activeIndex;
  // direction slide
  final double slidePercent;
  final SlideDirection slideDirection;

  PagerIndicatorViewModel(
      this.pages, this.slideDirection, this.slidePercent, this.activeIndex);
}

class PageIndicator extends StatelessWidget {
  final PagerIndicatorViewModel viewModal;
  PageIndicator({this.viewModal});

  @override
  Widget build(BuildContext context) {
    List<PageBubble> bubbles = [];

    for (var i = 0; i < viewModal.pages.length; ++i) {
      var percentActive;
      bool ishallow = i > viewModal.activeIndex ||
          i == viewModal.activeIndex &&
              viewModal.slideDirection == SlideDirection.leftToRight;
      if (i == viewModal.activeIndex) {
        percentActive = 1.0 - viewModal.slidePercent;
      } else if (i == viewModal.activeIndex - 1 &&
          viewModal.slideDirection == SlideDirection.leftToRight) {
        percentActive = viewModal.slidePercent;
      } else if (i == viewModal.activeIndex + 1 &&
          viewModal.slideDirection == SlideDirection.rightToLeft) {
        percentActive = viewModal.slidePercent;
      } else {
        percentActive = 0.0;
      }
      final page = viewModal.pages[i];
      bubbles.add(PageBubble(
        viewModel: PagerBubbleViewModel(
            page.iconAssetIcon, page.color, percentActive, ishallow),
      ));
    }
    var BUBBLE_WIDTH = 55.0;
    var basetranslate =
        (viewModal.pages.length * BUBBLE_WIDTH) / 2 - BUBBLE_WIDTH / 2;
    var offset = BUBBLE_WIDTH * viewModal.slidePercent;
    if (viewModal.slideDirection == SlideDirection.rightToLeft) {
      offset = -offset;
    }
    var translate =
        basetranslate - (viewModal.activeIndex * BUBBLE_WIDTH) + offset;
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(),
        ),
        Transform(
            transform: Matrix4.translationValues(translate, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: bubbles,
            ))
      ],
    );
  }
}
