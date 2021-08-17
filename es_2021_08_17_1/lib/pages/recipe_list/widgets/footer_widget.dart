import 'package:flutter/material.dart';
import 'package:reciperlich/constants/colors.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RichText(
          text: const TextSpan(
            style: TextStyle(color: AppColors.navy, fontSize: 30),
            children: <TextSpan>[
              TextSpan(text: 'Made with ❤️ by '),
              TextSpan(
                  text: 'raywendelich.com',
                  style: TextStyle(color: AppColors.darkGreen)),
            ],
          ),
          textScaleFactor: 0.5,
        ),
        const SizedBox(height: 50),
      ],
    );
  }
}
