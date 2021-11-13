import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  InfoCard({Key? key}) : super(key: key);

  double primaryTextSize = 30;
  double mediumTextSize = 25;
  double smallTextSize = 20;

  @override
  Widget build(BuildContext context) {
        var queryData = MediaQuery.of(context);
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 6),
            blurRadius: 16,
            color: Colors.black.withAlpha(15),
            spreadRadius: 6,
          ),
        ],
      ),
      width: 360 / 428 * queryData.size.width,
      height: 200 /926 * queryData.size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 60 /  926 * queryData.size.height,
                  width: 100 / 428 * queryData.size.width,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 6),
                        blurRadius: 16,
                        color: Colors.black.withAlpha(15),
                        spreadRadius: 6,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    child: FittedBox(
                      child: Image.asset(
                        'assets/img/minimarket.jpeg',
                        fit: BoxFit.fill,
                      ),
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.circular(30),
                    clipBehavior: Clip.hardEdge,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Mini Market 2',
                    style: TextStyle(
                        fontSize: primaryTextSize, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Mariano Rossi',
                    style: TextStyle(fontSize: mediumTextSize),
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Via Molara 2 , Chieti 23456',
                style: TextStyle(fontSize: smallTextSize),
              ),
              Text(
                'minimarketviamolara@gmail.com',
                style: TextStyle(fontSize: smallTextSize),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
