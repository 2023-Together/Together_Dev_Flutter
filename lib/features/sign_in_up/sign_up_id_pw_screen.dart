import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/widget_tools/swag_textfield.dart';

class SignUpIdPwScreenArgs {
  final String name;
  final String email;
  final String gender;
  final String birthday;
  final String mobile;

  SignUpIdPwScreenArgs({
    required this.name,
    required this.email,
    required this.gender,
    required this.birthday,
    required this.mobile,
  });
}

class SignUpIdPwScreen extends StatefulWidget {
  static const routeName = "signup_id_pw";
  static const routeURL = "signup_id_pw";
  const SignUpIdPwScreen({
    super.key,
    required this.name,
    required this.email,
    required this.gender,
    required this.birthday,
    required this.mobile,
  });

  final String name;
  final String email;
  final String gender;
  final String birthday;
  final String mobile;

  @override
  State<SignUpIdPwScreen> createState() => _SignUpIdPwScreenState();
}

class _SignUpIdPwScreenState extends State<SignUpIdPwScreen> {
  final TextEditingController _nickNameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _pwConfirmController = TextEditingController();

  bool _isEditFinished = false;
  final bool _isNickNameAuth = false;
  final bool _isIdAuth = false;
  String? _nickNameError;
  String? _idError;
  String? _pwError;
  String? _pwConfirmError;

  void _onChangeAllText() {
    _isEditFinished =
        (_idError == null && _idController.text.trim().isNotEmpty) &&
            (_idError == null && _idController.text.trim().isNotEmpty) &&
            (_pwError == null && _pwController.text.trim().isNotEmpty) &&
            _pwController.text == _pwConfirmController.text;
    setState(() {});
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

  bool _onChangeId(String? value) {
    if (value == null) return false;
    // 닉네임 정규식 패턴
    RegExp idRegex = RegExp(r"^[a-z0-9]{4,12}$");
    if (value.isEmpty) {
      setState(() {
        _idError = '아이디를 입력해주세요!';
      });
      return false;
    } else if (!(_idController.text.length > 3 &&
        _idController.text.length <= 20)) {
      setState(() {
        _idError = '길이가 4글자 이상 20글자 이하로 맞춰야 합니다!';
      });
      return false;
    } else if (!idRegex.hasMatch(value)) {
      setState(() {
        _idError = '유효하지 않은 id 입니다!';
      });
      return false;
    }
    setState(() {
      _idError = null;
      _onChangeAllText();
    });
    return true;
  }

  bool _onChangePw(String? value) {
    if (value == null) return false;
    // 비밀번호 정규식 패턴
    RegExp emailRegex = RegExp(
        r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$");
    if (value.isEmpty) {
      setState(() {
        _pwError = '비밀번호를 입력해주세요.';
      });
      return false;
    } else if (!emailRegex.hasMatch(value)) {
      setState(() {
        _pwError = '특수문자, 대소문자, 숫자 포함 8자 이상으로 입력하세요.';
      });
      return false;
    }
    setState(() {
      _pwError = null;
      _onChangeAllText();
    });
    return true;
  }

  bool _onChangePwConfirm(String? value) {
    if (value == null) return false;
    if (value.isEmpty) {
      setState(() {
        _pwConfirmError = '비밀번호 확인을 입력해주세요.';
      });
      return false;
    } else if (_pwController.text != _pwConfirmController.text) {
      setState(() {
        _pwConfirmError = "비밀번호와 일치하지 않습니다!";
      });
      return false;
    }
    setState(() {
      _pwConfirmError = null;
      _onChangeAllText();
    });
    return true;
  }

  void _onSignUpSubmitted() {
    context.pop();
    context.pop();
  }

  @override
  void dispose() {
    _idController.dispose();
    _pwController.dispose();
    _pwConfirmController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: BackButton(
            onPressed: () {
              context.pop();
            },
          ),
          title: const Text("회원가입(로그인정보)"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v10,
              Text(
                "닉네임(SNS)",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Gaps.v10,
              SWAGTextField(
                hintText: "SNS에서 사용할 닉네임을 입력해주세요.",
                maxLine: 1,
                controller: _nickNameController,
                onChanged: _onChangeNickName,
                buttonText: "중복확인",
                errorText: _nickNameError,
              ),
              Gaps.v20,
              Text(
                "아이디",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Gaps.v10,
              SWAGTextField(
                hintText: "아이디를 입력해주세요.",
                maxLine: 1,
                controller: _idController,
                onChanged: _onChangeId,
                buttonText: "중복확인",
                errorText: _idError,
              ),
              Gaps.v20,
              Text(
                "비밀번호",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Gaps.v10,
              SWAGTextField(
                hintText: "비밀번호를 입력해주세요.",
                maxLine: 1,
                controller: _pwController,
                isPassword: true,
                onChanged: _onChangePw,
                errorText: _pwError,
              ),
              Gaps.v20,
              Text(
                "비밀번호 확인",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Gaps.v10,
              SWAGTextField(
                hintText: "비밀번호를 다시 입력해주세요.",
                maxLine: 1,
                controller: _pwConfirmController,
                isPassword: true,
                onChanged: _onChangePwConfirm,
                errorText: _pwConfirmError,
              ),
              Gaps.v20,
            ],
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(Sizes.size10),
          child: ElevatedButton(
            // onPressed: _isEditFinished ? _onSignUpSubmitted : null,
            onPressed: _onSignUpSubmitted,
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: Sizes.size16),
              child: Text("회원가입"),
            ),
          ),
        ),
      ),
    );
  }
}
