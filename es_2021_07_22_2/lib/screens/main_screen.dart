import 'dart:io';
import 'dart:math';
import 'package:es_2021071916/models/person.dart';
import 'package:es_2021071916/widgets/card_person.dart';
import 'package:es_2021071916/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import '../main.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key, this.filterList}) : super(key: key);
  String? filterList;

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool connectionServer = false;
  Map<String, dynamic> _persons = {};

  @override
  Future<String> requestPersons() async {
    var url = Uri.http("192.168.1.213:3000", "/data/persons");

    var response = await http.get(url);
    if (response.statusCode == 100) {
      setState(() {
        connectionServer = true;
      });
      return Future.value('progress');
    } else if (response.statusCode == 200) {
      _persons = convert.jsonDecode(response.body) as Map<String, dynamic>;
      setState(() {
        connectionServer = true;
      });
      return Future.value('done');
    } else {
      return Future.value('error');
    }
  }

  Widget build(BuildContext context) {
    if (widget.filterList == null) {
      setState(() {
        widget.filterList = 'list not filtered';
      });
    }
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Scaffold(
        body: CustomScrollView(slivers: [
          SliverAppBar(
            title: Text(
              'AppBar',
            ),
            automaticallyImplyLeading: false,
            actions: [
              connectionServer
                  ? RawMaterialButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/search/persons',
                            arguments: widget.filterList);
                      },
                      elevation: 0,
                      fillColor: Colors.white,
                      child: Icon(
                        Icons.search,
                        size: 35.0,
                        color: Colors.black,
                      ),
                      shape: CircleBorder(),
                    )
                  : Container(),
            ],
            backgroundColor: Colors.lightBlueAccent,
          ),
          visualizationTitleListPersons(),
          SliverFillRemaining(
            child: FutureBuilder<String>(
              future: requestPersons(),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.data == 'progress') {
                  return Center(
                    child: Container(
                      child: CircularProgressIndicator(
                        color: Colors.grey[300],
                      ),
                    ),
                  );
                } else if (snapshot.data == 'done') {
                  return buildListPersons();
                } else if (snapshot.data == 'error') {
                  return Center(
                    child: Container(
                      child: Icon(
                        Icons.error,
                        color: Colors.red,
                        size: 150,
                      ),
                    ),
                  );
                } else {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Server not responding',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Icon(
                              Icons.error,
                              color: Colors.red,
                              size: 150,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ]),
        floatingActionButton: (_persons.isEmpty)
            ? RawMaterialButton(
                onPressed: () {
                  AppBuilder.of(context)!.rebuild();
                },
                elevation: 0,
                fillColor: Colors.orange[200],
                child: Icon(
                  Icons.refresh,
                  size: 35.0,
                ),
                padding: EdgeInsets.all(15.0),
                shape: CircleBorder(),
              )
            : null,
      ),
    );
  }

  Widget buildListPersons() {
    if (_persons[widget.filterList] != null) {
      return ListView.builder(
        itemCount: _persons[widget.filterList].length as int,
        itemBuilder: (context, index) {
          return CardPerson(
            person: Person(
              name: _persons[widget.filterList][index]['name'].toString(),
              surname: _persons[widget.filterList][index]['surname'].toString(),
              imageProfileUrl: _persons[widget.filterList][index]
                      ['profile-image-url']
                  .toString(),
            ),
          );
        },
      );
    } else {
      return Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'list persons not found',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('/search/persons',
                      arguments: widget.filterList);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.search,
                    size: 200,
                    color: Colors.grey[300],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget visualizationTitleListPersons() {
    if (_persons[widget.filterList] != null) {
      return SliverPersistentHeader(
        pinned: true,
        delegate: _SliverPersistantHeaderDelegate(
          child: Container(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${widget.filterList}',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          minHeight: 30,
          maxHeight: 50,
        ),
      );
    } else {
      return SliverPersistentHeader(
        delegate: _SliverPersistantHeaderDelegate(
          child: Container(),
          minHeight: 0,
          maxHeight: 0,
        ),
      );
    }
  }
}

class _SliverPersistantHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverPersistantHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  // 2
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  // 3
  @override
  bool shouldRebuild(_SliverPersistantHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
