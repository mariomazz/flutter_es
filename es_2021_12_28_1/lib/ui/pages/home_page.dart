import 'package:deo_demo/core/api_service/api_service.dart';
import 'package:deo_demo/core/providers/authentication/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);
  static ValueKey keyPage = ValueKey('home_page');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Home Page',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor:
            Provider.of<AuthProvider>(context, listen: false).isLoggedIn
                ? Colors.yellow
                : Colors.red,
        actions: [
          IconButton(
            onPressed: () =>
                Provider.of<AuthProvider>(context, listen: false).logIn(),
            icon: Icon(
              Icons.ac_unit,
            ),
          )
        ],
      ),
      body: FutureBuilder<dynamic>(
        future: Provider.of<ApiService>(context, listen: false).getWarnings(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SingleChildScrollView(
              child: Text('${snapshot.data}'),
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
