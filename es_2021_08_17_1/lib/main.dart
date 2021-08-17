import 'package:flutter/material.dart';
import 'package:reciperlich/pages/recipe_list/recipe_list_page.dart';

void main() {
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reciperlich',
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: const RecipeListPage(),
    );
  }
}
