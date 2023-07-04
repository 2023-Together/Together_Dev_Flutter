import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/alert/alert_screen.dart';
import 'package:swag_cross_app/features/community/club/club_comunity_test_screen.dart';

class ClubSearchTestScreen extends StatelessWidget {
  // 필드

  // 생성자
  const ClubSearchTestScreen({super.key});

  void _alertIconTap(BuildContext context) {
    context.pushNamed(AlertScreen.routeName);
  }

  // void onChangeOption1(String? value) {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF6524FF),
        child: const Icon(FontAwesomeIcons.pen),
        onPressed: () {},
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("동아리"),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size14,
              vertical: Sizes.size10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: const Icon(Icons.search),
                ),
                Gaps.h2,
                GestureDetector(
                  onTap: () => _alertIconTap(context),
                  child: const Icon(Icons.notifications_none),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Container(
        //color: Colors.grey .shade200,
        color: Colors.white,
        child: ListView.separated(
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ClubComunityTestScreen(),
                ),
              ),
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: Sizes.size16,
                ),
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(Sizes.size12),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: const Offset(3, 3), // 그림자의 위치 조정
                    ),
                  ],
                ),
                child: GestureDetector(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/club1.jpg',
                        fit: BoxFit.cover,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Sizes.size10,
                          vertical: Sizes.size8,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              "제목 ${index + 1}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Divider(),
                            Text(
                              "동아리${index + 1}에서 부원을 모집합니다. 많은 관심 부탁드립니다 :)",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey,
                              ),
                            ),
                            Gaps.v10,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("SWAG 동아리"),
                                Text("조회수 ${index * 3}"),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Gaps.v14;
          },
          itemCount: 10,
        ),
      ),
    );
  }
}
