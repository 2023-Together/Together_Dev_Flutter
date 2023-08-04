import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:go_router/go_router.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/widget_tools/swag_platform_dialog.dart';
import 'package:swag_cross_app/features/widget_tools/swag_state_dropDown_button.dart';
import 'package:swag_cross_app/features/widget_tools/swag_textfield.dart';

import 'package:http/http.dart' as http;

class SignUpFormScreen extends StatefulWidget {
  static const routeName = "sign_up";
  static const routeURL = "/sign_up";
  const SignUpFormScreen({super.key});

  @override
  State<SignUpFormScreen> createState() => _SignUpFormScreenState();
}

class _SignUpFormScreenState extends State<SignUpFormScreen> {
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _mobileCheckController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _nickNameController = TextEditingController();

  bool _isEditFinished = false;
  bool _isAuthMobile = false;
  bool _isAuthNickName = false;

  String? _mobileAuthCode;

  String _gender = "";
  DateTime? _birthday = DateTime.now();
  String _email = "";
  String? _nameError;
  String? _mobileError;
  String? _mobileHelper;

  @override
  void initState() {
    super.initState();

    _onChangeAllText();
  }

  void _callNaverProfile() async {
    // 사용횟수가 정해져 있어서 테스트할때 주석을 풀어야함
    final NaverLoginResult result = await FlutterNaverLogin.logIn();

    if (!mounted) return;
    if (result.status == NaverLoginStatus.loggedIn) {
      final userData = result.account;
      print(userData);

      _nameController.text = userData.name;
      _nameError == null;
      _gender = userData.gender == "M" ? "남" : "여";
      final birthday = userData.birthday.split("-");
      _birthday = DateTime(
        int.parse(userData.birthyear),
        int.parse(birthday[0]),
        int.parse(birthday[1]),
      );
      _email = userData.email;
      if (!_isAuthMobile) {
        _mobileController.text = userData.mobile.replaceAll(RegExp(r'-'), '');
        _mobileError = null;
      }
      _onChangeAllText();

      setState(() {});
    } else {
      swagPlatformDialog(
        context: context,
        title: "오류!",
        message: result.errorMessage,
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text("알겠습니다"),
          ),
        ],
      );
    }
  }

  void _onDataCheckSubmitted() {
    swagPlatformDialog(
      context: context,
      title: "주의!",
      message:
          "이후에 개인정보를 수정하려면 NAVER에서 정보를 수정하고 다시 요청해야 합니다!\n이정보가 당신의 정보가 맞습니까?",
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: const Text("아니오"),
        ),
        TextButton(
          onPressed: () => context.pushNamed(
            SignUpIdPwScreen.routeName,
            extra: SignUpIdPwScreenArgs(
              name: _name,
              email: _email,
              gender: _gender,
              birthday: _birthday,
              mobile: _mobileController.text,
            ),
          ),
          child: const Text("예"),
        ),
      ],
    );
  }

  void _onChangeAllText() {
    _isEditFinished = _name.trim().isNotEmpty &&
        _gender.trim().isNotEmpty &&
        _birthday.trim().isNotEmpty &&
        _email.trim().isNotEmpty &&
        (_mobileError == null && _mobileController.text.trim().isNotEmpty);
    setState(() {});
  }

  void _onSignUpSubmitted() async {
    final url = Uri.parse("http://59.4.3.198:80/together/register");
    final headers = {'Content-Type': 'application/json'};
    final data = {
      "userEmail": _email,
      "userPhonenumber": _mobileController.text,
      "userName": _nameController.text,
      "userNickname": _nickNameController.text,
      "userGender": _gender == "남" ? 0 : 1,
      "userBirthdate":
          '${_birthday?.year}-${_birthday?.month.toString().padLeft(2, '0')}-${_birthday?.day.toString().padLeft(2, '0')}',
      "userType": "user",
      "userDef": "",
    };

    final response =
        await http.post(url, headers: headers, body: jsonEncode(data));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (!mounted) return;
      context.pop();
    } else {
      print("회원가입 에러!");
      print(response.statusCode);
      print(response.body);
    }
  }

  Future<void> _onCheckNickName() async {
    final url = Uri.parse("http://59.4.3.198:80/together/selectByUserNickname");
    final data = {
      "userNickname": _nickNameController.text,
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

    // setState(() {
    //   _isAuthNickName = true;
    //   _nickNameHelper = "인증이 완료되었습니다!";
    //   _onChangeAllText();
    // });
  }

  Future<void> _callMobileCheckCode() async {
    _mobileCheckError = null;
    final url = Uri.parse("http://59.4.3.198:80/together/sendMessage");
    final data = {
      "userPhonenumber": _mobileController.text,
    };

    final response = await http.post(url, body: data);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final result = int.parse(response.body);
      if (result == 1) {
        setState(() {
          _mobileError = "다른 계정에 등록된 전화번호 입니다!";
        });
      } else {
        print(result);
        setState(() {
          _mobileAuthCode = response.body;
        });
      }
    } else {
      setState(() {
        _mobileError = "통신 실패!";
      });
      print(response.statusCode);
      print(response.body);
    }
  }

  Future<void> _callAuthMobile() async {
    final url = Uri.parse("http://59.4.3.198:80/together/isCurrectNum");
    final data = {
      "sendNum": _mobileCheckController.text,
      "getNum": _mobileAuthCode,
    };

    final response = await http.post(url, body: data);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final result = int.parse(response.body);
      if (result == 0) {
        setState(() {
          _isAuthMobile = true;
          _mobileHelper = "인증이 완료되었습니다!";
          _onChangeAllText();
        });
      } else {
        setState(() {
          _mobileCheckError = "인증에 실패했습니다. 다시 시도해 주세요!";
        });
      }
    } else {
      setState(() {
        _mobileCheckError = "통신 실패!";
      });
    }

    // setState(() {
    //   _isAuthMobile = true;
    //   _mobileHelper = "인증이 완료되었습니다!";
    //   _onChangeAllText();
    // });
  }

  bool _onChangeMobile(String? value) {
    if (value == null) return false;
    // 비밀번호 정규식 패턴
    RegExp mobileRegex = RegExp(r'^010-?([0-9]{4})-?([0-9]{4})$');
    if (value.isEmpty) {
      setState(() {
        _mobileError = '전화번호는 필수입니다!';
      });
      return false;
    } else if (!mobileRegex.hasMatch(value)) {
      setState(() {
        _isAuthMobile = false;
        _mobileHelper = null;
        _mobileError = '전화번호 양식에 맞게 입력해주세요.';
      });
      return false;
    }
    setState(() {
      _mobileHelper = null;
      _mobileError = null;
      _isAuthMobile = false;
      _onChangeAllText();
    });

    return true;
  }

  bool _onChangeName(String? value) {
    if (value == null) return false;
    // 비밀번호 정규식 패턴
    RegExp nameRegex = RegExp(
        r'^[\uAC00-\uD7AF\u1100-\u11FF\u3130-\u318F\uA960-\uA97F\uAC00-\uD7A3a-zA-Z]+$');
    if (value.isEmpty) {
      setState(() {
        _nameError = '실명을 입력해 주세요!';
      });
      return false;
    } else if (!nameRegex.hasMatch(value)) {
      setState(() {
        _nameError = '이름양식에 맞지 않습니다!';
      });
      return false;
    }
    setState(() {
      _nameError = null;
      _onChangeAllText();
    });

    return true;
  }

  bool _onChangeName(String? value) {
    if (value == null) return false;
    // 비밀번호 정규식 패턴
    RegExp nameRegex = RegExp(
        r'^[\uAC00-\uD7AF\u1100-\u11FF\u3130-\u318F\uA960-\uA97F\uAC00-\uD7A3a-zA-Z]+$');
    if (value.isEmpty) {
      setState(() {
        _nameError = '실명을 입력해 주세요!';
      });
      return false;
    } else if (!nameRegex.hasMatch(value)) {
      setState(() {
        _nameError = '이름양식에 맞지 않습니다!';
      });
      return false;
    }
    setState(() {
      _nameError = null;
      _onChangeAllText();
    });

    return true;
  }

  bool _onChangeNickName(String? value) {
    if (value == null) return false;
    // 닉네임 정규식 패턴
    RegExp nickNameRegex = RegExp(
        r"^(?!^\d)(?=^.{3,20}$)[a-zA-Z0-9_-\uAC00-\uD7AF\u1100-\u11FF\u3130-\u318F\uA960-\uA97F\uAC00-\uD7A3]+$");
    if (value.isEmpty) {
      setState(() {
        _nickNameError = '닉네임을 입력해주세요!';
      });
      return false;
    } else if (!(_nickNameController.text.length > 3 &&
        _nickNameController.text.length <= 20)) {
      setState(() {
        _nickNameError = '길이가 4글자 이상 20글자 이하로 맞춰야 합니다!';
      });
      return false;
    } else if (!nickNameRegex.hasMatch(value)) {
      setState(() {
        _nickNameError = '유효하지 않은 닉네임입니다!';
      });
      return false;
    }
    setState(() {
      _nickNameError = null;
      _onChangeAllText();
    });
    return true;
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
    } else if (!(_nickNameController.text.length > 3 &&
        _nickNameController.text.length <= 20)) {
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _birthday) {
      setState(() {
        _birthday = picked;
      });
      print(
          '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}');
    }
  }

  @override
  void dispose() {
    _mobileController.dispose();
    _mobileCheckController.dispose();
    _nameController.dispose();
    _nickNameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text("회원가입(개인정보)"),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.size16,
            horizontal: Sizes.size10,
          ),
          child: ElevatedButton(
            onPressed:
                _isEditFinished && _isAuthMobile ? _onDataCheckSubmitted : null,
            child: const Padding(
              padding: EdgeInsets.symmetric(
                vertical: Sizes.size16,
              ),
              child: Text("회원가입"),
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v20,
              UserDataBox(
                name: "이름",
                data: _name,
              ),
              UserDataBox(
                name: "성별",
                data: _gender,
              ),
              UserDataBox(
                name: "생년월일",
                data: _birthday,
              ),
              UserDataBox(
                name: "이메일",
                data: _email,
              ),
              Gaps.v10,
              Text(
                "주의사항 : 현재의 데이터 중에서 틀린 부분이 있으면 네이버계정 정보를 수정후 다시 회원가입을 시도하시기 바랍니다!",
                style: Theme.of(context).textTheme.labelMedium,
              ),
              Gaps.v20,
              GestureDetector(
                onTap: _callNaverProfile,
                child: FractionallySizedBox(
                  widthFactor: 1,
                  child: Column(
                    children: [
                      Container(
                        height: Sizes.size64,
                        // Container 안에 있는 padding의 타입은 EdgeInsets 이다.
                        padding: const EdgeInsets.all(Sizes.size14),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: Sizes.size1,
                          ),
                        ),
                        // Column : 위젯을 세로로 차례대로 배치
                        // Row : 위젯을 가로로 차례대로 배치
                        // Stack : 위젯을 위에다가 겹쳐서 배치(레이어 같은 개념)
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Image.asset(
                                'assets/images/naver.png',
                                width: Sizes.size40,
                              ),
                            ),
                            const Text(
                              "네이버정보 가져오기",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: Sizes.size18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Gaps.v28,
              SWAGTextField(
                hintText: "전화번호",
                maxLine: 1,
                controller: _mobileController,
                errorText: _mobileError,
                helperText: _mobileHelper,
                buttonText: "인증번호 요청",
                onSubmitted: _callMobileCheckCode,
                onChanged: _onChangeMobile,
                keyboardType: TextInputType.phone,
              ),
              Gaps.v10,
              SWAGTextField(
                hintText: "인증번호",
                maxLine: 1,
                controller: _mobileCheckController,
                buttonText: "인증하기",
                onSubmitted: _callAuthMobile,
                keyboardType: TextInputType.number,
              ),
              Gaps.v10,
              Text(
                "주의사항 : 하나의 핸드폰 번호를 여러개의 계정에 중복으로 등록할 수 없습니다!",
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserDataBox extends StatelessWidget {
  const UserDataBox({
    super.key,
    required this.data,
    required this.name,
    required this.hint,
  });

  final String name;
  final String data;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Sizes.size5),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              name,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          Gaps.h10,
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 14,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  width: 1,
                  color: const Color(0xFFDBDBDB),
                ),
              ),
              child: Text(
                data.trim().isEmpty ? hint : data,
                style: data.trim().isEmpty
                    ? Theme.of(context).textTheme.labelLarge
                    : Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}