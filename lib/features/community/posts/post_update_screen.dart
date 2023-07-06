import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/widget_tools/swag_imgFile.dart';
import 'package:swag_cross_app/features/widget_tools/swag_state_dropDown_button.dart';
import 'package:swag_cross_app/features/widget_tools/swag_textfield.dart';

class PostUpdateScreenArgs {
  final String title;
  final String content;
  final List<String> images;

  PostUpdateScreenArgs({
    required this.title,
    required this.content,
    required this.images,
  });
}

class PostUpdateScreen extends StatefulWidget {
  static const routeName = "post_update";
  static const routeURL = "/post_update";
  const PostUpdateScreen({
    super.key,
    required this.title,
    required this.content,
    required this.images,
  });

  final String title;
  final String content;
  final List<String> images;

  @override
  State<PostUpdateScreen> createState() => _PostUpdateScreenState();
}

class _PostUpdateScreenState extends State<PostUpdateScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  final List<XFile> _imgList = [];
  final List<XFile> _removeImgList = [];

  String _category = "";
  final List<String> _categoryList = [
    "",
    "옵션 1",
    "옵션 2",
    "옵션 3",
    "옵션 4",
    "옵션 5",
  ];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.title);
    _contentController = TextEditingController(text: widget.content);
    // _imgList.addAll(widget.images);
  }

  // 이미지를 가져오는 함수
  Future _getImage(ImageSource? imageSource) async {
    final ImagePicker picker = ImagePicker(); //ImagePicker 초기화

    //pickedFile에 ImagePicker로 가져온 이미지가 담긴다.
    if (imageSource != null) {
      final XFile? pickedFile = await picker.pickImage(source: imageSource);
      if (pickedFile != null) {
        setState(() {
          _imgList.add(pickedFile); //가져온 이미지를 이미지 리스트에 저장
        });
      }
    } else {
      final List<XFile> pickedFiles = await picker.pickMultiImage();
      setState(() {
        _imgList.addAll(pickedFiles); //가져온 이미지를 이미지 리스트에 저장
      });
    }
    print(_imgList);
  }

  // 선택한 이미지를 삭제리스트에 넣는 함수
  void _addRemoveImgList(XFile img) {
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
    print(_removeImgList);
    print(_imgList);
    setState(() {});
  }

  void _onChangeOption(String option) {
    setState(() {
      _category = option;
    });
  }

  SliverAppBar _appBar() {
    return SliverAppBar(
      title: const Text("동아리 게시글 수정"),
      actions: [
        TextButton(
          child: const Text(
            "완료",
            style: TextStyle(
              color: Color(0xFF6524FF),
              fontSize: 18,
            ),
          ),
          onPressed: () {
            // 글 작성
            var title = _titleController.text;
            var content = _contentController.text;
            if (title == "" || content == "") return;
            print("글작성");
            print("제목: $title");
            print("내용: $content");
          },
        ),
      ],
    );
  }

  Widget _title({required String title}) {
    return Text(
      title,
      style: const TextStyle(
        color: Color(0xFF767676),
        fontSize: 16,
        fontWeight: FontWeight.w800,
      ),
    );
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
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          child: ElevatedButton(
            onPressed: _titleController.text.trim().isNotEmpty &&
                    _contentController.text.trim().isNotEmpty
                ? () {
                    print("카테고리 : $_category");
                    print("제목 : ${_titleController.text.trim()}");
                    print("내용 : ${_contentController.text.trim()}");
                    print("이미지 : $_imgList");
                  }
                : null,
            style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(
                fontSize: 16,
              ),
              backgroundColor: Colors.purple.shade300,
            ),
            child: const Text("등록"),
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomScrollView(
            slivers: [
              _appBar(),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _title(title: "카테고리"),
                    Gaps.v10,
                    SWAGStateDropDownButton(
                      initOption: _category,
                      onChangeOption: _onChangeOption,
                      title: "카테고리를 선택해주세요.",
                      options: _categoryList,
                      isExpanded: true,
                      width: double.infinity,
                      height: 60,
                      fontSize: 18,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    Gaps.v20,
                    _title(title: "제목"),
                    Gaps.v10,
                    SWAGTextField(
                      hintText: "글 제목을 입력해주세요.",
                      maxLine: 1,
                      controller: _titleController,
                      onChange: () {
                        print(_titleController.text);
                      },
                      onSubmitted: () {
                        print(_titleController.text);
                      },
                    ),
                    Gaps.v20,
                    _title(title: "내용"),
                    Gaps.v10,
                    SWAGTextField(
                      hintText: "내용을 입력해주세요.",
                      maxLine: 6,
                      controller: _contentController,
                      onChange: () {
                        print(_contentController.text);
                      },
                      onSubmitted: () {
                        print(_contentController.text);
                      },
                    ),
                    Gaps.v20,
                    _title(title: "이미지"),
                    Gaps.v10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                _getImage(ImageSource
                                    .camera); //getImage 함수를 호출해서 카메라로 찍은 사진 가져오기
                              },
                              child: const Text("카메라"),
                            ),
                            Gaps.h20,
                            ElevatedButton(
                              onPressed: () {
                                _getImage(ImageSource
                                    .gallery); //getImage 함수를 호출해서 갤러리에서 사진 가져오기
                              },
                              child: const Text("갤러리"),
                            ),
                          ],
                        ),
                        ElevatedButton.icon(
                          onPressed: _removeImg,
                          label: const Text("삭제"),
                          icon: const Icon(Icons.delete),
                        ),
                      ],
                    ),
                    Gaps.v10,
                  ],
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
      ),
    );
  }
}
