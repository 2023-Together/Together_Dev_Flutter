import 'package:flutter/material.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/main/widgets/main_button.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  // 봉사 찾기 누르면 작동
  void _onVolSearchTap() {}

  // 공지사항 누르면 작동
  void _onCommunityTap() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.size20,
            horizontal: Sizes.size32,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 350,
                  height: 110,
                  color: Colors.blue,
                  child: const Center(
                    child: Text(
                      "배너",
                      style: TextStyle(
                        fontSize: Sizes.size20,
                      ),
                    ),
                  ),
                ),
                Gaps.v16,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: _onVolSearchTap,
                      child: const MainButton(text: "봉사 찾기"),
                    ),
                    GestureDetector(
                      onTap: _onCommunityTap,
                      child: const MainButton(text: "공지사항"),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
