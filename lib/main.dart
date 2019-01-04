import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intro/pageDragger.dart';
import 'package:intro/page_reveal.dart';
import 'package:intro/pageer_indicator.dart';
import 'package:intro/pages.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyHomePage> {
  int nextPage = 0;
  int activeIndex = 0;
  SlideDirection slideDirection = SlideDirection.none;
  StreamController<SlideUpdate> slideStream;
  double slidePercent = 0.0;

  _MyAppState() {
    this.slideStream = new StreamController<SlideUpdate>();
    this.slideStream.stream.listen((SlideUpdate data) {
      setState(() {
        if (data.updateType == UpdateType.draggin) {
          slideDirection = data.direction;
          slidePercent = data.slidePercent;

          if (slideDirection == SlideDirection.rightToLeft) {
            nextPage = activeIndex + 1;
          } else if (slideDirection == SlideDirection.leftToRight) {
            nextPage = activeIndex - 1;
          } else {
            nextPage = activeIndex;
          }
        } else if (data.updateType == UpdateType.doneDraggin) {
          print("done ");
          print(this.slidePercent);
          if (this.slidePercent > 0.5) {
            activeIndex = slideDirection == SlideDirection.leftToRight
                ? activeIndex - 1
                : activeIndex + 1;
          }

          slideDirection = SlideDirection.none;
          slidePercent = 0.0;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print(999999999999999);

    print(this.activeIndex);
    return Scaffold(
        body: Stack(
      children: <Widget>[
        PageReveal(
            revealPercent: 1,
            child: Page(
              viewModel: pages[this.activeIndex],
              percentVisible: 1,
            )),
        PageReveal(
            revealPercent: this.slidePercent,
            child: Page(
              viewModel: pages[nextPage],
              percentVisible: 1,
            )),
        PageIndicator(
          viewModal: PagerIndicatorViewModel(
              pages, this.slideDirection, this.slidePercent, this.activeIndex),
        ),
        PageDragger(
          slideUpdateStream: this.slideStream,
          toRight: activeIndex > 0,
          toLeft: activeIndex < pages.length - 1,
        )
      ],
    ));
  }
}
