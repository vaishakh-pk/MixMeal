import 'package:flutter/material.dart';
import 'package:mixmeal/widgets/filter_item.dart';


enum Filter
{
  glutenFree,
  lactoseFree,
  VegitarianFree,
  Vegan
}

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key, required this.currentFilter});

  final Map<Filter,bool> currentFilter;

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {

  var _glutanFreeFilterSet = false;
  var _lactoseFreeFilterSet = false;
  var _vegiterianFreeFilterSet = false;
  var _veganFilterSet = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _glutanFreeFilterSet = widget.currentFilter[Filter.glutenFree]!;
    _vegiterianFreeFilterSet = widget.currentFilter[Filter.lactoseFree]!;
    _lactoseFreeFilterSet = widget.currentFilter[Filter.VegitarianFree]!;
    _veganFilterSet = widget.currentFilter[Filter.Vegan]!;

  }

  void filterUpdate( String name, bool state)
  {
    if(name == 'gluten')
    {
      setState(() {
        _glutanFreeFilterSet = state;
      });
    }
    else if(name == 'lactose')
    {
      setState(() {
        _lactoseFreeFilterSet = state;
      });
    }
    else if(name == 'vegitarian')
    {
      setState(() {
        _vegiterianFreeFilterSet = state;
      });
    }
    else if(name == 'vegan')
    {
      setState(() {
        _veganFilterSet = state;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),

      //Using pushReplacement to replace the screen rather than adding to stack

      // drawer: MainDrawer(onSelectScreen: (identifier){
      //   Navigator.of(context).pop();
      //   if(identifier == 'meals')
      //   {
      //     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>TabsScreen()));
      //   }
      // },),
      body: PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) {
          if(didPop) return;
          Navigator.of(context).pop(
            {
              Filter.glutenFree: _glutanFreeFilterSet,
              Filter.lactoseFree: _lactoseFreeFilterSet,
              Filter.VegitarianFree: _vegiterianFreeFilterSet,
              Filter.Vegan: _veganFilterSet
            }
          );
        },
        child: Column(
          children: [
            FilterItem(titleText: 'Glutan-free', subtext: 'Only include gluten-free meals', filterSet: _glutanFreeFilterSet,filter: filterUpdate, filterName: 'gluten',),
            FilterItem(titleText: 'Lactose-free', subtext: 'Only include lactose-free meals', filterSet: _lactoseFreeFilterSet,filter: filterUpdate, filterName: 'lactose',),
            FilterItem(titleText: 'Vegitarian-free', subtext: 'Only include vegitarian-free meals', filterSet: _vegiterianFreeFilterSet,filter: filterUpdate, filterName: 'vegitarian',),
            FilterItem(titleText: 'Vegan', subtext: 'Only include vegan meals', filterSet: _veganFilterSet,filter: filterUpdate, filterName: 'vegan',),
          ],
        ),
      ),
    );
  }
}
