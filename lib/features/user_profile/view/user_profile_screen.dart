import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/alert/alert_screen.dart';
import 'package:swag_cross_app/features/main_navigation/mian_navigation.dart';
import 'package:swag_cross_app/features/storages/secure_storage_login.dart';
import 'package:swag_cross_app/features/user_profile/view/user_inform_update.dart';

// 마이페이지-메인
class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  void initState() {
    super.initState();

    // SecureStorageLogin.loginCheckIsNone(context, mounted);
  }

  void _alertIconTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const AlertScreen(),
      ),
    );
  }

  void onLogoutTap(BuildContext context) {
    SecureStorageLogin.setLogout();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const MainNavigation(
          initSelectedIndex: 2,
        ),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    // final _imageSize = MediaQuery.of(context).size.width / 4;
    String name = "강소연";
    String level = "GOLD 등급";
    int volTime = 20;

    return Scaffold(
      appBar: AppBar(
        title: const Text("마이페이지"),
        actions: [
          // IconButton(
          //     icon: const Icon(Icons.search),
          //     onPressed: () {
          //       print("검색");
          //     }),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.size10,
              horizontal: Sizes.size10,
            ),
            child: GestureDetector(
              onTap: _alertIconTap,
              child: const FaIcon(
                FontAwesomeIcons.bell,
                size: 34,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
      //  body: Column(
      //   children: [
      //     Container(
      //       constraints: BoxConstraints(
      //           minHeight: _imageSize,
      //           minWidth: _imageSize,
      //         ),
      //         child: GestureDetector(
      //           onTap: () {

      //           },
      //           child: const Center(
      //             child: Icon(
      //               Icons.account_circle,

      //             ),
      //           ),
      //         )
      //     ),
      //   ],
      //  ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              height: 180,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    blurRadius: 5.0,
                    spreadRadius: 0.0,
                    offset: const Offset(2, 6),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            // 내 프로필 이미지
                            flex: 1,
                            child: GestureDetector(
                              child: const CircleAvatar(
                                radius: 48.0,
                                foregroundImage: NetworkImage(
                                  "https://avatars.githubusercontent.com/u/77985708?v=4",
                                ),
                                child: Text("재현"),
                              ),
                            ),
                          ),
                          Expanded(
                            // 내 정보(이름, 등급)
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16.0, horizontal: 18.0),
                              child: SizedBox(
                                height: 100,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(name,
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                    Text(level,
                                        style: const TextStyle(fontSize: 18)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.chevron_right_rounded,
                                      size: 50,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const UserInformUpdate()));
                                    },
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Expanded(
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          //     children: [
                          //       IconButton(
                          //           icon: const Icon(Icons.chevron_right),
                          //           onPressed: () {
                          //             print("검색");
                          //           }),
                          //     ],
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  ),
                  Container(height: 1, width: 350, color: Colors.grey),
                  const Expanded(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text("누적 봉사 시간: 20시간")],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Gaps.v20,
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    blurRadius: 5.0,
                    spreadRadius: 0.0,
                    offset: const Offset(2, 6),
                  )
                ],
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: Column(
                      // onTap: ,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text("봉사 신청"), Text("2건")],
                    ),
                  ),
                  Container(height: 50, width: 2, color: Colors.grey),
                  const Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text("봉사 완료"), Text("6건")],
                    ),
                  ),
                ],
              ),
            ),
            Gaps.v20,
            Column(
              children: [
                const Text("인증서 발급"),
                Gaps.v20,
                const Text("FAQ"),
                Gaps.v20,
                const Text("고객 센터"),
                Gaps.v20,
                GestureDetector(
                  onTap: () => onLogoutTap(context),
                  child: const Text("로그아웃"),
                ),
                Gaps.v20,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
