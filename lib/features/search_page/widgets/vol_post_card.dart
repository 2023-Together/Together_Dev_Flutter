import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:swag_cross_app/features/search_page/view/vol_detail_screen.dart';
import 'package:swag_cross_app/features/widget_tools/swag_platform_dialog.dart';
import 'package:swag_cross_app/providers/UserProvider.dart';

class VolPostCard extends StatefulWidget {
  // 봉사활동 아이디
  final String id;
  // 봉사활동 제목
  final String title;
  // 봉사활동 설명
  final String contnet;
  // 봉사활동 주체단체 (기관)
  final String host;
  // 봉사활동 위치
  final String locationStr;
  // 봉사활동 모집 마감일
  final String startTime;
  final String endTime;

  const VolPostCard({
    super.key,
    required this.id,
    required this.title,
    // required this.tabBarSelected,
    required this.contnet,
    required this.host,
    required this.locationStr,
    required this.startTime,
    required this.endTime,
  });

  @override
  State<VolPostCard> createState() => _VolPostCardState();
}

class _VolPostCardState extends State<VolPostCard> {
  final bool _isLogined = false;

  @override
  void initState() {
    super.initState();

    // checkLoginType();
  }

  // // 로그인 타입을 가져와서 로그인 상태를 적용하는 함수
  // void checkLoginType() async {
  //   var loginType = await SecureStorageLogin.getLoginType();
  //   print(loginType);
  //   if (loginType == "naver" || loginType == "kakao") {
  //     _isLogined = true;
  //   } else {
  //     _isLogined = false;
  //   }
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return LayoutBuilder(
      builder: (context, constraints) => Container(
        clipBehavior: Clip.hardEdge,
        width: constraints.maxWidth,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: GestureDetector(
          onTap: () {
            if (!context.read<UserProvider>().isLogined) {
              final loginType = context.read<UserProvider>().isLogined;

              if (loginType.toString() != "naver" &&
                  loginType.toString() != "kakao") {
                swagPlatformDialog(
                  context: context,
                  title: "로그인 알림",
                  message:
                      "로그인이 되어 있지 않습니다! \n해당 봉사가 등록되어 있는 1365 혹은 vms 페이지로 이동하시겠습니까?",
                  actions: [
                    TextButton(
                      onPressed: () => context.pop(),
                      child: const Text("아니오"),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text("예"),
                    ),
                  ],
                );
              }
            } else {
              context.pushNamed(
                VolDetailScreen.routeName,
                extra: VolDetailScreenArgs(
                  id: widget.id,
                  title: widget.title,
                  contnet: widget.contnet,
                  host: widget.host,
                  locationStr: widget.locationStr,
                  startTime: widget.startTime,
                  endTime: widget.endTime,
                  tabBarSelected: 0,
                ),
              );
            }
          },
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.purple.shade300,
                            // border: Border.all(
                            //   width: 1,
                            // ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                          child: const Text(
                            "모집 중",
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      widget.contnet,
                      style: const TextStyle(fontSize: 12.0, height: 2.0),
                    ),
                    Text(
                      "모집기간 : ${widget.startTime} ~ ${widget.endTime}",
                      style: const TextStyle(
                        color: Color.fromARGB(255, 124, 123, 123),
                        fontSize: 12.0,
                        height: 2.8,
                      ),
                    ),
                    Container(
                      height: 1,
                      width: 400,
                      color: const Color.fromARGB(255, 203, 203, 203),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.host,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 124, 123, 123),
                              fontSize: 12.0,
                              height: 2.5),
                        ),
                        Text(
                          widget.locationStr,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 124, 123, 123),
                              fontSize: 12.0,
                              height: 2.5),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
