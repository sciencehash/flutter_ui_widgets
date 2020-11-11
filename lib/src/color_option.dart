import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'shared/option_horizontal_container.dart';

class ColorOption extends StatefulWidget {
  final String label;
  final String help;
  final Color initialColor;
  final Function(Color) onColorSelected;
  final EdgeInsets margin;
  final VoidCallback onSetToNull;
  final VoidCallback onSetToDefaultValue;
  final bool isRequired;

  ColorOption({
    Key key,
    @required this.label,
    this.help,
    this.initialColor,
    @required this.onColorSelected,
    this.margin,
    this.onSetToNull,
    this.onSetToDefaultValue,
    this.isRequired = false,
  }) : super(key: key);

  @override
  _ColorOptionState createState() => _ColorOptionState();
}

class _ColorOptionState extends State<ColorOption> {
  Color pickerColor;

  @override
  void initState() {
    //
    pickerColor = widget.initialColor;

    super.initState();
  }

  @override
  void didUpdateWidget(covariant ColorOption oldWidget) {
    //
    if (widget.initialColor != oldWidget.initialColor) {
      pickerColor = widget.initialColor;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return OptionHorizontalContainer(
      margin: widget.margin,
      label: widget.label,
      help: widget.help,
      error: widget.isRequired ? 'This value is required!' : null,
      onSetToNull: widget.onSetToNull,
      onSetToDefaultValue: widget.onSetToDefaultValue,
      child: FlatButton(
        minWidth: 70,
        height: 70,
        color: pickerColor ?? Colors.white.withOpacity(.05),
        child: pickerColor != null
            ? SizedBox()
            : Text(
                'null',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.white38,
                  letterSpacing: .5,
                ),
              ),
        onPressed: () {
          // raise the [showDialog] widget
          showDialog(
            context: context,
            child: AlertDialog(
              title: const Text('Pick a color!'),
              content: SingleChildScrollView(
                child: ColorPicker(
                  pickerColor: pickerColor ?? Colors.black,
                  onColorChanged: (Color color) {
                    setState(() => pickerColor = color);
                  },
                  showLabel: true,
                  pickerAreaHeightPercent: 0.8,
                ),
                // Use Material color picker:
                //
                // child: MaterialPicker(
                //   pickerColor: pickerColor,
                //   onColorChanged: changeColor,
                //   showLabel: true, // only on portrait mode
                // ),
                //
                // Use Block color picker:
                //
                // child: BlockPicker(
                //   pickerColor: currentColor,
                //   onColorChanged: changeColor,
                // ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: const Text('Got it'),
                  onPressed: () {
                    //
                    widget.onColorSelected(pickerColor);
                    //
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
