import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/test/test_flutter_secure_storage_platform.dart';
import 'package:go_router/go_router.dart';
import 'package:swag_cross_app/constants/sizes.dart';

class RequestClubJoin extends StatefulWidget {
  static const routeName = "request_join";
  static const routeURL = "/request_join";
  const RequestClubJoin({super.key});

  @override
  State<RequestClubJoin> createState() => _RequestClubJoinState();
}

class _RequestClubJoinState extends State<RequestClubJoin> {
  // 동아리원 신청 승인 여부 모달 창
  Future<void> _requestTap() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: const Text('신청 승인'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('신청 승인하시겠습니까?'),
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
                // 신청 버튼
                onPressed: () {},

                child: const Text('예'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("동아리 신청 현황"),
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
                    title: Text("동아리원 신청합니다!"),
                    subtitle: Text("이름: 홍길동"),
                    trailing: ElevatedButton(
                        onPressed: () {
                          _requestTap();
                        },
                        child: Text("승인")),
                  ),
                  ListTile(
                    title: Text("동아리원 신청합니다!"),
                    subtitle: Text("이름: 김철수"),
                    trailing: ElevatedButton(
                        onPressed: () {
                          _requestTap();
                        },
                        child: Text("승인")),
                  ),
                  ListTile(
                    title: Text("동아리원 신청합니다!"),
                    subtitle: Text("이름: 강소연"),
                    trailing: ElevatedButton(
                        onPressed: () {
                          _requestTap();
                        },
                        child: Text("승인")),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
