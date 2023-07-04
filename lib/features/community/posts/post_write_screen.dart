import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/widget_tools/swag_imgFile.dart';
import 'package:swag_cross_app/features/widget_tools/swag_textfield.dart';

class PostWriteScreen extends StatefulWidget {
  static const routeName = "post_write";
  static const routeURL = "/post_write";

  const PostWriteScreen({super.key});

  @override
  State<PostWriteScreen> createState() => _PostWriteScreenState();
}

class _PostWriteScreenState extends State<PostWriteScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  final List<String> _imgList = [];
  final List<String> _removeImgList = [];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _contentController = TextEditingController();
  }

  // 이미지를 가져오는 함수
  Future _getImage(ImageSource imageSource) async {
    final ImagePicker picker = ImagePicker(); //ImagePicker 초기화

    //pickedFile에 ImagePicker로 가져온 이미지가 담긴다.
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      setState(() {
        _imgList.add(pickedFile.path); //가져온 이미지를 이미지 리스트에 저장
      });
    }
    print(_imgList);
  }

  // 선택한 이미지를 삭제리스트에 넣는 함수
  void _addRemoveImgList(String img) {
    print(img);
    _removeImgList.add(img);
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

  SliverAppBar _appBar() {
    return SliverAppBar(
      title: const Text("동아리 게시글 작성"),
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
                    GestureDetector(
                      // 게시글 데이터베이스 중 post_tag (무슨 태그 있는진 아직 모름)
                      onTap: () {
                        // Bottom Sheet 올라와서 tag 선택가능하도록
                        print("카테고리 선택");
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        width: double.infinity,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.5,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "카테고리를 선택해주세요.",
                              style: TextStyle(
                                color: const Color(0xFF767676).withOpacity(0.7),
                                fontSize: 18,
                              ),
                            ),
                            const Icon(Icons.arrow_drop_down),
                          ],
                        ),
                      ),
                    ),
                    Gaps.v40,
                    _title(title: "제목"),
                    Gaps.v10,
                    SWAGTextField(
                      hintText: "글 제목을 입력해주세요.",
                      maxLine: 1,
                      controller: _titleController,
                      onSubmitted: () {
                        print(_titleController.text);
                      },
                    ),
                    Gaps.v40,
                    _title(title: "내용"),
                    Gaps.v10,
                    SWAGTextField(
                      hintText: "내용을 입력해주세요.",
                      maxLine: 10,
                      controller: _contentController,
                      onSubmitted: () {
                        print(_contentController.text);
                      },
                    ),
                    Gaps.v40,
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
                    (context, index) => GestureDetector(
                      onTap: () {
                        _addRemoveImgList(_imgList[index]);
                      },
                      child: SWAGImgFile(img: _imgList[index]),
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
