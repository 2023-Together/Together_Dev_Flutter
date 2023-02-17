import 'package:flutter/material.dart';
import 'package:swag_cross_app/constants/sizes.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.size12),
        color: Colors.teal,
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            fontSize: Sizes.size20,
          ),
        ),
      ),
    );
  }
}
