import 'package:flutter/material.dart';

@immutable
class RecipeModel {
  final String title;
  final List<String> ingredients;
  final List<String> details;
  final String whereToBuy;
  final String instructions;
  final String iconPath;
  final String mainImagePath;
  final Color itemColor;

  const RecipeModel({
    @required this.title,
    @required this.ingredients,
    @required this.whereToBuy,
    @required this.instructions,
    @required this.iconPath,
    @required this.mainImagePath,
    @required this.itemColor,
    @required this.details,
  });
}
