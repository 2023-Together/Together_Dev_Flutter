import 'package:flutter/material.dart';

class StateDropDownButton extends StatelessWidget {
  const StateDropDownButton({
    super.key,
    required this.initOption,
    required this.onChangeOption,
  });

  final String initOption;
  final Function(String?) onChangeOption;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          DropdownButton<String>(
            key: UniqueKey(),
            value: initOption,
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
          )
        ],
      ),
    );
  }
}
