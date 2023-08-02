import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/user_profile/view/change_user_pw.dart';
import 'package:swag_cross_app/features/user_profile/view/user_profile_screen.dart';

import 'package:http/http.dart' as http;

class UserInformArgs {
  final String userId; // 유저 아이디
  final String userEmail; // 유저 이메일
  final String userPw; // 유저 비밀번호
  final String userName; // 유저 이름
  final String userNickName; // 유저 닉네임
  final String userGender; // 유저 성별
  final String userPhoneNumber; // 유저 전화번호
  final String userDef; // 유저 프로필 설명
  final String userType; // 봉사자, 기관 구분용
  final String userBirthDate; // 유저 생일

  UserInformArgs({
    required this.userId,
    required this.userPw,
    required this.userName,
    required this.userNickName,
    required this.userEmail,
    required this.userDef,
    required this.userType,
    required this.userBirthDate,
    required this.userGender,
    required this.userPhoneNumber,
  });
}

class UserInformUpdate extends StatefulWidget {
  static const routeName = "user_inform_update";
  static const routeURL = "/user_inform_update";

  final String userId; // 유저 아이디
  final String userEmail; // 유저 이메일
  final String userPw; // 유저 비밀번호
  final String userName; // 유저 이름
  final String userNickName; // 유저 닉네임
  final String userGender; // 유저 성별
  final String userPhoneNumber; // 유저 전화번호
  final String userDef; // 유저 프로필 설명
  final String userType; // 봉사자, 기관 구분용
  final String userBirthDate; // 유저 생일

  const UserInformUpdate({
    Key? key,
    required this.userId,
    required this.userPw,
    required this.userName,
    required this.userNickName,
    required this.userEmail,
    required this.userDef,
    required this.userType,
    required this.userBirthDate,
    required this.userGender,
    required this.userPhoneNumber,
  }) : super(key: key);

  @override
  State<UserInformUpdate> createState() => _UserInformUpdateState();
}

class _UserInformUpdateState extends State<UserInformUpdate> {
  String _newUserName = '';
  String _newUserDef = '';
  String _newUserBirthDate = '';
  String _newUserType = '';
  String _newUserEmail = '';
  String _newUserPw = '';
  String _newUserNickName = '';
  String _newUserGender = '';
  String _newUserPhoneNumber = '';

  DateTime? _selectedDate;

  // void _updateUserInfo() {
  //   Navigator.pop(context);
  // }

  @override
  void initState() {
    super.initState();
    
  }

  void _openDatePicker(BuildContext context) {
    BottomPicker.date(
      title: "생년월일을 입력해주세요.",
      dateOrder: DatePickerDateOrder.ymd,
      pickerTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 14,
      ),
      titleStyle: const TextStyle(
        color: Colors.black,
        fontSize: 15.0,
      ),
      onSubmit: (value) {
        setState(() {
          _selectedDate = value;
        });
      },
      bottomPickerTheme: BottomPickerTheme.plumPlate,
    ).show(context);
  }

  // // 유저 정보를 수정하는 통신
  // Future<void> _userUpdateDispatch() async {
  //   final url = Uri.parse("http://175.201.78.168:80/together/update");
  //   final response = await http.post(url);
  //   print('Response status: ${response.statusCode}');
  //   print('Response body: ${response.body}');

  //   // 응답 처리
  //   if (response.statusCode == 200) {
  //     print("Response body: ${response.body}");
  //   } else {
  //     print('Response status: ${response.statusCode}');
  //     print('Response body: ${response.body}');
  //   }
  // }

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
              // 수정 버튼
              onPressed: () {
                // _userUpdateDispatch();
              },
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
        // actions: [
        //   IconButton(
        //     onPressed: _updateUserInfo,
        //     icon: const Icon(Icons.done),
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Expanded(
              //     child: GestureDetector(
              //       child: CircleAvatar(
              //         radius: 38.0,
              //         foregroundImage: NetworkImage(
              //           "https://avatars.githubusercontent.com/u/77985708?v=4",
              //         ),
              //         child: Text("재현"),
              //       ),
              //     ),
              //   ),
              // ),
              TextFormField(
                initialValue: userDatas[0]['userName'],
                onChanged: (value) {
                  setState(() {
                    _newUserName = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: "이름",
                ),
              ),
              TextFormField(
                initialValue: userDatas[0]['userDef'],
                onChanged: (value) {
                  setState(() {
                    _newUserDef = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: "인사말",
                ),
              ),
              TextFormField(
                initialValue: userDatas[0]['userNickName'],
                onChanged: (value) {
                  setState(() {
                    _newUserNickName = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: "닉네임",
                ),
              ),
              TextFormField(
                initialValue: userDatas[0]['userEmail'],
                readOnly: true,
                onChanged: (value) {
                  setState(() {
                    _newUserEmail = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: "이메일",
                ),
              ),
              TextFormField(
                initialValue: userDatas[0]['userPw'],
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    _newUserPw = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: "비밀번호",
                  suffixIcon: IconButton(
                    onPressed: () {
                      context.pushNamed(
                      ChangeUserPw.routeName,
                      extra: ChangeUserPwArgs(
                        userPw: _newUserPw,
                      ),
                    );
                    },
                    icon: Icon(
                      Icons.chevron_right_rounded,
                      size: Sizes.size24,
                    ),
                  ),
                ),
              ),
              TextFormField(
                initialValue: userDatas[0]['userGender'],
                onChanged: (value) {
                  setState(() {
                    _newUserGender = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: "성별",
                ),
              ),
              TextFormField(
                initialValue: userDatas[0]['userBirthDate'],
                onChanged: (value) {
                  setState(() {
                    _newUserBirthDate = value;
                  });
                },
                onTap: () {
                  _openDatePicker(context);
                },
                decoration: InputDecoration(
                  labelText: "생년월일",
                ),
              ),
              TextFormField(
                initialValue: userDatas[0]['userPhoneNumber'],
                onChanged: (value) {
                  setState(() {
                    _newUserPhoneNumber = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: "전화번호",
                ),
              ),
              TextFormField(
                initialValue: userDatas[0]['userType'],
                readOnly: true,
                onChanged: (value) {
                  setState(() {
                    _newUserType = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: "사용자 구분",
                ),
              ),
              
              Gaps.h20,
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
      ),
    );
  }
}
