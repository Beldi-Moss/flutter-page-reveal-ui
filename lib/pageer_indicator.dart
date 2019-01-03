import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intro/pages.dart';

class PageBubble extends StatelessWidget {
  final PagerBubbleViewModel viewModel;
  PageBubble({this.viewModel});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Container(
        width: lerpDouble(20.0, 45.0, viewModel.activePercent),
        height: lerpDouble(20.0, 45.0, viewModel.activePercent),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: viewModel.isHollow ? Colors.transparent : Color(0X88FFFFFF),
            border: Border.all(
                width: 3.0,
                color: viewModel.isHollow
                    ? Color(0X88FFFFFF)
                    : Colors.transparent)),
        child: Opacity(
            opacity: viewModel.activePercent,
            child: Image.asset(viewModel.iconAssetPath, color: Colors.blue)),
      ),
    );
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
      final page = viewModal.pages[i];
      bubbles.add(PageBubble(
        viewModel: PagerBubbleViewModel(page.iconAssetIcon, page.color,
            i == viewModal.activeIndex ? 1.0 : 0, i > viewModal.activeIndex),
      ));
    }
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: bubbles,
        )
      ],
    );
  }
}
