import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:es_2021_08_29_1/services/registration.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Response>(
        future: Provider.of<RegistrationService>(context)
            .registrationRequest({'body': 'post inviata'}),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('error'),
            );
          } else {
            // var response = snapshot.data!.bodyString;
            var response = json.decode(snapshot.data!.bodyString);
            return Center(
              child: Text(response.toString()),
            );
          }
        },
      ),
    );
  }
}
