import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/meals_provider.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  veg,
  vegan,
}

class FiltersNotiflier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotiflier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.veg: false,
          Filter.vegan: false
        });
  void setFilters(Map<Filter, bool> chosenFilters) {
    state = chosenFilters;
  }

  void setFilter(Filter filter, bool isActive) {
    //And with that, we are creating a new map
// with the old key-value pairs
// and one new key-value pair
// that overrides the respective old key-value pair
// for the same filter.
// And that's essentially all the logic we have
// to add here to update our filters
// or to be precise, to update one of our filters in this map.
    state = {
      ...state, //copy exiting key values to new map
      filter: isActive,
    };
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotiflier, Map<Filter, bool>>(
        (ref) => FiltersNotiflier());

final filterMealsProvider = Provider(
  (ref) {
    final meals = ref.watch(mealsProvider);
    final activeFilters = ref.watch(filtersProvider);
    return meals.where(
      (meal) {
        if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
          //!in front to check if not true and ! in end is to tell if its not null
          return false;
        }
        if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
          //!in front to check if not true and ! in end is to tell if its not null
          return false;
        }
        if (activeFilters[Filter.veg]! && !meal.isVegetarian) {
          //!in front to check if not true and ! in end is to tell if its not null
          return false;
        }
        if (activeFilters[Filter.vegan]! && !meal.isVegan) {
          //!in front to check if not true and ! in end is to tell if its not null
          return false;
        }
        return true; //for the meals we want to keep after filtering meals
      },
    ).toList();
  },
);
