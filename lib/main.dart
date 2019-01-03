import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Page(
          viewModel: pages[0],
          percentVisible: 1,
        ),
        PageReveal(
            revealPercent: 0.1,
            child: Page(
              viewModel: pages[1],
              percentVisible: 1,
            )),
        PageIndicator(
          viewModal:
              PagerIndicatorViewModel(pages, SlideDirection.none, 0.0, 1),
        )
      ],
    ));
  }
}
