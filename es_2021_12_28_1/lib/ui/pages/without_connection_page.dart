import 'package:flutter/material.dart';

class WithoutConnectionPage extends StatelessWidget {
  const WithoutConnectionPage({Key key}) : super(key: key);
  static ValueKey keyPage = ValueKey('without_connection_page');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<String>(
        future: Future.delayed(
          Duration(
            milliseconds: 0, // or 500
          ),
          () {
            return ('LOAD COMPLETED');
          },
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SizedBox.expand(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('non sei connesso a internet'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.wifi_lock),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('ERRORE'),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
