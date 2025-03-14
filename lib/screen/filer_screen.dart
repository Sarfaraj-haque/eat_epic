import 'package:flutter/material.dart';

enum Filter { glutenFree, lactoseFree, vegetarian, nonVeg }

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key, required this.currentFilter});

  final Map<Filter, bool> currentFilter;

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  var isGlutenFree = false;
  var isLactoseFree = false;
  var isVegetarian = false;
  var isNonVeg = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    isGlutenFree = widget.currentFilter[Filter.glutenFree]!;
    isLactoseFree = widget.currentFilter[Filter.lactoseFree]!;
    isVegetarian = widget.currentFilter[Filter.vegetarian]!;
    isNonVeg = widget.currentFilter[Filter.nonVeg]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yours Filters"),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop({
            Filter.glutenFree: isGlutenFree,
            Filter.lactoseFree: isLactoseFree,
            Filter.nonVeg: isNonVeg,
            Filter.vegetarian: isVegetarian
          });
          return false;
        },
        child: Column(
          children: [
            SwitchListTile(
              value: isGlutenFree,
              onChanged: (isChecked) {
                setState(() {
                  isGlutenFree = isChecked;
                });
              },
              title: Text(
                "Gluten-free",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
              subtitle: Text(
                "Only include gluten-free meals",
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
            ),
            SwitchListTile(
              value: isLactoseFree,
              onChanged: (isChecked) {
                setState(() {
                  isLactoseFree = isChecked;
                });
              },
              title: Text(
                "Lactose-free",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
              subtitle: Text(
                "Only include lactose-free meals",
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
            ),
            SwitchListTile(
              value: isNonVeg,
              onChanged: (isChecked) {
                setState(() {
                  isNonVeg = isChecked;
                });
              },
              title: Text(
                "Non-veg",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
              subtitle: Text(
                "Only include vegan meals",
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
            ),
            SwitchListTile(
              value: isVegetarian,
              onChanged: (isChecked) {
                setState(() {
                  isVegetarian = isChecked;
                });
              },
              title: Text(
                "Veg",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
              subtitle: Text(
                "Only include veg meals",
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
