import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardNumberCenter extends StatelessWidget {
  CardNumberCenter(
      {Key? key, required this.number, this.actionCard, this.toShare})
      : super(key: key);
  int number;
  void Function()? toShare;
  void Function()? actionCard;

  @override
  Widget build(BuildContext context) {
    var dataLayout = MediaQuery.of(context);
    return Container(
      decoration: (BoxDecoration(
        color: const Color.fromRGBO(255, 202, 212, 1),
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 0),
            blurRadius: 5,
            color: Colors.black.withAlpha(15),
            spreadRadius: 5,
          ),
        ],
      )),
      margin: const EdgeInsets.all(30),
      child: AspectRatio(
        aspectRatio: dataLayout.size.width / (dataLayout.size.height / 2),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          child: GestureDetector(
            onTap: actionCard,
            child: Stack(children: [
              Container(
                decoration: (BoxDecoration(
                  color: const Color.fromRGBO(255, 202, 212, 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                )),
                child: Center(
                  child: Text(
                    number.toString(),
                    style: GoogleFonts.notoSans(
                      fontStyle: FontStyle.normal,
                      color: Colors.black,
                      fontSize: ((30 * dataLayout.size.width) / 426 < 65)
                          ? (30 * dataLayout.size.width) / 426
                          : 65,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: GestureDetector(
                  onTap: toShare,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.share,
                      size: ((30 * dataLayout.size.width) / 426 < 65)
                          ? (30 * dataLayout.size.width) / 426
                          : 65,
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
