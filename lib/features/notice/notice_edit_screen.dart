import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/widget_tools/swag_imgFile.dart';
import 'package:swag_cross_app/features/widget_tools/swag_textfield.dart';
import 'package:swag_cross_app/models/post_card_model.dart';

class NoticeEditScreenArgs {
  final PostCardModel? noticeData;
  final String pageName;

  NoticeEditScreenArgs({
    this.noticeData,
    required this.pageName,
  });
}

class NoticeEditScreen extends StatefulWidget {
  static const routeName = "notice_edit";
  static const routeURL = "notice_edit";

  const NoticeEditScreen({
    super.key,
    this.noticeData,
    required this.pageName,
  });

  final PostCardModel? noticeData;
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
    print("제목 : ${_titleController.text}");
    print("내용 : ${_contentController.text}");
  }

  void _textOnChange(String? value) {
    setState(() {
      _isThereSearchValue = _titleController.text.isNotEmpty &&
          _contentController.text.isNotEmpty;
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
                      onSubmitted: () {
                        print(_titleController.text);
                      },
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
                      onSubmitted: () {
                        print(_contentController.text);
                      },
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
