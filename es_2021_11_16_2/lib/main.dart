import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Page page = Page.HOME;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: Navigator(
        pages: [
          MaterialPage(
            key: ValueKey('home'),
            child: HomePage(
              detailPage: (Page page) {
                setState(() {
                  this.page = page;
                });
              },
            ),
          ),
          if (page == Page.DETAIL)
            MaterialPage(
              key: ValueKey('detail'),
              child: DetailPage(),
            )
        ],
        onPopPage: (route, result) {
          return route.didPop(result);
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({Key? key, required this.detailPage}) : super(key: key);

  void Function(Page page) detailPage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: InkWell(
          onTap: () => detailPage.call(Page.DETAIL),
          child: Text('home'),
        ),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('detail'),
      ),
    );
  }
}

enum Page { HOME, DETAIL }
