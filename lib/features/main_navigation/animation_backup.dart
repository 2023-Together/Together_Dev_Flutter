import 'package:flutter/material.dart';
import 'package:swag_cross_app/storages/secure_storage_login.dart';

class BackUpScreen extends StatefulWidget {
  const BackUpScreen({super.key});

  @override
  State<BackUpScreen> createState() => _BackUpScreenState();
}

class _BackUpScreenState extends State<BackUpScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 100),
  );

  late final Animation<double> _scaleAnimation = Tween(
    begin: 1.0,
    end: 1.2,
  ).animate(_animationController);

  late final Animation<double> _opacityAnimation = Tween(
    begin: 0.6,
    end: 1.0,
  ).animate(_animationController);

  late final Animation<Offset> _upDownAnimation = Tween(
    begin: Offset.zero,
    end: const Offset(0, -0.3),
  ).animate(_animationController);

  late int _selectedIndex;
  bool _isLogined = false;

  @override
  void initState() {
    super.initState();

    _selectedIndex = 2;

    if (_selectedIndex == 2) {
      _animationController.forward();
    }

    checkLoginType();
  }

  void _onTap(int index) {
    if (index == 2) {
      _animationController.forward();
      setState(() {
        _selectedIndex = index;
      });
    } else if (index == 4 && !_isLogined) {
      SecureStorageLogin.loginCheckIsNone(context, mounted);
    } else {
      _animationController.reverse();
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  // 로그인 타입을 가져와서 로그인 상태를 적용하는 함수
  void checkLoginType() async {
    var loginType = await SecureStorageLogin.getLoginType();
    print(loginType);
    if (loginType == "naver" || loginType == "kakao") {
      _isLogined = true;
    } else {
      _isLogined = false;
    }
    setState(() {});
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          // child: AnimatedOpacity(
          //   opacity: _selectedIndex == 2 ? 1 : 0.6,
          //   duration: const Duration(milliseconds: 150),
          //   child: ScaleTransition(
          //     scale: _scaleAnimation,
          //     child: FadeTransition(
          //       opacity: _opacityAnimation,
          //       child: SlideTransition(
          //         position: _upDownAnimation,
          //         child: Container(
          //           height: 60,
          //           padding: const EdgeInsets.symmetric(
          //             horizontal: Sizes.size6,
          //           ),
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(Sizes.size80),
          //             color: Colors.grey.shade100,
          //           ),
          //           child: Center(
          //             child: Icon(
          //               _selectedIndex == 2 ? Icons.home : Icons.home_outlined,
          //               size: 50,
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),/
          //   ),
          // ),
          ),
    );
  }
}
