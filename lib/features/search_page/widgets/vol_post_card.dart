import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/features/widget_tools/swag_platform_dialog.dart';
import 'package:swag_cross_app/providers/user_provider.dart';
import 'package:url_launcher/url_launcher.dart';


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
  // 봉사 활동 장소
  final String actPlace;
  // 청소년 가능 여부
  final String teenager;
  // api type
  final String listApiType;

  const VolPostCard({
    super.key,
    required this.id,
    required this.title,
    // required this.tabBarSelected,
    required this.contnet,
    required this.host,
    required this.locationStr,
    required this.actPlace,
    required this.teenager,
    required this.listApiType,
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
      builder: (context, constraints) => GestureDetector(
        onTap: () {
          // if (!context.read<UserProvider>().isLogined) {
          //   swagPlatformDialog(
          //     context: context,
          //     title: "로그인 알림",
          //     message: "해당 봉사가 등록되어 있는 1365 혹은 vms 페이지로 이동하시겠습니까?",
          //     actions: [
          //       TextButton(
          //         onPressed: () => context.pop(),
          //         child: const Text("아니오"),
          //       ),
          //       TextButton(
          //         onPressed: () {},
          //         child: const Text("예"),
          //       ),
          //     ],
          //   );
          // } else {
          //   context.pushNamed(
          //     VolDetailScreen.routeName,
          //     extra: VolDetailScreenArgs(
          //       id: widget.id,
          //       title: widget.title,
          //       contnet: widget.contnet,
          //       host: widget.host,
          //       locationStr: widget.locationStr,
          //       actPlace: widget.actPlace,
          //       teenager: widget.teenager,
          //       listApiType: widget.listApiType,
          //       tabBarSelected: 0,
          //     ),
          //   );
          // }
          swagPlatformDialog(
                  context: context,
                  title: "로그인 알림",
                  message:
                      "해당 봉사가 등록되어 있는 1365 혹은 vms 페이지로 이동하시겠습니까?",
                  actions: [
                    TextButton(
                      onPressed: () => context.pop(),
                      child: const Text("아니오"),
                    ),
                    TextButton(
                      onPressed: () {
                        if (widget.listApiType == "1365") {
                          launchUrl(Uri.parse(
                              'https://www.1365.go.kr/vols/1572247904127/partcptn/timeCptn.do?type=show&progrmRegistNo=${120}'));
                        } else if (widget.listApiType == "vms") {
                          launchUrl(Uri.parse(
                              'https://www.vms.or.kr/partspace/recruitView.do?seq=${120}'));
                        }
                        Navigator.pop(context);
                      },
                      child: const Text("예"),
                    ),
                  ],
                );
        },
        child: Container(
          clipBehavior: Clip.hardEdge,
          width: constraints.maxWidth,
          height: 150,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: GestureDetector(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14.0),
                      ),
                      Row(
                        children: [
                          if (widget.teenager.isNotEmpty)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 7,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                ),
                                color: Colors.white,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              child: Text(
                                widget.teenager,
                                style: const TextStyle(
                                  fontSize: 10.0,
                                  color: Colors.black,
                                ),
                              ),
                            )
                          else
                            const SizedBox(
                              width: 0,
                              height: 0,
                            ),
                          Gaps.h8,
                          if (widget.listApiType == '1365')
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 7,
                                vertical: 3,
                              ),
                              decoration: const BoxDecoration(
                                color: Colors.yellow,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              child: Text(
                                widget.listApiType,
                                style: const TextStyle(
                                  fontSize: 10.0,
                                  color: Colors.black,
                                ),
                              ),
                            if (widget.listApiType != '1365' &&
                                widget.listApiType != 'vms')
                              SizedBox(width: 0, height: 0),
                          ],
                        ),

                        // Text(
                        //   widget.locationStr,
                        //   style: const TextStyle(
                        //       color: Color.fromARGB(255, 124, 123, 123),
                        //       fontSize: 12.0,
                        //       height: 2.5),
                        // ),
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
