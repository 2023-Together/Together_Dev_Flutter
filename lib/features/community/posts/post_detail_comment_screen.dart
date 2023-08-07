import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/features/community/widgets/comment_card.dart';
import 'package:swag_cross_app/features/widget_tools/swag_textfield.dart';
import 'package:swag_cross_app/models/comment_model.dart';
import 'package:swag_cross_app/models/post_card_model.dart';
import 'package:swag_cross_app/providers/user_provider.dart';

import 'package:http/http.dart' as http;

class PostDetailCommentscreen extends StatefulWidget {
  const PostDetailCommentscreen({
    super.key,
    required this.postData,
  });

  final PostCardModel postData;

  @override
  State<PostDetailCommentscreen> createState() =>
      _PostDetailCommentscreenState();
}

class _PostDetailCommentscreenState extends State<PostDetailCommentscreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true; // 페이지 상태 유지를 위해 true 반환

  final TextEditingController _commentController = TextEditingController();

  List<CommentModel>? _commentsList;

  Future<List<CommentModel>> _commentGetDispatch() async {
    final url = Uri.parse(
        "http://58.150.133.91:80/together/post/getAllCommentByPostId");
    final headers = {'Content-Type': 'application/json'};
    final data = {"postId": widget.postData.postId};

    final response =
        await http.post(url, headers: headers, body: jsonEncode(data));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final jsonResponse = jsonDecode(response.body) as List<dynamic>;
      print(jsonResponse);
      print("댓글 불러오기 : 성공");

      final commentsList =
          jsonResponse.map((data) => CommentModel.fromJson(data)).toList();

      return commentsList;
    } else {
      print("${response.statusCode} : ${response.body}");
      throw Exception("통신 실패!");
    }
  }

  Future<void> _onSubmittedCommentEdit() async {
    final url =
        Uri.parse("http://58.150.133.91:80/together/post/createComment");
    final headers = {'Content-Type': 'application/json'};
    final data = {
      "commentUserId": context.read<UserProvider>().userData?.userId,
      "commentPostId": widget.postData.postId,
      "commentContent": _commentController.text,
      "commentParentnum": 0,
    };

    final response =
        await http.post(url, headers: headers, body: jsonEncode(data));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final jsonResponse = jsonDecode(response.body) as List<dynamic>;
      print("댓글 등록 : 성공");

      _commentsList = await _commentGetDispatch();
      setState(() {});
    } else {
      print("${response.statusCode} : ${response.body}");
      print("댓글 등록 : 실패");
    }
  }

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
              child: FutureBuilder(
                future: _commentsList != null
                    ? Future.value(
                        _commentsList!) // _postList가 이미 가져온 상태라면 Future.value 사용
                    : _commentGetDispatch(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // 데이터를 기다리는 동안 로딩 인디케이터 표시
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    // 에러가 발생한 경우 에러 메시지 표시
                    return Center(
                      child: Text('오류 발생: ${snapshot.error}'),
                    );
                  } else {
                    // 데이터를 성공적으로 가져왔을 때 ListView 표시
                    _commentsList = snapshot.data!;

                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final item = _commentsList![index];
                        return CommentCard(
                          commentData: item,
                        );
                      },
                      separatorBuilder: (context, index) => Gaps.v6,
                      itemCount: _commentsList!.length,
                    );
                  }
                },
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
                onSubmitted: _onSubmittedCommentEdit,
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
