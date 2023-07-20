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
  List<String> applicants = ['홍길동', '김철수', '강소연'];

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
                  Text(
                    '신청 승인하시겠습니까?',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 15.0,
                    ),
                  ),
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

  // 동아리원 신청 거절 여부 모달 창
  Future<void> _requestRefusTap(int index) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: const Text('신청 거절'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text(
                    '신청 거절하시겠습니까?',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 15.0,
                    ),
                  ),
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
                // 거절 버튼
                onPressed: () {
                  setState(() {
                    applicants.removeAt(index);
                  });
                },
                child: const Text('예'),
              ),
            ],
          );
        });
  }

  // 동아리원 신청 승인 여부 모달 창
  Future<void> _requestJoinTap(int index) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: const Text('동아리 가입 신청'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    '이름: ' + '${applicants[index]}',
                    style:
                        TextStyle(fontWeight: FontWeight.w400, fontSize: 15.0),
                  ),
                  Text(
                    '활동 포부: ' + '동아리 활동에 열심히 임하겠습니다!',
                    style:
                        TextStyle(fontWeight: FontWeight.w400, fontSize: 15.0),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                // 신청 버튼
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  '취소',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                  ),
                ),
              ),
              TextButton(
                // 취소 버튼
                onPressed: () {
                  _requestRefusTap(index);
                },
                child: const Text(
                  '신청 거절',
                  style: TextStyle(fontSize: 14.0),
                ),
              ),
              TextButton(
                // 신청 버튼
                onPressed: () {
                  _requestTap();
                },

                child: const Text(
                  '신청 승인',
                  style: TextStyle(fontSize: 14.0),
                ),
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
            child: ListView.builder(
              itemCount: applicants.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () => _requestJoinTap(index),
                  title: Text("동아리원 신청합니다!"),
                  subtitle: Text("이름: ${applicants[index]}"),
                  trailing: Icon(
                    Icons.chevron_right_outlined,
                    size: Sizes.size24,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
