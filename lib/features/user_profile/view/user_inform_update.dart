import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/user_profile/view/change_phoneNum.dart';
import 'package:swag_cross_app/features/user_profile/view/user_profile_screen.dart';

import 'package:http/http.dart' as http;
import 'package:swag_cross_app/features/widget_tools/swag_textfield.dart';

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
  DateTime? _newUserBirthDate = DateTime.now();

  String _newUserType = '';
  String _newUserEmail = '';
  String _newUserPw = '';
  String _newUserNickName = '';
  String _newUserGender = '';
  String _newUserPhoneNumber = '';


  String? _mobileError;
  String? _mobileHelper;
  String? _nickNameError;
  String? _nickNameHelper;


  final TextEditingController _emailController =
      TextEditingController(text: userDatas[0]['userEmail']);
  final TextEditingController _userNameController =
      TextEditingController(text: userDatas[0]['userName']);
  final TextEditingController _userBirthDateController =
      TextEditingController(text: userDatas[0]['userBirthDate']);
  final TextEditingController _userDefController =
      TextEditingController(text: userDatas[0]['userDef']);
  final TextEditingController _userTypeController =
      TextEditingController(text: userDatas[0]['userType']);
  final TextEditingController _userPwController =
      TextEditingController(text: userDatas[0]['userPw']);
  final TextEditingController _userNickNameController =
      TextEditingController(text: userDatas[0]['userNickName']);
  final TextEditingController _userPhoneNumberController =
      TextEditingController(text: userDatas[0]['userPhoneNumber']);
  final TextEditingController _userGenderController =
      TextEditingController(text: userDatas[0]['userGender']);

  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _mobileCheckController = TextEditingController();

  bool _isEditFinished = false;
  bool _isAuthMobile = false;
    bool _isAuthNickName = false;


  // void _updateUserInfo() {
  //   Navigator.pop(context);
  // }

  Widget _title({required String title}) {
    return Text(
      title,
      style: const TextStyle(
          color: Color.fromARGB(255, 152, 152, 152),
          fontSize: 15,
          fontWeight: FontWeight.w700,
          height: 3),
    );
  }

  void _onChangeAllText() {
    _isEditFinished = _newUserName.trim().isNotEmpty &&
        _newUserGender.trim().isNotEmpty &&
        _newUserEmail.trim().isNotEmpty &&
        (_mobileError == null && _mobileController.text.trim().isNotEmpty);
    setState(() {});
  }

  Future<void> _onCheckNickName() async {
    final url = Uri.parse("http://59.4.3.198:80/together/selectByUserNickname");
    final data = {
      "userNickname": _userNickNameController.text,
    };

    final response = await http.post(url, body: data);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final result = int.parse(response.body);
      if (result == 0) {
        setState(() {
          _isAuthNickName = true;
          _nickNameHelper = "인증이 완료되었습니다!";
          _onChangeAllText();
        });
      } else {
        setState(() {
          _nickNameError = "중복된 닉네임이 존재합니다!";
        });
      }
    } else {
      _nickNameError = "통신 실패!";
      print(response.statusCode);
      print(response.body);
    }
  }

  bool _onChangeNickName(String? value) {
    if (value == null) return false;
    // 닉네임 정규식 패턴
    RegExp nickNameRegex = RegExp(
        r"^(?!^\d)(?=^.{3,20}$)[a-zA-Z0-9_-\uAC00-\uD7AF\u1100-\u11FF\u3130-\u318F\uA960-\uA97F\uAC00-\uD7A3]+$");
    if (value.isEmpty) {
      setState(() {
        _isAuthNickName = false;
        _nickNameError = '닉네임을 입력해주세요!';
      });
      return false;
    } else if (!(_userNickNameController.text.length > 3 &&
        _userNickNameController.text.length <= 20)) {
      setState(() {
        _isAuthNickName = false;
        _nickNameError = '길이가 4글자 이상 20글자 이하로 맞춰야 합니다!';
      });
      return false;
    } else if (!nickNameRegex.hasMatch(value)) {
      setState(() {
        _isAuthNickName = false;
        _nickNameError = '유효하지 않은 닉네임입니다!';
      });
      return false;
    }
    setState(() {
      _nickNameHelper = null;
      _nickNameError = null;
      _isAuthNickName = false;
      _onChangeAllText();
    });
    return true;
  }

  @override
  void dispose() {
    _mobileController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  // void _openDatePicker(BuildContext context) {
  //   BottomPicker.date(
  //     title: "생년월일을 입력해주세요.",
  //     dateOrder: DatePickerDateOrder.ymd,
  //     pickerTextStyle: const TextStyle(
  //       color: Colors.black,
  //       fontSize: 14,
  //     ),
  //     titleStyle: const TextStyle(
  //       color: Colors.black,
  //       fontSize: 15.0,
  //     ),
  //     onSubmit: (value) {
  //       setState(() {
  //         _selectedDate = value;
  //       });
  //     },
  //     bottomPickerTheme: BottomPickerTheme.plumPlate,
  //   ).show(context);
  // }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _newUserBirthDate) {
      setState(() {
        _newUserBirthDate = picked;
      });
      print(
          '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}');
    }
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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                // TextFormField(
                //   initialValue: userDatas[0]['userName'],
                //   onChanged: (value) {
                //     setState(() {
                //       _newUserName = value;
                //     });
                //   },
                //   decoration: InputDecoration(
                //     labelText: "이름",
                //   ),
                // ),
                _title(title: "이메일"),
                SWAGTextField(
                  hintText: "이메일을 입력하세요",
                  maxLine: 1,
                  controller: _emailController,
                  onChanged: (value) {
                    setState(() {
                      _newUserEmail = value!;
                    });
                  },
                ),
                Gaps.v12,
                _title(title: "이름"),
                SWAGTextField(
                  hintText: "이름을 입력하세요",
                  maxLine: 1,
                  controller: _userNameController,
                  onChanged: (value) {
                    setState(() {
                      _newUserName = value!;
                    });
                  },
                ),
                Gaps.v12,
                _title(title: "인사말"),
                SWAGTextField(
                  hintText: "인사말을 간단하게 입력하세요",
                  maxLine: 1,
                  controller: _userDefController,
                  onChanged: (value) {
                    setState(() {
                      _newUserDef = value!;
                    });
                  },
                ),
                Gaps.v12,
                _title(title: "닉네임(SNS)"),
                SWAGTextField(
                  hintText: "SNS에서 사용할 닉네임",
                  maxLine: 1,
                  controller: _userNickNameController,
                  onChanged: _onChangeNickName,
                  buttonText: "중복확인",
                  errorText: _nickNameError,
                  onSubmitted: _onCheckNickName,
                  helperText: _nickNameHelper,
                ),
                //  _title(title: "비밀번호"),
                // SWAGTextField(
                //   hintText: "비밀번호를 입력하세요",
                //   maxLine: 1,
                //   controller: _userPwController,
                //   isPassword: true,
                //   onSubmitted: () {
                //     context.pushNamed(
                //         ChangeUserPw.routeName,
                //         extra: ChangeUserPwArgs(
                //           userPw: _newUserPw,
                //         ),
                //       );
                //   },
                // ),
                Gaps.v12,
                // TextFormField(
                //   initialValue: userDatas[0]['userPw'],
                //   obscureText: true,
                //   onChanged: (value) {
                //     setState(() {
                //       _newUserPw = value;
                //     });
                //   },
                //   decoration: InputDecoration(
                //     labelText: "비밀번호",
                //     suffixIcon: IconButton(
                //       onPressed: () {
                //         context.pushNamed(
                //           ChangeUserPw.routeName,
                //           extra: ChangeUserPwArgs(
                //             userPw: _newUserPw,
                //           ),
                //         );
                //       },
                //       icon: Icon(
                //         Icons.chevron_right_rounded,
                //         size: Sizes.size24,
                //       ),
                //     ),
                //   ),
                // ),
                _title(title: "성별"),
                SWAGTextField(
                  hintText: "성별을 입력하세요",
                  maxLine: 1,
                  controller: _userGenderController,
                  onChanged: (value) {
                    setState(() {
                      _newUserGender = value!;
                    });
                  },
                ),
                Gaps.v12,
                _title(title: "생년월일"),
                InkWell(
                  onTap: () {
                    _selectDate(context);
                  },
                  child: InputDecorator(
                    decoration: InputDecoration(
                      hintText: 'YYYY-MM-DD',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          width: 1,
                          color: Color(0xFFDBDBDB),
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 14,
                      ),
                    ),
                    child: Text(
                      _newUserBirthDate != null
                          ? '${_newUserBirthDate!.year}-${_newUserBirthDate!.month.toString().padLeft(2, '0')}-${_newUserBirthDate!.day.toString().padLeft(2, '0')}'
                          : '선택하지 않음',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                Gaps.v12,
                _title(title: "전화번호"),
                SWAGTextField(
                  hintText: "전화번호를 입력하세요",
                  maxLine: 1,
                  controller: _userPhoneNumberController,
                  onChanged: (value) {
                    setState(() {
                      _newUserPhoneNumber = value!;
                    });
                  },
                  onSubmitted: () {
                    context.pushNamed(
                      ChangePhoneNum.routeName,
                      extra: ChangePhoneNumArgs(
                        userPhoneNumber: _newUserPhoneNumber,
                      ),
                    );
                  },
                ),
                Gaps.v12,
                _title(title: "사용자 구분"),
                SWAGTextField(
                  hintText: "사용자 유형을 선택하세요",
                  maxLine: 1,
                  controller: _userTypeController,
                  onChanged: (value) {
                    setState(() {
                      _newUserType = value!;
                    });
                  },
                ),
                Gaps.v20,

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
      ),
    );
  }
}
