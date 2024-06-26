import 'package:flutter/material.dart';
import 'package:mixmeal/models/meal.dart';
import 'package:mixmeal/screens/categories.dart';
import 'package:mixmeal/screens/filters.dart';
import 'package:mixmeal/screens/meals.dart';
import 'package:mixmeal/widgets/main_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mixmeal/providers/meals_provider.dart';
import 'package:mixmeal/providers/favourites_provider.dart';



const kInitialFilters = 
 {
    Filter.glutenFree: false,
    Filter.lactoseFree: false,
    Filter.VegitarianFree: false,
    Filter.Vegan: false
  };

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  

  Map<Filter,bool> _selectedFilters = kInitialFilters;

  void _selectpage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }



  void _setScreen(String identifier) async {
    Navigator.of(context).pop();

    if (identifier == 'filters') {
      final result = await Navigator.of(context)
          .push<Map<Filter,bool>>(MaterialPageRoute(builder: (ctx) => FiltersScreen(currentFilter: _selectedFilters,)));
    setState(() {
      _selectedFilters = result ?? kInitialFilters;
    });
     
    }
  }

  //Build Logic

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealsProvider);
    final _availabeleMeals = meals.where((meal){
      if(_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree)
      {
        return false;
      }
      if(_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree)
      {
        return false;
      }
      if(_selectedFilters[Filter.VegitarianFree]! && !meal.isVegetarian)
      {
        return false;
      }
      if(_selectedFilters[Filter.Vegan]! && !meal.isVegan)
      {
        return false;
      }
      return true;
    }).toList();

    Widget activePage = CategoriesScreen(
      availabeleMeals: _availabeleMeals,
    );

    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      final favouriteMeals = ref.watch(favouriteMealsProvider);
      activePage = MealsScreen(
          meals: favouriteMeals);
      activePageTitle = 'Favourites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(onSelectScreen: _setScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favourites')
        ],
        onTap: _selectpage,
      ),
    );
  }
}
