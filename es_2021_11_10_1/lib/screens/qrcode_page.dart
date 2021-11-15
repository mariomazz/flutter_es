import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

// ignore: must_be_immutable
class QrCodePage extends StatefulWidget {
  QrCodePage({Key? key, required this.navigateToHomePage}) : super(key: key);
  void Function({String scanValue, required bool popUpValue})
      navigateToHomePage;

  @override
  State<QrCodePage> createState() => _QrCodePageState();
}

class _QrCodePageState extends State<QrCodePage> {
  String? qrCode = '';

  Future<String?> scanQRCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );

      return qrCode;
    } on PlatformException {
      qrCode = 'Failed to get platform version.';
    }
  }

  void initState() {
    scanQRCode().then((value) {
      if (value != null && value != '' && value != '-1') {
        log(value);
        qrCode = value;
        widget.navigateToHomePage.call(scanValue: qrCode!, popUpValue: true);
      } else {
        widget.navigateToHomePage.call(popUpValue: false);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '$qrCode',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );
}
