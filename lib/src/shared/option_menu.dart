import 'package:flutter/material.dart';

enum OptionMenuOptions {
  //
  setToNull,
  //
  setToDefaultValue,
}

class OptionMenu extends StatelessWidget {
  final VoidCallback onSetToNull;
  final VoidCallback onSetToDefaultValue;

  const OptionMenu({
    Key key,
    this.onSetToNull,
    this.onSetToDefaultValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<OptionMenuOptions>(
      child: Icon(Icons.more_vert, size: 18),
      offset: Offset(0, 20),
      onSelected: (OptionMenuOptions value) {
        if (value == OptionMenuOptions.setToNull && onSetToNull != null) {
          onSetToNull();
        } else if (value == OptionMenuOptions.setToDefaultValue &&
            onSetToDefaultValue != null) {
          onSetToDefaultValue();
        }
      },
      itemBuilder: (BuildContext context) =>
          <PopupMenuEntry<OptionMenuOptions>>[
        PopupMenuItem<OptionMenuOptions>(
          value: OptionMenuOptions.setToNull,
          enabled: onSetToNull != null,
          child: Row(
            children: [
              Icon(Icons.browser_not_supported, size: 20),
              SizedBox(width: 10),
              Text('Set to null'),
            ],
          ),
        ),
        PopupMenuItem<OptionMenuOptions>(
          value: OptionMenuOptions.setToDefaultValue,
          enabled: onSetToDefaultValue != null,
          child: Row(
            children: [
              Icon(Icons.emoji_objects_outlined, size: 20),
              SizedBox(width: 10),
              Text('Set to default value'),
            ],
          ),
        ),
      ],
    );
  }
}
