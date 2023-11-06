import 'package:flutter/material.dart';

import 'package:meals/model/meal.dart';
import 'package:meals/widgets/meal_item.dart';
import 'meal_details_screen.dart';

class Meals extends StatelessWidget {
  const Meals({super.key, this.title, required this.meals});
  final String? title;
  final List<Meal> meals;
  

  void selectMeals(BuildContext context, Meal meal) {
    // final filteredMeals = dummyMeals
    //     .where((meal) => meal.categories.contains(category.id))
    //     .toList();//for filtering

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MealDetails(meal: meal),
        )); //like stack user sees the top most screen  or we can use Navigator.push(context).push(route)
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: meals.length,
      itemBuilder: (context, index) =>
          MealItem(meal: meals[index], onSelectMeals: selectMeals),
    );
    if (meals.isEmpty) {
      content = Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Uh Oh ..nothing here!!',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground)),
          const SizedBox(
            height: 16,
          ),
          Text(
            'Try selecting a different category',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          )
        ],
      ));
    }
    if (title == null) {
      return content;
    }
    return Scaffold(appBar: AppBar(title: Text(title!)), body: content);
  }
}
