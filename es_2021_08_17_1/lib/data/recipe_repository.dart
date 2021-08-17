import 'package:reciperlich/constants/app_image_paths.dart';
import 'package:reciperlich/constants/colors.dart';
import 'package:reciperlich/models/recipe_model.dart';

class RecipeRepository {
  static List<RecipeModel> getRecipes() => const [
        RecipeModel(
          title: 'Ethan’s Eggs',
          details: [
            '10 Servings',
            '1 hour Preptime',
            '2 seconds CookTime',
            '\$3.00 Cost'
          ],
          whereToBuy: 'Texas Roadhouse',
          ingredients: ['Pancakes', 'Sugar', 'Skittles'],
          instructions:
              '''First you put pancakes and then sugar and that's it. You can cook it, but you can go to my house and I will give you eggs because my mom makes eggs all the time. You can eat them with a spoon. Don't put anything on them because that's how you make eggs, with nothing.''',
          iconPath: AppImagePaths.eggsIcon,
          mainImagePath: AppImagePaths.eggsImage,
          itemColor: AppColors.lightBlue,
        ),
        RecipeModel(
          title: 'Ariana’s Macaroni',
          details: [
            '3 Servings',
            '5 minutes Preptime',
            '5 minutes CookTime',
            '\$2.00 Cost'
          ],
          whereToBuy: '''Walmart and Target''',
          ingredients: [
            'Melted cheese',
            'Macaroni',
            'Apples',
            'Strawberries',
            'Toy',
            'Backpack',
            'doll'
          ],
          instructions:
              '''First you put the macaroni in the stove and now you put it in the end. Put it to the oven and put cheese and more melted cheese. The oven has to be hot like fire…like a candle…like for birthdays. Now you need to tell everyone that its time to leave. And I have to leave because I am going to a party with a swimming pool. My sister says, “Why do you go to the swimming pool?” and I say, “Because I like it.” Now I go home and I am waiting for it not to be hot and then my sister says, “Why do you do that?” it’s because you blow on the macaroni so it wont be hot. You need to wait. Now its done!''',
          iconPath: AppImagePaths.macaroniIcon,
          mainImagePath: AppImagePaths.macaroniImage,
          itemColor: AppColors.orange,
        ),
        RecipeModel(
          title: 'Joe’s Tacos',
          details: [
            'don\'t know Servings',
            '45 minutes Preptime',
            '55 minutes CookTime',
            'don\'t know cost'
          ],
          whereToBuy: '''I don't know where''',
          ingredients: [
            'meat'
                'lettuce',
            'Taco shells',
            'Cheese',
            'Lettuce',
            'Potato/tomato'
          ],
          instructions:
              '''First I don’t actually know, I really don’t remember anything. Can I change this to cheesy roll ups? Because they are super easy. There is only 3 stuff you need, white cheese, yellow cheese and tortilla. I don’t even want to make tacos anymore. I don’t even know how. It is too hard to think about tacos. But I can make cheesy roll ups. They are super easy. They come from Taco Bell. I need yellow cheese and I don’t know where to buy the white cheese. I don’t know how to make tacos. Cheesy roll ups are better because I know how to make them. Let me think…one time I made candy and it turned brown. I don’t want tacos anymore. I like them, but I love cheesy roll ups more. I don’t like beans because they make me throw up. My mom made me eat a burrito one time with beans and I threw up. Wait…I know how to make watermelon it is easy…just buy the watermelon and eat it.''',
          iconPath: AppImagePaths.tacosIcon,
          mainImagePath: AppImagePaths.tacosImage,
          itemColor: AppColors.green,
        ),
        RecipeModel(
          title: 'Sebastian’s Pancakes',
          details: [
            '3 Servings',
            '10 minutes Preptime',
            '3 times CookTime',
            '\$70 Cost'
          ],
          whereToBuy: '''Walmart''',
          ingredients: [
            'Salt and that\'s it',
          ],
          instructions:
              '''You get a thingy from the house and you put it in the hot thingy. Turn on the hot thingy and it burns so you have to be careful. You make like, something and put it in it and it cooks. Then you get a plate and finish it. Don\'t leave the plate on the table, you have to throw it away in the sink or flies will get on it.''',
          iconPath: AppImagePaths.pancakesIcon,
          mainImagePath: AppImagePaths.pancakesImage,
          itemColor: AppColors.lightBlue,
        ),
        RecipeModel(
          title: 'Michael’s Icecream',
          details: [
            '1 Servings',
            '1 minute Preptime',
            '1 minute CookTime',
            '\$3 Cost'
          ],
          whereToBuy: '''Icecream shop''',
          ingredients: ['Milk', 'Cow', 'Ice cream', 'toys'],
          instructions:
              '''You go to the ice cream shop... and.. you tell them you want ice cream and you get it and get out''',
          iconPath: AppImagePaths.iceCreamIcon,
          mainImagePath: AppImagePaths.iceCreamImage,
          itemColor: AppColors.orange,
        ),
        RecipeModel(
          title: 'Madonna’s Croissant',
          details: [
            '14 Servings',
            '100 minute Preptime',
            '1000 minute CookTime',
            '\$44 Cost'
          ],
          whereToBuy: '''Croissant place''',
          ingredients: ['bread', 'honey', 'crackers', 'football'],
          instructions:
              '''I have croissant in my drawer.. you go to my house and get the croissant''',
          iconPath: AppImagePaths.croissantIcon,
          mainImagePath: AppImagePaths.croissantImage,
          itemColor: AppColors.green,
        ),
      ];
}
