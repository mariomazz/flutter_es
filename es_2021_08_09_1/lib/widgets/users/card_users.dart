import 'package:myapp/models/users/user.dart';
import 'package:flutter/material.dart';

class CardUsers extends StatelessWidget {
  final User user;

  CardUsers({Key? key, required this.user}) : super(key: key);
  final double titleTextSize = 25;
  final double textSize = 20;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        color: Colors.redAccent,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'USER',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
              Text(
                'ID : ${user.id}',
                style: TextStyle(
                  fontSize: textSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'NAME : ${user.name}',
                style: TextStyle(
                  fontSize: textSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'USERNAME : ${user.username}',
                style: TextStyle(
                  fontSize: textSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'EMAIL : ${user.email}',
                style: TextStyle(
                  fontSize: textSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'Address',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: titleTextSize),
                          ),
                        ),
                        Text(
                          'STREET : ${user.address.street}',
                          style: TextStyle(fontSize: textSize),
                        ),
                        Text(
                          'SUITE : ${user.address.suite}',
                          style: TextStyle(fontSize: textSize),
                        ),
                        Text(
                          'CITY : ${user.address.city}',
                          style: TextStyle(fontSize: textSize),
                        ),
                        Text(
                          'ZIPCODE : ${user.address.zipcode}',
                          style: TextStyle(fontSize: textSize),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            color: Colors.blueAccent,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      'Geo',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: titleTextSize),
                                    ),
                                  ),
                                  Text(
                                    'LAT : ${user.address.geo.lat}',
                                    style: TextStyle(fontSize: textSize),
                                  ),
                                  Text(
                                    'LNG : ${user.address.geo.lng}',
                                    style: TextStyle(fontSize: textSize),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Text(
                'PHONE : ${user.phone}',
                style: TextStyle(
                  fontSize: textSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'WEBSITE : ${user.website}',
                style: TextStyle(
                  fontSize: textSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'Company',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: titleTextSize),
                          ),
                        ),
                        Text(
                          'NAME : ${user.company.name}',
                          style: TextStyle(fontSize: textSize),
                        ),
                        Text(
                          'CATCHPHRASE : ${user.company.catchPhrase}',
                          style: TextStyle(fontSize: textSize),
                        ),
                        Text(
                          'BS : ${user.company.bs}',
                          style: TextStyle(fontSize: textSize),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
