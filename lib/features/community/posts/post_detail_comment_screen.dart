import 'package:flutter/material.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/features/community/widgets/comment_card.dart';
import 'package:swag_cross_app/features/widget_tools/swag_textfield.dart';

class PostDetailCommentscreen extends StatefulWidget {
  const PostDetailCommentscreen({super.key});

  @override
  State<PostDetailCommentscreen> createState() =>
      _PostDetailCommentscreenState();
}

class _PostDetailCommentscreenState extends State<PostDetailCommentscreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true; // 페이지 상태 유지를 위해 true 반환

  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // 반드시 super.build(context) 호출해야 함
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  final item = comments[index];
                  return CommentCard(
                    username: item['username'],
                    date: item['date'],
                    comment: item['comment'],
                    id: item['id'],
                  );
                },
                separatorBuilder: (context, index) => Gaps.v6,
                itemCount: comments.length,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
              ),
              padding: const EdgeInsets.all(10),
              child: SWAGTextField(
                hintText: "등록할 댓글을 입력해주세요..",
                maxLine: 1,
                controller: _commentController,
                onSubmitted: () {
                  print(_commentController.text);
                  _commentController.text = "";
                },
                buttonText: "등록",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<Map<String, dynamic>> comments = [
  {
    "id": 1,
    "username": "홍길동",
    "comment": "여기 분위기는 어떤가요?",
    "date": "2023-05-22 01:19",
  },
  {
    "id": 2,
    "username": "홍길순",
    "comment": "언제까지 모집하나요?",
    "date": "2023-05-26 11:39",
  },
  {
    "id": 3,
    "username": "임대원",
    "comment": "제가 찾던 동아리입니다!",
    "date": "2023-05-28 15:12",
  },
];
