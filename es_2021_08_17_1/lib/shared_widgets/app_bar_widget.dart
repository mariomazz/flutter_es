import 'package:flutter/material.dart';
import 'package:reciperlich/constants/colors.dart';
import 'package:reciperlich/shared_widgets/image_with_top_shadow_widget.dart';

class AppBarWidget extends StatelessWidget {
  final String text;
  final String imagePath;
  final bool centerTitle;

  const AppBarWidget({
    Key key,
    @required this.text,
    @required this.imagePath,
    this.centerTitle = false,
  })  : assert(text != null),
        assert(imagePath != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text(
        text,
        style: const TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: AppColors.navy,
      centerTitle: centerTitle,
      expandedHeight: 200.0,
      pinned: true,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        background: ImageWithTopShadowWidget(imagePath),
      ),
    );
  }
}
