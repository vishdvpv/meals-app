import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/filters_provider.dart';

import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals_screen.dart';
import 'package:meals/widgets/drawer.dart';
import 'package:meals/providers/favorites_provider.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.veg: false,
  Filter.vegan: false
};

class TabsScreen extends ConsumerStatefulWidget {
  //using providers
  const TabsScreen({super.key});
  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int selectedPageIndex = 0;
  // Map<Filter, bool> selectedFilters = kInitialFilters;

  void selectPage(int index) {
    setState(() {
      selectedPageIndex = index;
    });
  }

  void setScreen(String identifier) async {
    Navigator.pop(context);
    if (identifier == 'filters') {
      // final result =
      await Navigator.of(context).push<Map<Filter, bool>>(MaterialPageRoute(
        builder: (context) => const Filters(),
      ));

      // setState(() {
      //   selectedFilters = result ??
      //       kInitialFilters; //??checks if the value is null and set a conditional fallback value
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filterMealsProvider);

    Widget activePage = CategoriesScreen(
      availableMeals: availableMeals,
    );
    var activePageTitle = 'Categories';
    if (selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favMealsProvider);
      activePage = Meals(
        meals: favoriteMeals,
      ); //dont give title to set title to null for showing only 1 appbar
      activePageTitle = ' Your Favorites';
    }

    return Scaffold(
      drawer: MainDrawer(onSelectScreen: setScreen),
      appBar: AppBar(title: Text(activePageTitle)),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites')
        ],
        onTap: selectPage,
      ),
    );
  }
}
