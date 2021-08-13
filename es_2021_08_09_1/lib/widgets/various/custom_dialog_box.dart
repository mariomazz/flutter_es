import 'dart:ui';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomDialogBox extends StatefulWidget {
  final String title, descriptions, primaryButtonTitle;
  String? secondaryButtonTitle;
  final Function primaryButtonDidTapHandler;
  Function? secondaryButtonDidTapHandler;

  CustomDialogBox({
    Key? key,
    required this.title,
    required this.descriptions,
    required this.primaryButtonTitle,
    this.secondaryButtonTitle,
    required this.primaryButtonDidTapHandler,
    this.secondaryButtonDidTapHandler,
  }) : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  Widget contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
              left: Constants.padding,
              top: Constants.padding,
              right: Constants.padding,
              bottom: Constants.padding / 2),
          margin: EdgeInsets.only(top: Constants.avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(Constants.padding),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(5),
                  offset: Offset(0, -2),
                  blurRadius: 10,
                  spreadRadius: 5,
                ),
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                widget.title,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                widget.descriptions,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.normal),
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: AspectRatio(
                  aspectRatio: 317 / 58,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(58),
                    ),
                    // ignore: deprecated_member_use
                    child: FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        this.widget.primaryButtonDidTapHandler();
                      },
                      color: Theme.of(context).primaryColor,
                      child: Text(
                        this.widget.primaryButtonTitle,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              this.widget.secondaryButtonDidTapHandler != null &&
                      this.widget.secondaryButtonTitle != null
                  ? Align(
                      alignment: Alignment.bottomCenter,
                      // ignore: deprecated_member_use
                      child: FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          this.widget.secondaryButtonDidTapHandler!();
                        },
                        child: Text(
                          this.widget.secondaryButtonTitle!,
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ],
    );
  }
}

class Constants {
  Constants._();
  static const double padding = 33;
  static const double avatarRadius = 45;
}
