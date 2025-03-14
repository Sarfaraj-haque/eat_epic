import 'package:flutter/material.dart';
import 'package:meals/screen/meals_item_screen.dart';
import 'package:meals/widgets/meal_item.dart';

import '../data/meals_data.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key, this.title, required this.meals,required this.onToggleFavourite});

  final String? title;
  final List<Meal> meals;
  final void Function(Meal meal) onToggleFavourite;

  void selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (ctx) => MealsDetailsScreen(meal: meal,onToggleFavourite: onToggleFavourite,)));
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Uh oh....Nothing is here ",
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Theme.of(context).colorScheme.onPrimary),
          ),
          SizedBox(height: 16),
          Text(
            " Try Some Different Categories",
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Theme.of(context).colorScheme.onSecondary),
          )
        ],
      ),
    );

    if (meals.isNotEmpty) {
      content = ListView.builder(
        itemCount: meals.length,
        itemBuilder: (ctx, index) => MealItems(
          meal: meals[index],
          onSelectMeal: (meal) {
            selectMeal(context, meal);
          },
        ),
      );
    }
    if (title == null) {
      return content;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
