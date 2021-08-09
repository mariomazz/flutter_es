import 'package:es_2021_08_09_1/models/user.dart';
import 'package:es_2021_08_09_1/services/service_users.dart';
import 'package:es_2021_08_09_1/widgets/card_users.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('app bar'),
      ),
      body: FutureBuilder<List<User>>(
        future: ServiceUsers.getUsers(),
        builder: (context, snapshot) {
          List<User> mySnapshotData = snapshot.data ?? [];

          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.separated(
                separatorBuilder: (context, index) => Container(
                      height: 50,
                    ),
                itemCount: mySnapshotData.length,
                itemBuilder: (context, index) => CardUsers(
                      user: mySnapshotData[index],
                    ));
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
