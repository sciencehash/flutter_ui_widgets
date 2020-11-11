import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'shared/option_vertical_container.dart';

class NumberOption<T> extends StatefulWidget {
  final String label;
  final String help;
  final T value;
  final Function(T value) onChanged;
  final EdgeInsets margin;
  final VoidCallback onSetToNull;
  final VoidCallback onSetToDefaultValue;
  final bool isRequired;

  NumberOption({
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
  _NumberOptionState<T> createState() => _NumberOptionState<T>();
}

class _NumberOptionState<T> extends State<NumberOption<T>> {
  TextEditingController controller;

  @override
  void initState() {
    //
    controller = TextEditingController(
      text: widget.value == null ? '' : widget.value.toString(),
    )..addListener(() {
        if (T == int)
          widget.onChanged(int.tryParse(controller.text) as T);
        else if (T == double)
          widget.onChanged(double.tryParse(controller.text) as T);
      });

    super.initState();
  }

  @override
  void didUpdateWidget(covariant NumberOption<T> oldWidget) {
    // On set to null
    if (widget.value != oldWidget.value && widget.value == null)
      controller.text = '';

    // On set to default value
    final controllerValue = T == int
        ? int.tryParse(controller.text)
        : double.tryParse(controller.text);
    if (widget.value != controllerValue)
      controller.text = widget.value.toString();

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    //
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //
    return OptionVerticalContainer(
      margin: widget.margin,
      label: widget.label,
      help: widget.help,
      error: widget.isRequired ? 'This value is required!' : null,
      onSetToNull: widget.onSetToNull,
      onSetToDefaultValue: widget.onSetToDefaultValue,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: 'null',
        ),
        keyboardType: TextInputType.numberWithOptions(
          signed: true,
          decimal: T is double,
        ),
        inputFormatters: [
          if (T == int)
            FilteringTextInputFormatter.allow(
              RegExp(r'(^\-?\d*)$'),
            ),
          if (T == double)
            FilteringTextInputFormatter.allow(
              RegExp(r'(^\-?\d*\.?\d*)$'),
            ),
        ],
      ),
    );
  }
}
