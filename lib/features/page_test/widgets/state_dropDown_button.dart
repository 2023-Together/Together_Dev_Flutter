import 'package:flutter/material.dart';

class StateDropDownButton extends StatelessWidget {
  const StateDropDownButton({
    super.key,
    required this.initOption,
    required this.onChangeOption,
    required this.title,
  });

  final String title;
  final String initOption;
  final Function(String?) onChangeOption;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      // key: UniqueKey(),
      hint: Text(initOption.isEmpty ? title : initOption),
      disabledHint: Text(title),
      onChanged: (value) => onChangeOption(value),
      items: <String>[
        '옵션1',
        '옵션2',
        '옵션3',
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
