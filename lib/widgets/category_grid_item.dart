import 'package:flutter/material.dart';
import 'package:meals/models/category.dart';

class CategoryItems extends StatelessWidget {
  const CategoryItems({
    super.key,
    required this.category,
    required this.onSelectCategory,
  });

  final Category1 category;
  final void Function() onSelectCategory;

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: onSelectCategory,
      splashColor: Theme.of(context).primaryColor,
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            category.color.withValues(alpha: 0.55),
            category.color.withValues(alpha: 0.9)
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
      ),
    );
  }
}
