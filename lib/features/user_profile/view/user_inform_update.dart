import 'package:flutter/material.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/features/widget_tools/swag_textfield.dart';

class UserInformArgs {
  final String userDid; // 유저 did
  final String userId; // 유저 아이디
  final String userPw; // 유저 비밀번호
  final String userName; // 유저 이름
  final String userDef; // 유저 프로필 설명
  final String userType; // 봉사자, 기관 구분용
  final String birth; // 유저 생일

  UserInformArgs({
    required this.userDid,
    required this.userId,
    required this.userPw,
    required this.userName,
    required this.userDef,
    required this.userType,
    required this.birth,
  });
}

// 마이페이지 정보수정 페이지
class UserInformUpdate extends StatefulWidget {
  static const routeName = "user_inform";
  static const routeURL = "/user_inform";

  final String userDid; // 유저 did
  final String userId; // 유저 아이디
  final String userPw; // 유저 비밀번호
  final String userName; // 유저 이름
  final String userDef; // 유저 프로필 설명
  final String userType; // 봉사자, 기관 구분용
  final String birth; // 유저 생일

  const UserInformUpdate({
    super.key,
    required this.userDid,
    required this.userId,
    required this.userPw,
    required this.userName,
    required this.userDef,
    required this.userType,
    required this.birth,
  });

  @override
  State<UserInformUpdate> createState() => _UserInformUpdateState();
}

class _UserInformUpdateState extends State<UserInformUpdate> {
  // 검색 제어를 위한 컨트롤러
  final TextEditingController _searchController = TextEditingController();

  Future<void> _showAlertDialog() async {
    // 개인정보 수정여부 모달창
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('개인정보 수정'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('해당 정보를 수정하시겠습니까?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              // 취소 버튼
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('아니오'),
            ),
            TextButton(
              // 신청 버튼
              onPressed: () {},
              child: const Text('예'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("회원 정보 수정"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Expanded(
                child: GestureDetector(
                  child: const CircleAvatar(
                    radius: 38.0,
                    foregroundImage: NetworkImage(
                      "https://avatars.githubusercontent.com/u/77985708?v=4",
                    ),
                    child: Text("재현"),
                  ),
                ),
              ),
            ),

            // 회원 정보 관련 요소들 column으로 정렬
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
              child: Column(
                // sns 로그인을 통해 정보를 자동으로 가져온다.
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: SWAGTextField(
                      hintText: widget.userId,
                      maxLine: 1,
                      controller: _searchController,
                      onSubmitted: () {
                        _searchController.text = "";
                      },
                      // decoration: InputDecoration(
                      //   hintText: ,
                      //   //   style: TextStyle(
                      //   //   fontSize: 14.0,
                      //   // ),
                      //   labelText: widget.userId,
                      //   enabledBorder: OutlineInputBorder(
                      //     borderSide: BorderSide(
                      //       width: 1,
                      //       color: Colors.grey,
                      //     ),
                      //   ),
                      // ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: SWAGTextField(
                      hintText: widget.userName,
                      maxLine: 1,
                      controller: _searchController,
                      onSubmitted: () {
                        _searchController.text = "";
                      },
                      // TextFormField(
                      //   decoration: InputDecoration(
                      //     hintText: '이름을 입력하세요.',
                      //     labelText: widget.userName,
                      //     enabledBorder: OutlineInputBorder(
                      //       borderSide: BorderSide(
                      //         width: 1,
                      //         color: Colors.grey,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: SWAGTextField(
                      hintText: "여자",
                      maxLine: 1,
                      controller: _searchController,
                      onSubmitted: () {
                        _searchController.text = "";
                      },
                    ),
                    // TextFormField(
                    //   decoration: const InputDecoration(
                    //     labelText: '성별',
                    //     enabledBorder: OutlineInputBorder(
                    //       borderSide: BorderSide(
                    //         width: 1,
                    //         color: Colors.grey,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: SWAGTextField(
                      hintText: "010-0000-0000",
                      maxLine: 1,
                      controller: _searchController,
                      onSubmitted: () {
                        _searchController.text = "";
                      },
                      // TextFormField(
                      //   decoration: const InputDecoration(
                      //     labelText: '전화번호 (휴대폰 번호)',
                      //     hintText: '전화번호를 입력하세요.',
                      //     enabledBorder: OutlineInputBorder(
                      //       borderSide: BorderSide(
                      //         width: 1,
                      //         color: Colors.grey,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: SWAGTextField(
                      hintText: widget.birth,
                      maxLine: 1,
                      controller: _searchController,
                      onSubmitted: () {
                        _searchController.text = "";
                      },
                    ),
                    // TextFormField(
                    //   decoration: InputDecoration(
                    //     hintText: '생년월일을 입력하세요.',
                    //     labelText: widget.birth,
                    //     enabledBorder: OutlineInputBorder(
                    //       borderSide: BorderSide(
                    //         width: 1,
                    //         color: Colors.grey,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ),
                  Gaps.h10,
                  ElevatedButton(
                    // 수정하기 버튼
                    onPressed: () {
                      _showAlertDialog();
                    },
                    child: const Text("수정하기"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
