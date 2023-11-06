import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/model/meal.dart';

class FavMealsNotifer extends StateNotifier<List<Meal>> {
  //list to tell which type of data will be handled by notifier ie. provider
  FavMealsNotifer() : super([]); //initial data

  bool toggleMealFavStatus(Meal meal) {
    //we can not edit existing value in memory
    final mealIsFav = state.contains(meal);

    if (mealIsFav) {
      state = state
          .where((m) => m.id != meal.id)
          .toList(); //removing meal //we want to get false
      return false;
    } else {
      state = [
        ...state,
        meal
      ]; //adding meal//... is spread  //So that we pull out and keep all the existing meals
// and add them to a new list,
// and we also add the new meal to that list.
      return true;
    }
  }
}

final favMealsProvider = StateNotifierProvider<FavMealsNotifer, List<Meal>>(
    (ref) => FavMealsNotifer() //instantiating the notifier
    );
