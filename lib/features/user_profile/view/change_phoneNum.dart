import 'package:flutter/material.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/features/user_profile/view/user_profile_screen.dart';
import 'package:swag_cross_app/features/widget_tools/swag_textfield.dart';

class ChangePhoneNumArgs {
  final String userPhoneNumber;

  ChangePhoneNumArgs({
    required this.userPhoneNumber,
  });
}

class ChangePhoneNum extends StatefulWidget {
  static const routeName = "user_phoneNum";
  static const routeURL = "/user_phoneNum";

  final String userPhoneNumber;

  const ChangePhoneNum({
    super.key,
    required this.userPhoneNumber,
  });

  @override
  State<ChangePhoneNum> createState() => _ChangePhoneNumState();
}

class _ChangePhoneNumState extends State<ChangePhoneNum> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _pwConfirmController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _mobileCheckController = TextEditingController();

  bool _isEditFinished = false;
  String? _idError;
  String? _pwError;
  String? _pwConfirmError;
  String? _mobileError;
  String? _mobileHelper;
  bool _isAuthMobile = false;

  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _onChangeAllText();
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

  bool _onChangeMobile(String? value) {
    if (value == null) return false;
    // 전화번호 정규식 패턴
    RegExp mobileRegex = RegExp(r'^010-?([0-9]{4})-?([0-9]{4})$');
    if (value.isEmpty) {
      setState(() {
        _mobileError = '전화번호는 필수입니다!';
      });
      return false;
    } else if (!mobileRegex.hasMatch(value)) {
      setState(() {
        _mobileError = '전화번호 양식에 맞게 입력해주세요.';
      });
      return false;
    }
    _mobileController.text.replaceAllMapped(
        RegExp(r'(\d{3})(\d{3,4})(\d{4})'), (m) => '${m[1]}-${m[2]}-${m[3]}');
    setState(() {
      _mobileError = null;
      _onChangeAllText();
    });

    return true;
  }

  void _callAuthMobile() {
    if (_mobileError == null) {
      setState(() {
        _isAuthMobile = true;
        _mobileError = null;
        _mobileHelper = "인증이 완료되었습니다!";
        _onChangeAllText();
      });
    }
  }

  void _callMobileCheckCode() {}

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
        title: const Text("전화번호 변경"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title(title: "전화번호"),
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
            Gaps.v20,
            SWAGTextField(
              hintText: "인증번호",
              maxLine: 1,
              controller: _mobileCheckController,
              buttonText: "인증하기",
              onSubmitted: _callAuthMobile,
              keyboardType: TextInputType.number,
            ),
            Gaps.v20,

            Text(
              "주의사항 : 하나의 핸드폰 번호를 여러개의 계정에 중복으로 등록할 수 없습니다!",
              style: Theme.of(context).textTheme.labelMedium,
            ),
            Gaps.v20,
            ElevatedButton(
              onPressed: () {
                // 새로운 비밀번호 저장 및 처리 로직 추가
                final newPassword = _passwordController.text;
                _showAlertDialog();
                // (비밀번호 변경 로직 처리)
              },
              child: const Text("전화번호 변경"),
            ),
          ],
        ),
      ),
    );
  }
}
