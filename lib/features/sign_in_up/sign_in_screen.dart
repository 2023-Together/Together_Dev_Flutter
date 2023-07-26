import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/main_navigation/mian_navigation.dart';
import 'package:swag_cross_app/features/sign_in_up/enums/login_platform.dart';
import 'package:swag_cross_app/features/sign_in_up/sign_up_form_screen.dart';
import 'package:swag_cross_app/features/sign_in_up/widgets/auth_button.dart';
import 'package:swag_cross_app/features/widget_tools/swag_platform_dialog.dart';
import 'package:swag_cross_app/providers/UserProvider.dart';
import 'package:swag_cross_app/storages/login_storage.dart';

class SignInScreen extends StatefulWidget {
  static const routeName = "login";
  static const routeURL = "/login";
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  bool _onSaveCheck = false;
  bool _isEditFinished = false;

  late Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();

    _checkAutoLogined();
  }

  void _checkAutoLogined() async {
    final String? loginData = await LoginStorage.getLoginData();
    print(loginData);

    if (loginData == null) return;
    if (loginData.trim().isNotEmpty) {
      List<String> userData = loginData.split(",");

      // final id = userData[0];
      // final pw = userData[1];

      if (!mounted) return;
      context.read<UserProvider>().login("naver");

      context.goNamed(MainNavigation.routeName);
    }
  }

  void _onChangeAllText(String? value) {
    if (value == null) return;
    _isEditFinished = _idController.text.trim().isNotEmpty &&
        _pwController.text.trim().isNotEmpty;
    setState(() {});
  }

  void _onChangeUserSaveCheck(bool? value) {
    if (value != null) {
      setState(() {
        _onSaveCheck = value;
      });
    }
  }

  void _onSignUpTap() {
    // context.pushNamed(SignUpFormScreen.routeName);
    swagPlatformDialog(
      context: context,
      title: "주의",
      message:
          "이 앱은 NAVER 계정을 가져옴으로써 본인 인증을 진행합니다!\nNAVER 계정이 존재하지 않는분은 회원가입을 진행할 수 없습니다!",
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: const Text("아니오"),
        ),
        TextButton(
          onPressed: () {
            context.pop();
            context.pushNamed(SignUpFormScreen.routeName);
          },
          child: const Text("예"),
        ),
      ],
    );
  }

  void _onSignInSubmitted() async {
    if (_onSaveCheck) {
      LoginStorage.saveLoginData(
        id: _idController.text.trim(),
        pw: _pwController.text.trim(),
      );
      context.read<UserProvider>().login("naver");

      context.goNamed(MainNavigation.routeName);
    } else {
      context.read<UserProvider>().login("naver");

      context.goNamed(MainNavigation.routeName);
    }
  }

  @override
  void dispose() {
    _idController.dispose();
    _pwController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print(SecureStorageLogin.getLoginType());
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    "Together(로고)",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
              ),
              // Expanded(
              //   flex: 3,
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text(
              //         "아이디",
              //         style: Theme.of(context).textTheme.titleMedium,
              //       ),
              //       Gaps.v10,
              //       SWAGTextField(
              //         hintText: "아이디를 입력해주세요.",
              //         maxLine: 1,
              //         controller: _idController,
              //         onChanged: _onChangeAllText,
              //       ),
              //       Gaps.v20,
              //       Text(
              //         "비밀번호",
              //         style: Theme.of(context).textTheme.titleMedium,
              //       ),
              //       Gaps.v10,
              //       SWAGTextField(
              //         hintText: "비밀번호를 입력해주세요.",
              //         maxLine: 1,
              //         controller: _pwController,
              //         onChanged: _onChangeAllText,
              //         isPassword: true,
              //       ),
              //       Gaps.v20,
              //       Row(
              //         children: [
              //           Transform.scale(
              //             scale: 1.25,
              //             child: Checkbox.adaptive(
              //               shape: const CircleBorder(),
              //               value: _onSaveCheck,
              //               onChanged: _onChangeUserSaveCheck,
              //             ),
              //           ),
              //           GestureDetector(
              //             onTap: () => _onChangeUserSaveCheck(!_onSaveCheck),
              //             child: const Text("자동 로그인"),
              //           ),
              //         ],
              //       ),
              //       Container(
              //         width: MediaQuery.of(context).size.width,
              //         padding: const EdgeInsets.all(Sizes.size10),
              //         margin: const EdgeInsets.only(top: Sizes.size10),
              //         child: ElevatedButton(
              //           onPressed: _isEditFinished ? _onSignInSubmitted : null,
              //           child: const Padding(
              //             padding: EdgeInsets.symmetric(vertical: Sizes.size16),
              //             child: Text("로그인"),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              const Expanded(
                flex: 1,
                child: AuthButton(
                  path: "naver",
                  text: "네이버 로그인",
                  signType: SNSType.naver,
                  authType: SignType.signIn,
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(
            bottom: Sizes.size28,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "계정이 없으신가요?",
                style: TextStyle(
                  fontSize: Sizes.size18,
                ),
              ),
              Gaps.h10,
              GestureDetector(
                onTap: _onSignUpTap,
                child: const Text(
                  "회원가입",
                  style: TextStyle(
                    fontSize: Sizes.size18,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
