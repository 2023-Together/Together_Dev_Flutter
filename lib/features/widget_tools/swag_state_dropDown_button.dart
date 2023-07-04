import 'package:flutter/material.dart';

class SWAGStateDropDownButton extends StatelessWidget {
  const SWAGStateDropDownButton({
    super.key,
    required this.initOption,
    required this.onChangeOption,
    required this.title,
    required this.options,
  });

  final String title;
  final String initOption;
  final List<String> options;
  final Function(String?) onChangeOption;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      // key: UniqueKey(),
      hint: Text(initOption.isEmpty ? title : initOption),
      disabledHint: Text(title),
      onChanged: (value) => onChangeOption(value),
      items: options.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
