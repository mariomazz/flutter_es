import 'dart:developer';

import 'package:es_2021_11_27_1/core/api_service/api_service.dart';
import 'package:es_2021_11_27_1/core/api_service/models/post/post.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemsPage extends StatefulWidget {
  const ItemsPage({Key? key}) : super(key: key);

  @override
  _ItemsPageState createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
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
                return GestureDetector(
                  onTap: () async {
                    final response =
                        await Provider.of<ApiService>(context, listen: false)
                            .getPosts();
                    log(response.body!.first.id.toString());
                  },
                  child: Row(
                    children: [
                      Text('${index + 1}'),
                      Expanded(child: Container(child: items[index])),
                    ],
                  ),
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

class ListPostsPage extends StatefulWidget {
  const ListPostsPage({Key? key}) : super(key: key);

  @override
  _ListPostsPageState createState() => _ListPostsPageState();
}

class _ListPostsPageState extends State<ListPostsPage> {
  List<PostModel> posts = [];

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
