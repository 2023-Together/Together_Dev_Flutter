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
    return Stack(
      children: [
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Sizes.size12),
            color: Colors.white,
            border: Border.all(
              color: Colors.black,
              width: 2,
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 10,
                spreadRadius: 2,
                offset: Offset(5, 5),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: Sizes.size10,
          left: Sizes.size10,
          child: Text(
            text,
            style: const TextStyle(
              fontSize: Sizes.size18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
