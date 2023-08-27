import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/constants/http_ip.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/widget_tools/swag_imgFile.dart';
import 'package:swag_cross_app/features/widget_tools/swag_platform_dialog.dart';
import 'package:swag_cross_app/features/widget_tools/swag_textfield.dart';
import 'package:swag_cross_app/models/post_card_model.dart';
import 'package:swag_cross_app/providers/user_provider.dart';

import 'package:http/http.dart' as http;

enum NoticeEditType {
  noticeUpdate,
  noticeInsert,
}

class NoticeEditScreenArgs {
  final PostCardModel? noticeData;
  final String pageName;
  final NoticeEditType editType;

  NoticeEditScreenArgs({
    this.noticeData,
    required this.pageName,
    required this.editType,
  });
}

class NoticeEditScreen extends StatefulWidget {
  static const routeName = "notice_edit";
  static const routeURL = "notice_edit";

  const NoticeEditScreen({
    super.key,
    this.noticeData,
    required this.pageName,
    required this.editType,
  });

  final PostCardModel? noticeData;
  final NoticeEditType editType;
  final String pageName;

  @override
  State<NoticeEditScreen> createState() => _NoticeEditScreenState();
}

class _NoticeEditScreenState extends State<NoticeEditScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  late bool _isThereSearchValue =
      _titleController.text.isNotEmpty && _contentController.text.isNotEmpty;

  final List<String> _imgList = [];
  final List<String> _removeImgList = [];

  @override
  void initState() {
    super.initState();

    _titleController =
        TextEditingController(text: widget.noticeData?.postTitle ?? "");
    _contentController =
        TextEditingController(text: widget.noticeData?.postContent ?? "");
  }

  Future<void> _onSubmitFinishButton() async {
    final userData = context.read<UserProvider>().userData;
    if (widget.editType == NoticeEditType.noticeInsert) {
      // 공지사항 추가
      final url = Uri.parse("${HttpIp.communityUrl}/together/post/createPost");
      final headers = {'Content-Type': 'application/json'};
      final data = {
        "postBoardId": "1",
        "postUserId": userData!.userId,
        "postTitle": _titleController.text,
        "postContent": _contentController.text,
      };

      final response =
          await http.post(url, headers: headers, body: jsonEncode(data));

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('생성 성공!');
        if (!mounted) return;
        context.pop();
        setState(() {});
      } else {
        if (!mounted) return;
        swagPlatformDialog(
          context: context,
          title: "${response.statusCode} 오류",
          message: "공지사항 생성에 오류가 발생하였습니다! \n ${response.body}",
          actions: [
            TextButton(
              onPressed: () {
                context.pop();
              },
              child: const Text("알겠습니다"),
            ),
          ],
        );
      }
    } else {
      // 공지사항 수정
      final url =
          Uri.parse("${HttpIp.communityUrl}/together/post/updatePostByPostId");
      final headers = {'Content-Type': 'application/json'};
      final data = {
        "postId": widget.noticeData!.postId,
        "postUserId": userData!.userId,
        "postTitle": _titleController.text,
        "postContent": _contentController.text,
      };

      final response =
          await http.post(url, headers: headers, body: jsonEncode(data));

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("공지사항 수정 : 성공");
        if (!mounted) return;
        widget.noticeData!.postTitle = _titleController.text;
        widget.noticeData!.postContent = _contentController.text;
        context.pop();
        setState(() {});
      } else {
        if (!mounted) return;
        swagPlatformDialog(
          context: context,
          title: "${response.statusCode} 오류",
          message: "게시글 수정에 오류가 발생하였습니다! \n ${response.body}",
          actions: [
            TextButton(
              onPressed: () {
                context.pop();
              },
              child: const Text("알겠습니다"),
            ),
          ],
        );
      }
    }
  }

  void _textOnChange(String? value) {
    setState(() {
      _isThereSearchValue = _titleController.text.trim().isNotEmpty &&
          _contentController.text.trim().isNotEmpty;
    });
  }

  // 이미지를 가져오는 함수
  Future _getImage(ImageSource? imageSource) async {
    final ImagePicker picker = ImagePicker(); //ImagePicker 초기화

    //pickedFile에 ImagePicker로 가져온 이미지가 담긴다.
    if (imageSource != null) {
      // 카메라
      final XFile? pickedFile = await picker.pickImage(source: imageSource);
      if (pickedFile != null) {
        setState(() {
          _imgList.add(pickedFile.path); //가져온 이미지를 이미지 리스트에 저장
        });
      }
    } else {
      // 갤러리
      List<XFile> pickedFiles = await picker.pickMultiImage();
      setState(() {
        _imgList.addAll(pickedFiles.map((e) => e.path)); //가져온 이미지를 이미지 리스트에 저장
      });
    }
  }

  // 선택한 모든 이미지를 삭제하는 함수
  void _removeImg() {
    _imgList.removeWhere(
      (element) => _removeImgList.contains(element),
    );

    _removeImgList.clear();

    setState(() {});
  }

  // 선택한 이미지를 삭제리스트에 넣는 함수
  void _addRemoveImgList(String img) {
    if (_removeImgList.contains(img)) {
      _removeImgList.remove(img);
    } else {
      _removeImgList.add(img);
    }
  }

  SliverAppBar _appBar() {
    return SliverAppBar(
      title: Text(widget.pageName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: ElevatedButton(
          onPressed: _isThereSearchValue ? _onSubmitFinishButton : null,
          style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(
              fontSize: 18,
            ),
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
          child: const Text("등록"),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: CustomScrollView(
          slivers: [
            _appBar(),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gaps.v10,
                    Text(
                      "제목",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Gaps.v10,
                    SWAGTextField(
                      hintText: "글 제목을 입력해주세요.",
                      maxLine: 1,
                      controller: _titleController,
                      onChanged: _textOnChange,
                    ),
                    Gaps.v40,
                    Text(
                      "내용",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Gaps.v10,
                    SWAGTextField(
                      hintText: "내용을 입력해주세요.",
                      maxLine: 6,
                      controller: _contentController,
                      onChanged: _textOnChange,
                    ),
                    // Gaps.v40,
                    // Text(
                    //   "이미지",
                    //   style: Theme.of(context).textTheme.titleSmall,
                    // ),
                    // Gaps.v10,
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Row(
                    //       children: [
                    //         ElevatedButton(
                    //           onPressed: () {
                    //             _getImage(ImageSource
                    //                 .camera); //getImage 함수를 호출해서 카메라로 찍은 사진 가져오기
                    //           },
                    //           style: ButtonStyle(
                    //             backgroundColor: MaterialStateColor.resolveWith(
                    //               (states) => Colors.purple.shade300,
                    //             ),
                    //           ),
                    //           child: const Text("카메라"),
                    //         ),
                    //         Gaps.h20,
                    //         ElevatedButton(
                    //           onPressed: () {
                    //             _getImage(ImageSource
                    //                 .gallery); //getImage 함수를 호출해서 갤러리에서 사진 가져오기
                    //           },
                    //           child: const Text("갤러리"),
                    //         ),
                    //       ],
                    //     ),
                    //     ElevatedButton.icon(
                    //       onPressed: _removeImg,
                    //       label: const Text("삭제"),
                    //       icon: const Icon(Icons.delete),
                    //     ),
                    //   ],
                    // ),
                    // Gaps.v10,
                  ],
                ),
              ),
            ),
            if (_imgList.isNotEmpty)
              SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  // (context, index) => Image.file(
                  //   File(_imgList[index].path),
                  //   fit: BoxFit.cover,
                  // ),
                  (context, index) => SWAGImgFile(
                    key: UniqueKey(),
                    img: _imgList[index],
                    addRemoveImgList: _addRemoveImgList,
                  ),
                  childCount: _imgList.length,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  // 한 줄당 몇개를 넣을건지 지정
                  crossAxisCount: 3,
                  // 좌우 간격
                  crossAxisSpacing: Sizes.size4,
                  // 위아래 간격
                  mainAxisSpacing: Sizes.size4,
                  // 가로 / 세로 비율
                  childAspectRatio: 1 / 1,
                ),
              ),
          ],
        ),
      ),
    );
  }
}