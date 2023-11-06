import 'package:flutter/material.dart';
// import 'package:meals/screens/tabs.dart';
// import 'package:meals/widgets/drawer.dart';
import 'package:meals/providers/filters_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Filters extends ConsumerWidget {
  const Filters({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref
        .watch(filtersProvider); //And here we wanna use watch instead of read
// because watch sets up a listener
// that re-executes the build method
// whenever the state in the provider changes.
// So whenever a filter changes, for example.
// And I want to re-execute the build method
// in that case to update my switch tiles correctly.

    return Scaffold(
      appBar: AppBar(title: const Text('Filters')),

//       body: WillPopScope(
//         //widget
//         onWillPop: () async {
//           ref.read(filtersProvider.notifier).setFilters({
//             Filter.glutenFree: glutenFreeFilterSet,
//             Filter.lactoseFree: lactoseFreeFilterSet,
//             Filter.veg: vegFreeFilterSet,
//             Filter.vegan: veganFreeFilterSet,
//           });
//           //used to return the data to the tabs screen

//           // Navigator.of(context).pop();

//           return true; //we have to return true or false
// // to in the end confirm whether we want
// // to navigate back or not.
// // And since we are navigating back manually here,
// // we should indeed return false
// // so that we're not popping twice.
//         },
      body: Column(children: [
        SwitchListTile(
          value: activeFilters[Filter.glutenFree]!,
          onChanged: (isChecked) {
            ref
                .read(filtersProvider.notifier)
                .setFilter(Filter.glutenFree, isChecked);
          },
          title: Text('Gluten-free',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  )),
          subtitle: Text('Only Include Gluten free meals.',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  )),
          activeColor: Theme.of(context).colorScheme.tertiary,
          contentPadding: const EdgeInsets.only(left: 34, right: 22),
        ),
        SwitchListTile(
          value: activeFilters[Filter.lactoseFree]!,
          onChanged: (isChecked) {
            ref
                .read(filtersProvider.notifier)
                .setFilter(Filter.lactoseFree, isChecked);
          },
          title: Text('Lactose-free',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  )),
          subtitle: Text('Only Include Lactose free meals.',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  )),
          activeColor: Theme.of(context).colorScheme.tertiary,
          contentPadding: const EdgeInsets.only(left: 34, right: 22),
        ),
        SwitchListTile(
          value: activeFilters[Filter.veg]!,
          onChanged: (isChecked) {
            ref.read(filtersProvider.notifier).setFilter(Filter.veg, isChecked);
          },
          title: Text('Vegeterian',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  )),
          subtitle: Text('Only Include Veg meals.',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  )),
          activeColor: Theme.of(context).colorScheme.tertiary,
          contentPadding: const EdgeInsets.only(left: 34, right: 22),
        ),
        SwitchListTile(
          value: activeFilters[Filter.vegan]!,
          onChanged: (isChecked) {
            ref
                .read(filtersProvider.notifier)
                .setFilter(Filter.vegan, isChecked);
          },
          title: Text('Vegan',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  )),
          subtitle: Text('Only Include Vegan meals.',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  )),
          activeColor: Theme.of(context).colorScheme.tertiary,
          contentPadding: const EdgeInsets.only(left: 34, right: 22),
        )
      ]),
    );
  }
}
