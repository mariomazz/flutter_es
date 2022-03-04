import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('Rossella Ciotta'),
        elevation: 0,
      ),
      body: SizedBox.expand(
        child: buildList(),
      ),
    );
  }

  Widget buildList() {
    return ListView.builder(
      itemCount: 100,
      itemBuilder: (context, i) {
        return item();
      },
    );
  }

  Widget item() {
    return Dismissible(
      background: Container(
        color: Colors.red,
      ),
      key: UniqueKey(),
      child: const ListTile(
        title: Text('ROSSELLA'),
        subtitle: Text('CIOTTA'),
      ),
    );
  }
}
