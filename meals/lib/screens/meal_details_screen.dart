import 'package:flutter/material.dart';
import 'package:meals/model/meal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/favorites_provider.dart';

class MealDetails extends ConsumerWidget {
  const MealDetails({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //'WidgetRef ref' we have to add this in statelesswidget to use riverpod and access its features
    final favMeals = ref.watch(favMealsProvider);
    final isFav = favMeals.contains(meal);

    return Scaffold(
        appBar: AppBar(
          title: Text(meal.title),
          actions: [
            IconButton(
                onPressed: () {
                  final wasAdded = ref
                      .read(favMealsProvider.notifier)
                      .toggleMealFavStatus(
                          meal); //to call the method //.read() will on read the data once unlike the .watch() which sets up a ongoing listenner ,,also in a function we sould use read instead of watch
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(wasAdded
                          ? 'Meal Added to favorites'
                          : 'Meal Removed')));
                },
                //implicit animiation(inbuilt) =>easier than explicit (we create)
                icon: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) {
                    return RotationTransition(
                      turns: Tween(begin: 0.6,end: 1.0).animate(animation),
                      child: child,
                    );
                  },
                  child: Icon(isFav ? Icons.star : Icons.star_border,key: ValueKey(isFav),),
                ))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Hero(tag: meal.id,
                child: Image.network(
                  meal.imageUrl,
                    width: double.infinity, height: 300, fit: BoxFit.cover),
              ),
              const SizedBox(
                height: 14,
              ),
              Text(
                'Ingredients',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 14,
              ),
              for (final ingredient in meal.ingredients)
                Text(
                  ingredient,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
              const SizedBox(
                height: 24,
              ),
              Text(
                'Steps',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 14,
              ),
              for (final steps in meal.steps)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Text(
                    steps,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                )
            ],
          ),
        ));
  }
}
