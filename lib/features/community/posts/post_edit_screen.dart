// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/constants/http_ip.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/widget_tools/swag_imgFile.dart';
import 'package:swag_cross_app/features/widget_tools/swag_platform_dialog.dart';
import 'package:swag_cross_app/features/widget_tools/swag_textfield.dart';
import 'package:swag_cross_app/models/post_card_model.dart';
import 'package:swag_cross_app/providers/club_post_provider.dart';
import 'package:swag_cross_app/providers/main_post_provider.dart';
import 'package:swag_cross_app/providers/user_provider.dart';

enum PostEditType {
  mainInsert,
  clubInsert,
  mainUpdate,
  clubUpdate,
}

class PostEditScreenArgs {
  final String pageTitle;
  final PostEditType editType;
  final int? maxImages;
  final PostCardModel? postData;
  final int? clubId;

  PostEditScreenArgs({
    required this.pageTitle,
    required this.editType,
    this.maxImages,
    this.postData,
    this.clubId,
  });
}

class PostEditScreen extends StatefulWidget {
  static const routeName = "post_edit";
  static const routeURL = "/post_edit";

  const PostEditScreen({
    super.key,
    required this.pageTitle,
    required this.editType,
    this.maxImages,
    this.postData,
    this.clubId,
  });

  final String pageTitle;
  final PostEditType editType;
  final int? maxImages;
  final PostCardModel? postData;
  final int? clubId;

  @override
  State<PostEditScreen> createState() => _PostEditScreenState();
}

