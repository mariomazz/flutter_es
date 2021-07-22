import 'package:es_2021071916/models/person.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CardPerson extends StatelessWidget {
  CardPerson({Key? key, required this.person}) : super(key: key);

  Person person;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 100,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 1,
          margin: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: CachedNetworkImage(
                      fit: BoxFit.fill,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      imageUrl: person.imageProfileUrl.toString(),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.transparent,
                  child: Center(child: Text(person.name.toString())),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.transparent,
                  child: Center(child: Text(person.surname.toString())),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
