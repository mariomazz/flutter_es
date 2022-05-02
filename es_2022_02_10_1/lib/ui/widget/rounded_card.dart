import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

import 'package:es_2022_02_10_1/ui/widget/padding.dart';

class RoundedCard extends StatelessWidget {
  const RoundedCard({
    Key? key,
    required this.data,
    this.backgroundColor = Colors.white,
    this.radius = 20.0,
    this.textColor = Colors.black,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 15,
    ),
  }) : super(key: key);

  final String data;
  final Color backgroundColor;
  final double radius;
  final Color textColor;
  final EdgeInsets padding;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor == textColor
            ? backgroundColor.withOpacity(0.5)
            : backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(radius)),
      ),
      child: Stack(
        children: [
          IntrinsicHeight(
            child: Column(
              children: [
                PaddingCS(
                  child: Text(
                    data,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 17,
                    ),
                  ),
                ),
                const Expanded(
                  child: Text(""),
                ),
              ],
            ),
          ),
          Positioned(
            child: Text(
              formatDate(
                DateTime.now(),
                [HH, ':', nn],
                locale: const ItalianDateLocale(),
              ),
              style: TextStyle(
                color: textColor,
                fontSize: 12,
              ),
            ),
            right: 7,
            bottom: 5,
          ),
        ],
      ),
    );
  }
}
