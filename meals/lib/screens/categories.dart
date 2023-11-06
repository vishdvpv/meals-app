import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/model/category.dart';
import 'package:meals/model/meal.dart';

import 'package:meals/screens/meals_screen.dart';
import 'package:meals/widgets/category_grid_item.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.availableMeals});

  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  //with =>for merging
  late AnimationController
      _animationController; //late tells dart that this in the end is a variable

// which will have a value as soon as it's being used

// the first time, but not yet when the class is created.

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
        lowerBound: 0,
        upperBound: 1);

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void selectCategory(BuildContext context, Category category) {
    final filteredMeals = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList(); //for filtering

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Meals(
            title: category.title,
            meals: filteredMeals,
          ),
        )); //like stack user sees the top most screen  or we can use Navigator.push(context).push(route)
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        child: GridView(
            padding: const EdgeInsets.all(18),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            children: [
              //availableCategories.map((category)=>CategoryGridItem(category: category).toList())
              for (final category in availableCategories)
                CategoryGridItem(
                  category: category,
                  onSelectCategory: () {
                    selectCategory(context, category);
                  },
                )
            ]),
        builder: (context, child) => SlideTransition(
            position: Tween(begin: const Offset(0, 0.4), end: const Offset(0, 0)).animate(CurvedAnimation(parent: _animationController, curve: Curves.decelerate))
            ,child: child),
            
        // Padding(
        //       padding: EdgeInsets.only(top: 100-_animationController.value * 100)//100 to 0
        //       ,child: child,
        );
  }
}
