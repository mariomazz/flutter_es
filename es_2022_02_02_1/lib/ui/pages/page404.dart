import 'package:flutter/material.dart';

class Page404 extends StatelessWidget {
  const Page404({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NOT FOUND 404'),
        elevation: 0,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            Navigator.pop(context);
          },
          child: const Text('NOT FOUND 404'),
        ),
      ),
    );
  }
}
