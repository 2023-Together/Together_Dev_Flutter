import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/features/customer_service/faq/faq_edit_screen.dart';
import 'package:swag_cross_app/providers/user_provider.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isLogined = context.watch<UserProvider>().isLogined;
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
          return ExpansionTile(
            title: Text(
              item["title"],
            ),
            subtitle: Text(
              item["date"],
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),
            // trailing: Icon(
            //   _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
            //   size: 30,
            // ),
            childrenPadding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              SizedBox(
                width: double.infinity,
                child: Text(
                  item["content"],
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              Gaps.v20,
              if (isLogined)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () => context.pushNamed(
                          FaqEditScreen.routeName,
                          extra: FaqEditScreenArgs(
                            id: item["id"],
                            pageName: "자주묻는 질문 수정",
                            title: item["title"],
                            content: item["content"],
                          ),
                        ),
                        child: const Text("수정"),
                      ),
                      Gaps.h10,
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text("삭제"),
                      ),
                    ],
                  ),
                ),
            ],
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
