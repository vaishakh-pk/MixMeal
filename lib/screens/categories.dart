import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mixmeal/data/dummy_data.dart';
import 'package:mixmeal/models/meal.dart';
import 'package:mixmeal/screens/meals.dart';
import 'package:mixmeal/widgets/category_grid_item.dart';
import 'package:mixmeal/models/category.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key, required this.onToggleFavourite});

  final void Function(Meal meal) onToggleFavourite;

  void _selectCategory(BuildContext context, MealCategory selectedCategory) {

    final filteredMeals = dummyMeals.where((meal) => meal.categories.contains(selectedCategory.id)).toList();

    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => MealsScreen(title: selectedCategory.title, meals: filteredMeals,onToggleFavourite: onToggleFavourite,)));
  }

  @override
  Widget build(BuildContext context) {
    var kcolour = Colors.white;
    return GridView(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20),
          children: [
            for (final category in availableCategories)
              CategoryGridItem(
                category: category,
                onSelectCategory: () {
                  _selectCategory(context,category);
                },
              )
          ],
    );
  }
}
