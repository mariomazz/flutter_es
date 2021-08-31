import 'dart:convert';
import 'package:chopper/chopper.dart';
import 'package:es_2021_08_29_1/services/registration.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Response>(
      future: Provider.of<RegistrationService>(context)
          .registrationRequest({'body': 'dati registrazione'}),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: Colors.redAccent,
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'error connection server...',
                    style: TextStyle(fontSize: 40),
                  ),
                  Icon(
                    Icons.error_rounded,
                    size: 80,
                    color: Colors.redAccent,
                  ),
                ],
              ),
            ),
          );
        } else {
          // var response = snapshot.data!.bodyString;
          final Map<String, dynamic> response =
              json.decode(snapshot.data!.bodyString);
          /*return Center(
              child: Text("registrations : " + response['state_registration'].toString()),
            );*/
          return Scaffold(
            appBar: AppBar(
              leading: GestureDetector(
                onTap: () => Navigator.of(context).pushNamed('/'),
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "registration : " +
                        response['state_registration'].toString(),
                    style: TextStyle(fontSize: 40),
                  ),
                  Icon(
                    Icons.check,
                    size: 80,
                    color: Colors.greenAccent,
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
