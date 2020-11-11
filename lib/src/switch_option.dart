import 'package:flutter/material.dart';

import 'shared/option_horizontal_container.dart';

class SwitchOption extends StatelessWidget {
  final String label;
  final String help;
  final bool value;
  final Function(bool value) onChanged;
  final EdgeInsets margin;
  final VoidCallback onSetToNull;
  final VoidCallback onSetToDefaultValue;
  final bool isRequired;

  SwitchOption({
    @required this.label,
    this.help,
    @required this.value,
    @required this.onChanged,
    this.margin,
    this.onSetToNull,
    this.onSetToDefaultValue,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return OptionHorizontalContainer(
      margin: margin,
      label: label,
      help: help,
      error: isRequired ? 'This value is required!' : null,
      onSetToNull: onSetToNull,
      onSetToDefaultValue: onSetToDefaultValue,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Switch(
            value: value != null ? value : false,
            onChanged: onChanged,
          ),
          if (value == null)
            Positioned(
              top: 39,
              child: Text(
                'null',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.white38,
                  letterSpacing: .5,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
