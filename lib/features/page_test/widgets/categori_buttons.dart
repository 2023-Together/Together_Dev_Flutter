import 'package:flutter/material.dart';
import 'package:swag_cross_app/constants/sizes.dart';

class CategoriButtons extends StatefulWidget {
  const CategoriButtons({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<CategoriButtons> createState() => _CategoriButtonsState();
}

class _CategoriButtonsState extends State<CategoriButtons> {
  bool isSelected = false;

  void tapIsSelected() {
    setState(() {
      isSelected = !isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tapIsSelected,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size8,
          horizontal: Sizes.size6,
        ),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.shade400 : Colors.white,
          border: Border.all(
            width: 1,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(
              Sizes.size20,
            ),
          ),
        ),
        child: Text(
          widget.title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
