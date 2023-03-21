import 'package:flutter/material.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/features/search_page/view/vol_detail_screen.dart';

class SearchVolScreen extends StatefulWidget {
  const SearchVolScreen({super.key});

  @override
  State<SearchVolScreen> createState() => _SearchVolScreenState();
}

class _SearchVolScreenState extends State<SearchVolScreen> {
  Future<void> _showAlertDialog() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: const Text('봉사 신청'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('해당 봉사를 신청하시겠습니까?'),
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
        title: const Text("봉사 검색"),
        centerTitle: true,
        elevation: 0.5,
        actions: <Widget>[
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              print("알림함");
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 12,
        ),
        child: ListView.separated(
          itemBuilder: (context, index) {
            return Container(
              color: Colors.white,
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 10,
                right: 10,
                left: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "전시 안내 및 데스크 보조 모집합니다.",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  const SizedBox(
                    height: 26,
                    child: Text(
                      "전시 안내 및 안내 데스크 보조 자원봉사자 구합니다!",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12.0,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        child: Text(
                          "진주시  |  가좌동",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                            // 상세정보 버튼
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const VolDetailScreen(),
                                ),
                              );
                            },
                            child: const Text("상세정보"),
                          ),
                          Gaps.h10,
                          ElevatedButton(
                            // 신청하기 버튼
                            onPressed: () {
                              _showAlertDialog();
                            },
                            child: const Text("신청하기"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Gaps.v10;
          },
          itemCount: 15, // 게시글 갯수
        ),
      ),
      backgroundColor: Colors.grey.shade200,
    );
  }
}
