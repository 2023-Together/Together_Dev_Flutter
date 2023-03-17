import 'package:flutter/material.dart';

class LocationListBottomSheet extends StatelessWidget {
  static final List<String> locations = [
    "전국",
    "경기",
    "인천",
    "부산",
    "대구",
    "광주",
    "대전",
    "울산",
    "세종",
    "강원",
    "경남",
    "경북",
    "전남",
    "전북",
    "충남",
    "충북",
    "제주",
    "기타"
  ];
  const LocationListBottomSheet({super.key});

  onTap(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("활동 지역 선택"),
            centerTitle: false,
            automaticallyImplyLeading: false,
          ),
          body: Container(
            margin: const EdgeInsets.only(top: 10),
            child: ListView(
              children: [
                for (var location in locations)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    height: 50,
                    child: Text(
                      location,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Row(
        children: const [
          Text("전국", style: TextStyle(fontSize: 20)),
          Icon(Icons.arrow_drop_down),
        ],
      ),
      onTap: () {
        onTap(context);
      },
    );
  }
}
