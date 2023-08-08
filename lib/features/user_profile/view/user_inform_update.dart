import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/widget_tools/swag_platform_dialog.dart';
import 'package:swag_cross_app/features/widget_tools/swag_state_dropDown_button.dart';
import 'package:swag_cross_app/features/widget_tools/swag_textfield.dart';

import 'package:http/http.dart' as http;
import 'package:swag_cross_app/models/DBModels/user_model.dart';
import 'package:swag_cross_app/providers/user_provider.dart';

class UserInformUpdate extends StatefulWidget {
  static const routeName = "user_inform_update";
  static const routeURL = "/user_inform_update";

  const UserInformUpdate({
    Key? key,
  }) : super(key: key);

  @override
  State<UserInformUpdate> createState() => _UserInformUpdateState();
}

class _UserInformUpdateState extends State<UserInformUpdate> {
  late UserModel? userData;

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
  String? _mobileCheckError;
  String? _nickNameError;
  String? _nickNameHelper;

  final List<String> _genderCategory = ["", "남", "여"];

  @override
  void initState() {
    super.initState();

    userData = context.read<UserProvider>().userData;

    _nickNameController.text = userData!.userNickname;
    _isAuthNickName = true;
    _nickNameHelper = "인증이 완료되었습니다!";
    _nameController.text = userData!.userName;
    _birthday = userData!.userBirthdate;
    _gender = userData!.userGender == 0 ? "남" : "여";
    _mobileController.text = userData!.userPhoneNumber;
    _isAuthMobile = true;
    _mobileHelper = "인증이 완료되었습니다!";
    _email = userData!.userEmail;

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

  void _onChangeAllText() {
    _isEditFinished =
        (_nameError == null && _nameController.text.trim().isNotEmpty) &&
            _gender.trim().isNotEmpty &&
            _birthday != null &&
            _email.trim().isNotEmpty &&
            _isAuthMobile;
    setState(() {});
  }

  void _onUpdateSubmitted() async {
    final userData = context.read<UserProvider>().userData;

    final url = Uri.parse("http://59.4.3.198:80/together/update");
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
    };

    final response =
        await http.post(url, headers: headers, body: jsonEncode(data));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final UserModel updateData = UserModel(
        userId: userData!.userId,
        userEmail: _email,
        userPhoneNumber: _mobileController.text,
        userName: _nameController.text,
        userNickname: _nickNameController.text,
        userGender: _gender == "남" ? 0 : 1,
        userBirthdate: _birthday!,
        userType: userData.userType,
      );
      if (!mounted) return;
      context.read<UserProvider>().updateUserData(updateData);
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
      setState(() {
        _isAuthNickName = true;
        _nickNameHelper = "인증이 완료되었습니다!";
        _onChangeAllText();
      });
    } else {
      _nickNameError = "중복된 닉네임이 존재합니다!";
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

    // setState(() {
    //   _isAuthMobile = true;
    //   _mobileHelper = "인증이 완료되었습니다!";
    //   _onChangeAllText();
    // });
  }

  bool _onChangeMobile(String? value) {
    if (value == null) return false;
    // 전화번호 정규식 패턴
    RegExp mobileRegex = RegExp(r'^010([0-9]{4})([0-9]{4})$');
    if (value.isEmpty) {
      setState(() {
        _isAuthMobile = false;
        _mobileHelper = null;
        _mobileError = '전화번호를 입력해 주세요!';
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

  void _onChangeGender(String value) {
    setState(() {
      _gender = value;
      _onChangeAllText();
    });
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
          title: const Text("내 정보 수정"),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.size16,
            horizontal: Sizes.size10,
          ),
          child: ElevatedButton(
            onPressed: _isEditFinished && _isAuthMobile && _isAuthNickName
                ? _onUpdateSubmitted
                : null,
            child: const Padding(
              padding: EdgeInsets.symmetric(
                vertical: Sizes.size16,
              ),
              child: Text("수정완료"),
            ),
          ),
        ),
        body: Scrollbar(
          thumbVisibility: true,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                              color: Colors.grey.shade400,
                              width: 1,
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
                Gaps.v20,
                UserDataBox(
                  name: "이메일",
                  data: _email,
                  hint: "네이버에서 정보를 가져와주세요!",
                ),
                Text(
                  "＃ 이메일을 통해 SNS 로그인이 진행되어 임의로 변경을 할 수 없습니다!",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                Gaps.v10,
                Text(
                  "닉네임(SNS)",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Gaps.v6,
                SWAGTextField(
                  hintText: "SNS에서 사용할 닉네임",
                  maxLine: 1,
                  controller: _nickNameController,
                  onChanged: _onChangeNickName,
                  buttonText: "중복확인",
                  errorText: _nickNameError,
                  onSubmitted: _onCheckNickName,
                  helperText: _nickNameHelper,
                ),
                Gaps.v10,
                Text(
                  "이름(실명)",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Gaps.v6,
                SWAGTextField(
                  hintText: "봉사 신청 기능에 사용될 실명",
                  maxLine: 1,
                  controller: _nameController,
                  errorText: _nameError,
                  onChanged: _onChangeName,
                ),
                Gaps.v10,
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        "생년월일",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                    Gaps.h10,
                    Expanded(
                      flex: 3,
                      child: InkWell(
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
                            _birthday != null
                                ? '${_birthday!.year}-${_birthday!.month.toString().padLeft(2, '0')}-${_birthday!.day.toString().padLeft(2, '0')}'
                                : '선택하지 않음',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Gaps.v20,
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        "성별",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                    Gaps.h10,
                    Expanded(
                      flex: 3,
                      child: SWAGStateDropDownButton(
                        initOption: _gender,
                        onChangeOption: _onChangeGender,
                        title: "성별",
                        options: _genderCategory,
                      ),
                    ),
                  ],
                ),
                Gaps.v6,
                Text(
                  "＃ 봉사를 신청했을때 해당 개인 정보로 기관에 데이터가 전달되기 때문에 꼭 본인의 정보를 정확하게 기입하셔야 합니다!",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                Gaps.v20,
                Text(
                  "전화번호",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Gaps.v6,
                SWAGTextField(
                  hintText: "'-'없이 입력해주세요.",
                  maxLine: 1,
                  controller: _mobileController,
                  errorText: _mobileError,
                  helperText: _mobileHelper,
                  buttonText: "인증번호 요청",
                  onSubmitted: _callMobileCheckCode,
                  onChanged: _onChangeMobile,
                  keyboardType: TextInputType.number,
                ),
                Gaps.v10,
                SWAGTextField(
                  hintText: "인증번호",
                  maxLine: 1,
                  controller: _mobileCheckController,
                  buttonText: "인증하기",
                  onSubmitted: _callAuthMobile,
                  keyboardType: TextInputType.number,
                  errorText: _mobileCheckError,
                ),
                Gaps.v10,
                Text(
                  "＃ 하나의 핸드폰 번호를 여러개의 계정에 중복으로 등록할 수 없습니다!",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
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
