import 'package:flutter/material.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/constants/sizes.dart';

class MainAlert extends StatelessWidget {
  const MainAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 500,
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size18,
          horizontal: Sizes.size10,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(Sizes.size8),
            bottomRight: Radius.circular(Sizes.size8),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "알림창",
                  style: TextStyle(
                    fontSize: Sizes.size20,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            Gaps.v18,
            const Divider(thickness: 1, height: 1, color: Colors.black),
            Gaps.v10,
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(Sizes.size14),
              ),
              child: const ListTile(
                title: Text("알림1"),
                subtitle: Text("내용"),
              ),
            ),
            Gaps.v5,
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(Sizes.size14),
              ),
              child: const ListTile(
                title: Text("알림1"),
                subtitle: Text("내용"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
