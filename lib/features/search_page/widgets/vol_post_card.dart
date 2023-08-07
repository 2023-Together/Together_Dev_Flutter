import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/features/widget_tools/swag_platform_dialog.dart';
import 'package:swag_cross_app/models/DBModels/volunteer_model.dart';
import 'package:swag_cross_app/providers/user_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class VolPostCard extends StatelessWidget {
  final VolunteerModel volData;

  const VolPostCard({
    super.key,
    required this.volData,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Container(
        clipBehavior: Clip.hardEdge,
        width: constraints.maxWidth,
        height: 150,
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
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
                  message: "해당 봉사가 등록되어 있는 1365 혹은 vms 페이지로 이동하시겠습니까?",
                  actions: [
                    TextButton(
                      onPressed: () => context.pop(),
                      child: const Text("아니오"),
                    ),
                    TextButton(
                      onPressed: () {
                        if (volData.listApiType == "1365") {
                          final url_1365 = Uri.parse(
                              'https://www.1365.go.kr/vols/1572247904127/partcptn/timeCptn.do?type=show&progrmRegistNo=${volData.seq}');
                          launchUrl(
                            url_1365,
                            mode: LaunchMode.externalApplication,
                          );
                        } else if (volData.listApiType == "vms") {
                          final urlVms = Uri.parse(
                              'https://www.vms.or.kr/partspace/recruitView.do?seq=${volData.seq}');
                          launchUrl(
                            urlVms,
                            mode: LaunchMode.externalApplication,
                          );
                        }
                        Navigator.pop(context);
                      },
                      child: const Text("예"),
                    ),
                  ],
                );
              }
            } else {
              try {
                if (volData.listApiType == "1365") {
                  final url_1365 = Uri.parse(
                      'https://www.1365.go.kr/vols/1572247904127/partcptn/timeCptn.do?type=show&progrmRegistNo=${volData.seq}');
                  launchUrl(
                    url_1365,
                    mode: LaunchMode.externalApplication,
                  );
                } else if (volData.listApiType == "vms") {
                  final urlVms = Uri.parse(
                      'https://www.vms.or.kr/partspace/recruitView.do?seq=${volData.seq}');
                  launchUrl(
                    urlVms,
                    mode: LaunchMode.externalApplication,
                  );
                }
                Navigator.pop(context);
              } catch (e) {
                print("URL 열기 에러: $e");
              }
            }
          },
          child: Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [],
                // ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    volData.title,
                    maxLines: 2,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  trailing: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
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
                ),
                Text(
                  "활동 장소: ${volData.actPlace} (${volData.areaName})",
                  maxLines: 2,
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 12.0,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Gaps.v10,
                Container(
                  height: 1,
                  width: 400,
                  color: const Color.fromARGB(255, 203, 203, 203),
                ),
                Gaps.v10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        volData.centName ?? "",
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 12.0,
                          fontWeight: FontWeight.normal,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Gaps.h6,
                    if (volData.teenager == "Y")
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
                        child: const Text(
                          "청소년",
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.black,
                          ),
                        ),
                      )
                  ],
                ),
                Gaps.v10,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
