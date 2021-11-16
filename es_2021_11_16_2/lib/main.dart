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
          if (page == Page.DETAIL || page == Page.DETAIL_DETAIL)
            MaterialPage(
              key: ValueKey('detail'),
              child: DetailPage(
                detailDetailPage: (Page page) {
                  setState(() {
                    this.page = page;
                  });
                },
              ),
            ),
          if (page == Page.DETAIL_DETAIL)
            MaterialPage(
              key: ValueKey('detail_detail'),
              child: DetailDetailPage(),
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: InkWell(
          onTap: () => detailPage.call(Page.DETAIL),
          child: Text('home'),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class DetailPage extends StatelessWidget {
  DetailPage({Key? key, required this.detailDetailPage}) : super(key: key);
  void Function(Page page) detailDetailPage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: InkWell(
          onTap: () => detailDetailPage.call(Page.DETAIL_DETAIL),
          child: Text('detalil'),
        ),
      ),
    );
  }
}

class DetailDetailPage extends StatelessWidget {
  const DetailDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Text('detail detail'),
      ),
    );
  }
}

enum Page { HOME, DETAIL, DETAIL_DETAIL }
