import 'package:flutter/material.dart';

import 'shared/option_vertical_container.dart';

class DropdownOption<T> extends StatelessWidget {
  final String label;
  final String help;
  final T value;
  final Map<T, Map> items;
  final Function(T value) onSelected;
  final EdgeInsets margin;
  final VoidCallback onSetToNull;
  final VoidCallback onSetToDefaultValue;
  final bool isRequired;

  DropdownOption({
    @required this.label,
    this.help,
    @required this.value,
    @required this.items,
    @required this.onSelected,
    this.margin,
    this.onSetToNull,
    this.onSetToDefaultValue,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return OptionVerticalContainer(
      margin: margin,
      label: label,
      help: help,
      error: isRequired ? 'This value is required!' : null,
      onSetToNull: onSetToNull,
      onSetToDefaultValue: onSetToDefaultValue,
      child: PopupMenuButton<T>(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(.4),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  value != null ? items[value]['label'] : 'No selected value [null]',
                ),
              ),
              Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
        initialValue: value,
        onSelected: onSelected,
        itemBuilder: (BuildContext context) => <PopupMenuEntry<T>>[
          for (var itemKey in items.keys)
            PopupMenuItem<T>(
              value: itemKey,
              child: ListTile(
                contentPadding: const EdgeInsets.all(10),
                title: Text(
                  items[itemKey]['label'],
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                        fontSize: 15,
                      ),
                ),
                subtitle: items[itemKey].containsKey('description')
                    ? Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          items[itemKey]['description'],
                          style: TextStyle(height: 1.4),
                        ),
                      )
                    : null,
              ),
            ),
        ],
      ),
    );
  }
}
