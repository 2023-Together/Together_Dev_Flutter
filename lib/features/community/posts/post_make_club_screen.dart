import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/widget_tools/swag_textfield.dart';

class PostMakeClubScreen extends StatefulWidget {
  static const routeName = "post_make";
  static const routeURL = "/post_make";

  const PostMakeClubScreen({super.key});

  @override
  State<PostMakeClubScreen> createState() => _PostMakeClubScreenState();
}

class _PostMakeClubScreenState extends State<PostMakeClubScreen> {
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
      appBar: AppBar(
        title: const Text("동아리 만들기"),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text("완료"),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _title(title: "동아리명"),
                Gaps.v10,
                SWAGTextField(
                    hintText: "동아리명을 적어주세요.",
                    maxLine: 1,
                    controller: _titleController),
                const SizedBox(
                  height: 20.0,
                ),
                _title(title: "모집 인원"),
                Gaps.v10,
                GestureDetector(
                  onTap: () {
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
                          "0명",
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
                const SizedBox(
                  height: 40.0,
                ),
                _title(title: "내용"),
                Gaps.v10,
                SWAGTextField(
                  hintText: "어떤 동아리인지 설명해주세요. (가입 규칙 또는 인사말 등)",
                  maxLine: 10,
                  controller: _contentController,
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
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
