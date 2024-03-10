import 'package:flutter/material.dart';
import 'package:mixmeal/models/meal.dart';
import 'package:mixmeal/screens/meal_details.dart';
import 'package:mixmeal/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key, this.title, required this.meals, required this.onToggleFavourite});

  final String? title;
  final List<Meal> meals;
  final void Function(Meal meal) onToggleFavourite;

  void _onSelectMeal(BuildContext context,Meal meal)
  {
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>MealDetailsScreen(meal: meal,onToggleFavourite: onToggleFavourite,)));
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Uh oh ..... Nothing here',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            'Try selecting a different category !',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          )
        ],
      ),
    );

    if (meals.isNotEmpty) {
      content = ListView.builder(
          itemCount: meals.length,
          itemBuilder: (ctx, index) {
            return MealItem(meal: meals[index],onSelectMeal: (){_onSelectMeal(context,meals[index]);},);
          });
    }

    if(title == null)
    {
      return content;
    }
    else{
    return Scaffold(
        appBar: AppBar(
          title: Text(title!),
        ),
        body: content);
  }
}
}
