import 'package:flutter/material.dart';
import 'package:reciperlich/constants/colors.dart';
import 'package:reciperlich/models/recipe_model.dart';
import 'package:reciperlich/pages/recipe/widgets/pill_widget.dart';
import 'package:reciperlich/pages/recipe/widgets/sliver_sub_header.dart';
import 'package:reciperlich/shared_widgets/app_bar_widget.dart';

class RecipePage extends StatelessWidget {
  final RecipeModel recipe;

  const RecipePage(this.recipe, {Key key})
      : assert(recipe != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          AppBarWidget(
            text: recipe.title,
            imagePath: recipe.mainImagePath,
          ),
          SliverSubHeader(
            text: 'Instructions',
            backgroundColor: recipe.itemColor,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                recipe.instructions,
                style: const TextStyle(
                  color: AppColors.navy,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          SliverSubHeader(
            text: 'Ingredients',
            backgroundColor: recipe.itemColor,
          ),
          SliverPadding(
            padding: const EdgeInsets.all(15),
            sliver: SliverGrid.count(
              mainAxisSpacing: 15,
              crossAxisSpacing: 10,
              crossAxisCount: 3,
              childAspectRatio: 3,
              children: recipe.ingredients.map((e) => PillWidget(e)).toList(),
            ),
          ),
          SliverSubHeader(
            text: 'Numbers',
            backgroundColor: recipe.itemColor,
          ),
          SliverPadding(
            padding: const EdgeInsets.all(15),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 4,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) => PillWidget(recipe.details[index]),
                childCount: recipe.details.length,
              ),
            ),
          ),
          SliverFillRemaining(
            child: Container(),
          ),
        ],
      ),
    );
  }
}
