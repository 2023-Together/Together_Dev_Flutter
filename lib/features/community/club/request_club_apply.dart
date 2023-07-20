import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/widget_tools/swag_platform_dialog.dart';

class RequestClubApply extends StatefulWidget {
  static const routeName = "request_join";
  static const routeURL = "/request_join";
  const RequestClubApply({super.key});

  @override
  State<RequestClubApply> createState() => _RequestClubApplyState();
}

class _RequestClubApplyState extends State<RequestClubApply> {
  // 동아리원 신청 승인 여부 모달 창
  Future<void> _requestTap() async {
    // return showDialog<void>(
    //     context: context,
    //     barrierDismissible: false,
    //     builder: (context) {
    //       return AlertDialog(
    //         title: const Text('신청 승인'),
    //         content: SingleChildScrollView(
    //           child: ListBody(
    //             children: const <Widget>[
    //               Text('신청 승인하시겠습니까?'),
    //             ],
    //           ),
    //         ),
    //         actions: <Widget>[
    //           TextButton(
    //             // 취소 버튼
    //             onPressed: () {
    //               Navigator.of(context).pop();
    //             },
    //             child: const Text('아니오'),
    //           ),
    //           TextButton(
    //             // 신청 버튼
    //             onPressed: () {},

    //             child: const Text('예'),
    //           ),
    //         ],
    //       );
    //     });
    swagPlatformDialog(
      context: context,
      title: "신청 승인",
      message: "해당 유저의 신청을 승인하시겠습니까?",
      actions: [
        TextButton(
          onPressed: () {
            context.pop();
          },
          child: const Text("거부"),
        ),
        TextButton(
          onPressed: () {
            context.pop();
          },
          child: const Text("승인"),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("동아리 신청 현황"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(Sizes.size12),
                ),
              ),
              child: ListView(
                children: [
                  ListTile(
                    title: const Text("동아리원 신청합니다!"),
                    subtitle: const Text("이름: 홍길동"),
                    trailing: ElevatedButton(
                        onPressed: () {
                          _requestTap();
                        },
                        child: const Text("승인")),
                  ),
                  ListTile(
                    title: const Text("동아리원 신청합니다!"),
                    subtitle: const Text("이름: 김철수"),
                    trailing: ElevatedButton(
                        onPressed: () {
                          _requestTap();
                        },
                        child: const Text("승인")),
                  ),
                  ListTile(
                    title: const Text("동아리원 신청합니다!"),
                    subtitle: const Text("이름: 강소연"),
                    trailing: ElevatedButton(
                        onPressed: () {
                          _requestTap();
                        },
                        child: const Text("승인")),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
