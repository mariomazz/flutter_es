import 'package:es_2021_08_23_1/screens/posts/posts_screen.dart';
import 'package:es_2021_08_23_1/screens/users/users_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int number = 0;
  increment() {
    setState(() {
      number += 1;
    });
  }

  final Map<int, Widget> myTabs = const <int, Widget>{
    0: Text("posts"),
    1: Text("users"),
  };

  Object? currentSelection = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: currentSelection == 0
            ? Text('posts screen ${number}')
            : Text('users screen ${number}'),
      ),
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: CupertinoSlidingSegmentedControl(
                groupValue: currentSelection,
                children: myTabs,
                onValueChanged: (i) {
                  setState(() {
                    currentSelection = i;
                  });
                },
              ),
            ),
          ),
          currentSelection == 0
              ? Expanded(
                  child: PostsScreen(),
                )
              : Expanded(
                  child: UsersScreen(),
                ),
        ],
      ),
      floatingActionButton: ClipOval(
        child: Material(
          color: Colors.blue,
          child: InkWell(
            splashColor: Colors.red,
            onTap: () {
              increment();
              print(number);
            },
            child: SizedBox(width: 56, height: 56, child: Icon(Icons.menu)),
          ),
        ),
      ),
    );
  }
}
