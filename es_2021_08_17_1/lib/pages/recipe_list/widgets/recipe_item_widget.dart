import 'package:flutter/material.dart';
import 'package:reciperlich/constants/colors.dart';
import 'package:reciperlich/models/recipe_model.dart';
import 'package:reciperlich/pages/recipe/recipe_page.dart';

class RecipeItem extends StatelessWidget {
  final RecipeModel recipe;

  const RecipeItem(
    this.recipe, {
    Key key,
  })  : assert(recipe != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => routeToRecipePage(context),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 20),
            decoration: BoxDecoration(
              color: recipe.itemColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        recipe.title,
                        style: const TextStyle(
                          fontSize: 20,
                          color: AppColors.navy,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Buy at ${recipe.whereToBuy}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textWidthBasis: TextWidthBasis.parent,
                        style: const TextStyle(
                          fontSize: 15,
                          color: AppColors.navy,
                        ),
                      ),
                    ],
                  ),
                ),
                Image.network(
                  recipe.iconPath,
                  fit: BoxFit.fitWidth,
                  width: 150,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future routeToRecipePage(context) {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RecipePage(recipe)),
    );
  }
}
