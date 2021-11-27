import 'dart:developer';

import 'package:flutter/material.dart';

class ListItemPage extends StatefulWidget {
  const ListItemPage({Key? key}) : super(key: key);

  @override
  _ListItemPageState createState() => _ListItemPageState();
}

class _ListItemPageState extends State<ListItemPage> {
  bool loadingData = false;

  final List<ListTile> items = [];

  final ListTile item = ListTile(title: Text('Ciao Mario'));

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < 20; i++) {
      this.items.addAll([item]);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final layoutData = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          NotificationListener<ScrollEndNotification>(
            onNotification: (scrollEnd) {
              if (scrollEnd.metrics.pixels >=
                      scrollEnd.metrics.maxScrollExtent &&
                  !loadingData &&
                  items.length < 100) {
                log('load data');
                this.loadData();
              }
              return true;
            },
            child: ListView.separated(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Text('${index + 1}'),
                    Expanded(child: Container(child: items[index])),
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  height: 1,
                );
              },
            ),
          ),
          loadingData
              ? Positioned(
                  bottom: 0,
                  left: 0,
                  child: Container(
                    width: layoutData.size.width,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 8.0,
                          bottom: 20.0,
                          right: 8.0,
                          left: 8.0,
                        ),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  Future<void> loadData() async {
    setState(() {
      this.loadingData = true;
    });
    await Future.delayed(
      Duration(milliseconds: 200),
      () => setState(() {
        for (int i = 0; i < 10; i++) {
          this.items.addAll([item]);
        }
        this.loadingData = false;
      }),
    );
  }
}
