import 'package:flutter/material.dart';

class Page404 extends StatelessWidget {
  const Page404({Key? key}) : super(key: key);
  static final LocalKey keyPage = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NOT FOUND 404'),
        elevation: 0,
      ),
      body: const Center(
        child: Text('NOT FOUND 404'),
      ),
    );
  }
}
