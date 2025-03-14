import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/data/meals_data.dart';
import 'package:meals/screen/filer_screen.dart';
import 'package:meals/widgets/drawer.dart';

import 'categories.dart';
import 'meals.dart';

const kInitialFilter = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.nonVeg: false,
  Filter.vegetarian: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _faviourtieMeals = [];
  Map<Filter, bool> _selectedFilter = kInitialFilter;

  void _showInfoMessage(String msg) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  void _selectPage(int input) {
    setState(() {
      _selectedPageIndex = input;
    });
  }

  void _toggleFaviouriteMeals(Meal meal) {
    var existingMeal = _faviourtieMeals.contains(meal);
    if (existingMeal) {
      setState(() {
        _faviourtieMeals.remove(meal);
        _showInfoMessage("Meal is removed from favourites");
      });
    } else {
      setState(() {
        _faviourtieMeals.add(meal);
        _showInfoMessage("Added as Faviourite");
      });
    }
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == "filters") {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(builder: (ctx) => FilterScreen(currentFilter: _selectedFilter,)),
      );
      setState(() {
        _selectedFilter = result ?? kInitialFilter;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = dummyMeals.where((meal) {
      if (_selectedFilter[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilter[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilter[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (_selectedFilter[Filter.nonVeg]! && !meal.isVegan) {
        return false;
      }

      return true;
    }).toList();
    Widget activePage = CategoriesScreen(
      onToggleFaviourite: _toggleFaviouriteMeals,availableMeals: availableMeals,
    );
    var activePageTitle = "Categories";
    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        meals: _faviourtieMeals,
        onToggleFavourite: _toggleFaviouriteMeals,
      );
      activePageTitle = "Your Favourite";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: DrawerScreen(
        onSelectScreen: _setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: "Categories"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favourite"),
        ],
        onTap: _selectPage,
      ),
    );
  }
}