class _PostEditScreenState extends State<PostEditScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  final List<String> _imgList = [];
  // final List<XFile> _imgList = [];
  final List<String> _removeImgList = [];

  // late String _postTag = widget.category ?? "";
  // final List<String> _categoryList = [
  //   "",
  //   "옵션 1",
  //   "옵션 2",
  //   "옵션 3",
  //   "옵션 4",
  //   "옵션 5",
  // ];

  late bool _isThereSearchValue =
      _titleController.text.isNotEmpty && _contentController.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _titleController =
        TextEditingController(text: widget.postData?.postTitle ?? "");
    _contentController =
        TextEditingController(text: widget.postData?.postContent ?? "");

    // _imgList.addAll(widget.images ?? []);
  }

  void _textOnChange(String? value) {
    setState(() {
      _isThereSearchValue = _titleController.text.isNotEmpty &&
          _contentController.text.isNotEmpty;
    });
  }

  // 이미지를 가져오는 함수
  Future _getImage(ImageSource? imageSource) async {
    if (widget.maxImages != null) {
      if (_imgList.length >= widget.maxImages!) {
        swagPlatformDialog(
          context: context,
          title: "사진 개수 오류",
          message: "사진은 ${widget.maxImages}개만 업로드 할수 있습니다!",
          actions: [
            TextButton(
              onPressed: () => context.pop(),
              child: const Text("확인"),
            ),
          ],
        );
        return;
      } else {
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
          if (_imgList.length + pickedFiles.length > widget.maxImages!) {
            if (!mounted) return;
            swagPlatformDialog(
              context: context,
              title: "사진 개수 오류",
              message: "사진은 ${widget.maxImages}개만 업로드 할수 있습니다!",
              actions: [
                TextButton(
                  onPressed: () => context.pop(),
                  child: const Text("확인"),
                ),
              ],
            );
            return;
          }
          setState(() {
            _imgList
                .addAll(pickedFiles.map((e) => e.path)); //가져온 이미지를 이미지 리스트에 저장
          });
        }
      }
    } else {
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
          _imgList
              .addAll(pickedFiles.map((e) => e.path)); //가져온 이미지를 이미지 리스트에 저장
        });
      }
    }
  }

  // 선택한 이미지를 삭제리스트에 넣는 함수
  void _addRemoveImgList(String img) {
    if (_removeImgList.contains(img)) {
      _removeImgList.remove(img);
    } else {
      _removeImgList.add(img);
    }
    print(_removeImgList);
  }

  // 선택한 모든 이미지를 삭제하는 함수
  void _removeImg() {
    _imgList.removeWhere(
      (element) => _removeImgList.contains(element),
    );

    _removeImgList.clear();

    print(_imgList);
    setState(() {});
  }

  // void _onChangeOption(String option) {
  //   setState(() {
  //     _category = option;
  //   });
  // }

  Future<void> _onSubmitFinishButton() async {
    // Iterable<String> base64Images = _imgList.isNotEmpty
    //     ? _imgList.map(
    //         (e) => base64Encode(File(e).readAsBytesSync()),
    //       )
    //     : [];
    final userData = context.read<UserProvider>().userData;

    if (widget.editType == PostEditType.mainInsert) {
      // 메인 게시물 등록
      final url = Uri.parse("${HttpIp.communityUrl}/together/post/createPost");
      final headers = {'Content-Type': 'application/json'};
      final data = {
        "postBoardId": "11",
        "postUserId": "1",
        "postTitle": _titleController.text,
        "postContent": _contentController.text,
      };

      final response =
          await http.post(url, headers: headers, body: jsonEncode(data));

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('생성 성공!');
        if (!mounted) return;
        context.read<MainPostProvider>().mainPostGetDispatch(
              userId: userData!.userId,
            );
        context.pop();
      } else {
        if (!mounted) return;
        swagPlatformDialog(
          context: context,
          title: "${response.statusCode} 오류",
          message: "게시글 생성에 오류가 발생하였습니다! \n ${response.body}",
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
    } else if (widget.editType == PostEditType.clubInsert) {
      // 동아리 게시물 등록
      final url =
          Uri.parse("${HttpIp.communityUrl}/together/post/createPostByClubId");
      final headers = {'Content-Type': 'application/json'};
      final data = {
        "clubId": widget.clubId,
        "postUserId": userData!.userId,
        "postTitle": _titleController.text,
        "postContent": _contentController.text,
      };

      final response =
          await http.post(url, headers: headers, body: jsonEncode(data));

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('생성 성공!');
        if (!mounted) return;
        context.read<ClubPostProvider>().clubPostGetDispatch(
              userId: userData.userId,
              clubId: widget.clubId,
            );
        context.pop();
      } else {
        if (!mounted) return;
        swagPlatformDialog(
          context: context,
          title: "${response.statusCode} 오류",
          message: "게시글 생성에 오류가 발생하였습니다! \n ${response.body}",
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
    } else if (widget.editType == PostEditType.mainUpdate) {
      // 메인 게시물 수정
      print("메인 게시물 수정");
      final url =
          Uri.parse("${HttpIp.communityUrl}/together/post/updatePostByPostId");
      final headers = {'Content-Type': 'application/json'};
      final data = {
        "postId": widget.postData!.postId,
        "postUserId": userData!.userId,
        "postTitle": _titleController.text,
        "postContent": _contentController.text,
      };

      final response =
          await http.post(url, headers: headers, body: jsonEncode(data));

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("메인 게시물 수정 : 성공");
        if (!mounted) return;
        context
            .read<MainPostProvider>()
            .refreshMainPostDispatch(userId: userData.userId);

        context.pop();
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
    } else if (widget.editType == PostEditType.clubUpdate) {
      // 동아리 게시물 수정
      print("동아리 게시물 수정");
      final url =
          Uri.parse("${HttpIp.communityUrl}/together/post/updatePostByPostId");
      final headers = {'Content-Type': 'application/json'};
      final data = {
        "postId": widget.postData!.postId,
        "postUserId": userData!.userId,
        "postTitle": _titleController.text,
        "postContent": _contentController.text,
      };

      final response =
          await http.post(url, headers: headers, body: jsonEncode(data));

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("동아리 게시물 수정 : 성공");

        if (!mounted) return;
        context.read<ClubPostProvider>().refreshClubPostDispatch(
              userId: userData.userId,
              clubId: widget.clubId,
            );

        context.pop();
        context.pop();
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
    } else {
      // 오류
      print("오류!");
    }
  }

  @override
  void dispose() {
    _contentController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: ElevatedButton(
          onPressed: _titleController.text.trim().isNotEmpty &&
                  _contentController.text.trim().isNotEmpty
              ? _onSubmitFinishButton
              : null,
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
            SliverAppBar(
              title: Text(widget.pageTitle),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // if (!(widget.postData!.postTag!.isNotEmpty))
                    //   Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Gaps.v20,
                    //       Text(
                    //         "카테고리",
                    //         style: Theme.of(context).textTheme.titleSmall,
                    //       ),
                    //       Gaps.v10,
                    //       SWAGStateDropDownButton(
                    //         initOption: _category,
                    //         onChangeOption: _onChangeOption,
                    //         title: "카테고리를 선택해주세요.",
                    //         options: _categoryList,
                    //         isExpanded: true,
                    //         width: double.infinity,
                    //         height: 60,
                    //         fontSize: 18,
                    //         padding: const EdgeInsets.symmetric(horizontal: 16),
                    //       ),
                    //     ],
                    //   ),
                    Gaps.v20,
                    Text(
                      "제목",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Gaps.v10,
                    SWAGTextField(
                      hintText: "제목을 입력해주세요.",
                      maxLine: 1,
                      controller: _titleController,
                      onChanged: _textOnChange,
                    ),
                    Gaps.v28,
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
                    Gaps.v8,
                    Text(
                      "# 본 커뮤니티는 봉사와 관련된 정보를 교환하기 위해 만들어진 어플리케이션입니다. 아래의 규칙을 지켜주시기 바랍니다.",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    Gaps.v8,
                    Text(
                      "- 존중과 예의",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    Text(
                      "- 정확한 정보 공유",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    Text(
                      "- 긍정적인 분위기 조성",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    Text(
                      "- 불건전한 콘텐츠 금지",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    Text(
                      "- 개인정보 보호",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    Text(
                      "- 홍보 및 광고 금지",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    Text(
                      "- 불법 콘텐츠 및 저작권",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    Text(
                      "- 커뮤니티 활동 적극 참여",
                      style: Theme.of(context).textTheme.labelMedium,
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