import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/data/meals_data.dart';

class FavouriteMealNotifier extends StateNotifier<List<Meal>> {
  FavouriteMealNotifier() : super([]);

  bool toggleFavouriteToggleStatus(Meal meal) {
    final favouriteMeals = state.contains(meal);
    if (favouriteMeals) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }

}

final favouritesMealProvider = StateNotifierProvider<FavouriteMealNotifier, List<Meal>>(
    (ref) => FavouriteMealNotifier());
