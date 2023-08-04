import 'package:flutter/material.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/features/user_profile/view/user_profile_screen.dart';
import 'package:swag_cross_app/features/widget_tools/swag_textfield.dart';

class ChangeUserPwArgs {
  final String userPw;

  ChangeUserPwArgs({
    required this.userPw,
  });
}

class ChangeUserPw extends StatefulWidget {
  static const routeName = "user_pw";
  static const routeURL = "/user_pw";

  final String userPw;

  const ChangeUserPw({
    super.key,
    required this.userPw,
  });

  @override
  State<ChangeUserPw> createState() => _ChangeUserPwState();
}

class _ChangeUserPwState extends State<ChangeUserPw> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _pwConfirmController = TextEditingController();

  bool _isEditFinished = false;
  String? _idError;
  String? _pwError;
  String? _pwConfirmError;

  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController(text: widget.userPw);
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

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
    _isEditFinished =
        (_idError == null && _idController.text.trim().isNotEmpty) &&
            (_idError == null && _idController.text.trim().isNotEmpty) &&
            (_pwError == null && _pwController.text.trim().isNotEmpty) &&
            _pwController.text == _pwConfirmController.text;
    setState(() {});
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

  Future<void> _showAlertDialog() async {
    // 비밀번호 수정여부 모달창
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('비밀번호 수정'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('비밀번호를 수정하시겠습니까?'),
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
        title: const Text("비밀번호 변경"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TextFormField(
            //   initialValue: userDatas[0]['userPw'],
            //   obscureText: false,
            //   decoration: InputDecoration(
            //     labelText: "기존 비밀번호",
            //   ),
            // ),
            // TextFormField(
            //   controller: _passwordController,
            //   obscureText: true,
            //   decoration: InputDecoration(
            //     labelText: "새 비밀번호",
            //   ),
            // ),
            // TextFormField(
            //   controller: _passwordController,
            //   obscureText: true,
            //   decoration: InputDecoration(
            //     labelText: "비밀번호 확인",
            //   ),
            // ),
           _title(title: "기존 비밀번호"),
            SWAGTextField(
              hintText: userDatas[0]['userPw'],
              maxLine: 1,
              controller: _pwController,
              isPassword: true,
              onChanged: _onChangePw,
              errorText: _pwError,
            ),
            Gaps.v20,
            _title(title: "새 비밀번호"),
            SWAGTextField(
              hintText: "비밀번호를 입력해주세요.",
              maxLine: 1,
              controller: _pwController,
              isPassword: true,
              onChanged: _onChangePw,
              errorText: _pwError,
            ),
            Gaps.v20,
            _title(title: "비밀번호 확인"),
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
            ElevatedButton(
              onPressed: () {
                // 새로운 비밀번호 저장 및 처리 로직 추가
                final newPassword = _passwordController.text;
                _showAlertDialog();
                // (비밀번호 변경 로직 처리)
              },
              child: const Text("비밀번호 변경"),
            ),
          ],
        ),
      ),
    );
  }
}
