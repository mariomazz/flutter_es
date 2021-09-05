import 'package:flutter/material.dart';
import 'package:pageview/models/users/user.dart';

class CardUsers extends StatelessWidget {
  final User user;

  CardUsers({Key? key, required this.user}) : super(key: key);
  final double titleTextSize = 25;
  final double textSize = 20;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15.0),
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        color: Theme.of(context).secondaryHeaderColor,
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
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
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
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.7),
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
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
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
