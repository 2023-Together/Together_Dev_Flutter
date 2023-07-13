import 'package:flutter/material.dart';
import 'package:swag_cross_app/constants/sizes.dart';

class SWAGCustomIndicator extends StatelessWidget {
  const SWAGCustomIndicator({
    super.key,
    required this.currentIndex,
    required this.itemLength,
  });

  final int currentIndex;
  final int itemLength;

  @override
  Widget build(BuildContext context) {
    int pageLength = itemLength ~/ 10;
    int currentPage = currentIndex ~/ 10;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (currentPage != 0) const Icon(Icons.keyboard_arrow_left_rounded),
          if (itemLength > 10)
            for (int i = currentPage * 10;
                i < (currentPage == pageLength ? itemLength : 10);
                i++)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Sizes.size4),
                child: CircleAvatar(
                  backgroundColor: currentIndex == i
                      ? Colors.blue.shade400
                      : Colors.grey.shade300,
                  radius: Sizes.size7,
                ),
              ),
          if (itemLength <= 10)
            for (int i = 0; i < itemLength; i++)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Sizes.size4),
                child: CircleAvatar(
                  backgroundColor: currentIndex == i
                      ? Colors.blue.shade400
                      : Colors.grey.shade300,
                  radius: Sizes.size7,
                ),
              ),
          if (currentPage != pageLength)
            const Icon(Icons.keyboard_arrow_right_rounded),
        ],
      ),
    );
  }
}
