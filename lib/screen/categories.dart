import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/category.dart';
import 'package:meals/screen/meals.dart';
import 'package:meals/widgets/category_grid_item.dart';

import '../data/meals_data.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen(
      {super.key,
      required this.onToggleFaviourite,
      required this.availableMeals});

  final void Function(Meal mea) onToggleFaviourite;
  final List<Meal> availableMeals;

  void _selectedCategory(BuildContext context, Category1 category) {
    final filteredCategory = dummyMeals
        .where((meals) => meals.categories.contains(category.id))
        .toList();

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MealsScreen(
            title: category.title,
            meals: filteredCategory,
            onToggleFavourite: onToggleFaviourite,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          childAspectRatio: 3 / 2),
      children: [
        for (final cat in availableCategories)
          CategoryItems(
            category: cat,
            onSelectCategory: () {
              _selectedCategory(context, cat);
            },
          )
      ],
    );
  }
}
