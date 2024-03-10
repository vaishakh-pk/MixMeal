import 'package:flutter/material.dart';

class FilterItem extends StatefulWidget {
  FilterItem({super.key,required this.filter,required this.filterName ,required this.filterSet, required this.titleText, required this.subtext});

  bool filterSet;
  String filterName;
  String titleText;
  String subtext;

  final void Function(String name,bool state) filter; 

  @override
  State<FilterItem> createState() => _FilterItemState();
}

class _FilterItemState extends State<FilterItem> {
  //  var filterState = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: SwitchListTile(
              value: widget.filterSet,
              onChanged: (isChecked)
              {
                widget.filter(widget.filterName,isChecked);
              },
              title: Text(
                widget.titleText,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text(
                widget.subtext,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Theme.of(context).colorScheme.onBackground),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
    );
  }
}