import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/features/widget_tools/swag_expansionTile_card.dart';
import 'package:swag_cross_app/providers/UserProvider.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey.shade50,
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 6,
        ),
        itemBuilder: (context, index) {
          final item = faqList[index];
          return SWAGExpansionTileCard(
            id: item["id"],
            title: item["title"],
            content: item["content"],
            date: item["date"],
            isLogined: context.watch<UserProvider>().isLogined,
            isFAQ: true,
          );
        },
        separatorBuilder: (context, index) => Gaps.v6,
        itemCount: faqList.length,
      ),
    );
  }
}

List<Map<String, dynamic>> faqList = [
  {
    "id": 1,
    "title": "제목1",
    "content": "내용1",
    "date": "2023-07-10 16:43",
  },
  {
    "id": 2,
    "title": "제목2",
    "content": "내용2",
    "date": "2023-07-10 16:43",
  },
  {
    "id": 3,
    "title": "제목3",
    "content": "내용3",
    "date": "2023-07-10 16:43",
  },
  {
    "id": 4,
    "title": "제목4",
    "content": "내용4",
    "date": "2023-07-10 16:43",
  },
  {
    "id": 5,
    "title": "제목5",
    "content": "내용5",
    "date": "2023-07-10 16:43",
  },
  {
    "id": 6,
    "title": "제목6",
    "content": "내용6",
    "date": "2023-07-10 16:43",
  },
  {
    "id": 7,
    "title": "제목7",
    "content": "내용7",
    "date": "2023-07-10 16:43",
  },
  {
    "id": 8,
    "title": "제목8",
    "content": "내용8",
    "date": "2023-07-10 16:43",
  },
];
