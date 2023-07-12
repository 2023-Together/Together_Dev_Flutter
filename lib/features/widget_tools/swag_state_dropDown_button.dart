import 'package:flutter/material.dart';

class SWAGStateDropDownButton extends StatelessWidget {
  const SWAGStateDropDownButton({
    super.key,
    required this.initOption,
    required this.onChangeOption,
    required this.title,
    required this.options,
    this.isExpanded,
    this.width,
    this.height,
    this.fontSize,
    this.padding,
  });

  final String title;
  final String initOption;
  final List<String> options;
  final Function(String) onChangeOption;
  final bool? isExpanded;
  final double? width;
  final double? height;
  final double? fontSize;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          padding ?? const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
      width: width,
      height: height,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey,
          width: 0.5,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: initOption.isEmpty ? null : initOption,
          isDense: true,
          hint: Text(
            title,
            style: TextStyle(
              color: Colors.black45,
              fontSize: fontSize,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          onChanged: (value) => onChangeOption(value!),
          items: options.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value.isEmpty ? "" : value,
              child: value.isEmpty ? const Text("없음") : Text(value),
            );
          }).toList(),
          isExpanded: isExpanded ?? false,
          style: TextStyle(
            color: Colors.black,
            fontSize: fontSize,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
