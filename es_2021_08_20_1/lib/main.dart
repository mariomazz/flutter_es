import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  final pageController = PageController();
  int index = 0;
  @override
  void initState() {
    super.initState();
    pageController.addListener(
      () => setState(() {
        index = pageController.page!.round();
      }),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: PageView.builder(
          controller: pageController,
          itemBuilder: (_, index) => Container(
            color: Colors.red,
            child: Center(
                child: Text(
                    "${MediaQuery.of(context).size.width} --  $index -- $index")),
          ),
          itemCount: 3,
          onPageChanged: (page) => print("onPageChanged: $page"),
        ),
      );
}
