import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/alert/alert_screen.dart';
import 'package:swag_cross_app/features/page_test/club_comunity_test_screen.dart';

class ClubSearchTestScreen extends StatelessWidget {
  // 필드

  // String option1 = "옵션1";
  final Widget image;

  // 동아리 이름
  final String club_name;

  // 동아리 설명
  final String club_def;

  // 생성자
  const ClubSearchTestScreen(
      {super.key,
      required this.image,
      required this.club_name,
      required this.club_def});

  void _alertIconTap(BuildContext context) {
    context.pushNamed(AlertScreen.routeName);
  }

  // void onChangeOption1(String? value) {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // shape: const RoundedRectangleBorder(
        //   borderRadius: BorderRadius.vertical(
        //     bottom: Radius.circular(20.0),
        //   ),
        // ),

        title: const Text("동아리"),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.size10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: const Icon(
                    Icons.search,
                    size: 38,
                    color: Colors.black54,
                  ),
                ),
                Gaps.h3,
                GestureDetector(
                  onTap: () => _alertIconTap(context),
                  child: const Icon(
                    Icons.notifications_none,
                    size: 38,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF6524FF),
        child: const Icon(FontAwesomeIcons.pen),
        onPressed: () {},
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
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: GestureDetector(
                  child: Column(
                    children: [
                      Gaps.v7,
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: image,
                      ),
                      const SizedBox(height: 16.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            club_name,
                            style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            club_def,
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Gaps.v10;
          },
          itemCount: 10,
        ),
      ),
    );
  }
}
