import 'package:flutter/material.dart';
import 'package:mixmeal/data/dummy_data.dart';
import 'package:mixmeal/models/meal.dart';
import 'package:mixmeal/screens/categories.dart';
import 'package:mixmeal/screens/filters.dart';
import 'package:mixmeal/screens/meals.dart';
import 'package:mixmeal/widgets/main_drawer.dart';

const kInitialFilters = 
 {
    Filter.glutenFree: false,
    Filter.lactoseFree: false,
    Filter.VegitarianFree: false,
    Filter.Vegan: false
  };

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;

  
  final List<Meal> _favouriteMeals = [];

  Map<Filter,bool> _selectedFilters = kInitialFilters;

  void _selectpage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _toggleMealFavouriteStatus(Meal meal) {
    final isExisting = _favouriteMeals.contains(meal);

    if (isExisting) {
      setState(() {
        _favouriteMeals.remove(meal);
      });
      _showInfoMessage('Meal removed from favourites');
    } else {
      setState(() {
        _favouriteMeals.add(meal);
      });
      _showInfoMessage('Meal marked as favourite');
    }
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

    final _availabeleMeals = dummyMeals.where((meal){
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
      onToggleFavourite: _toggleMealFavouriteStatus,
      availabeleMeals: _availabeleMeals,
    );

    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
          meals: _favouriteMeals,
          onToggleFavourite: _toggleMealFavouriteStatus);
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
