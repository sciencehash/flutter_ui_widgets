import 'package:flutter/material.dart';

import 'option_menu.dart';

class OptionVerticalContainer extends StatelessWidget {
  final String label;
  final String help;
  final String success;
  final String error;
  final Widget child;
  final EdgeInsets margin;
  final VoidCallback onSetToNull;
  final VoidCallback onSetToDefaultValue;

  OptionVerticalContainer({
    @required this.label,
    this.help,
    this.success,
    this.error,
    @required this.child,
    this.margin,
    this.onSetToNull,
    this.onSetToDefaultValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.all(0),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (onSetToNull != null || onSetToDefaultValue != null)
                OptionMenu(
                  onSetToNull: onSetToNull,
                  onSetToDefaultValue: onSetToDefaultValue,
                ),
              if (onSetToNull != null || onSetToDefaultValue != null)
                SizedBox(width: 7),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    label,
                    style: Theme.of(context).textTheme.headline6.copyWith(
                          fontSize: 18,
                        ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          child,
          if (help != null)
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                help,
                style: TextStyle(height: 1.4),
              ),
            ),
          if (success != null)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                success,
                style: TextStyle(height: 1.4, color: Colors.green),
              ),
            ),
          if (error != null)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                error,
                style: TextStyle(height: 1.4, color: Colors.pink),
              ),
            ),
        ],
      ),
    );
  }
}
