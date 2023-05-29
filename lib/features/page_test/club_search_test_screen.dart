import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/alert/alert_screen.dart';
import 'package:swag_cross_app/features/page_test/club_comunity_test_screen.dart';
import 'package:swag_cross_app/features/page_test/widgets/state_dropDown_button.dart';

class ClubSearchTestScreen extends StatefulWidget {
  const ClubSearchTestScreen({super.key});

  @override
  State<ClubSearchTestScreen> createState() => _ClubSearchTestScreenState();
}

class _ClubSearchTestScreenState extends State<ClubSearchTestScreen> {
  String option1 = "옵션1";
  String option2 = "옵션1";
  String option3 = "옵션1";

  final String title = "동아리 원을 모집합니다!";
  final String content = "유령 회원이 아닌 열심히 봉사 활동을 하실분들만 모집할 예정입니다.";

  void _alertIconTap(BuildContext context) {
    context.pushNamed(AlertScreen.routeName);
  }

  void onChangeOption1(String? value) {
    if (value == null) {
      option1 = "옵션1";
    } else {
      option1 = value;
    }
    setState(() {});
  }

  void onChangeOption2(String? value) {
    if (value == null) {
      option2 = "옵션1";
    } else {
      option2 = value;
    }
    setState(() {});
  }

  void onChangeOption3(String? value) {
    if (value == null) {
      option3 = "옵션1";
    } else {
      option3 = value;
    }
    setState(() {});
  }

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
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size20,
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
                Gaps.h6,
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
        color: Colors.grey.shade200,
        child: Column(
          children: [
            Container(
              height: 45,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size14,
              ),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  StateDropDownButton(
                    initOption: option1,
                    onChangeOption: onChangeOption1,
                  ),
                  Gaps.h14,
                  StateDropDownButton(
                    initOption: option2,
                    onChangeOption: onChangeOption2,
                  ),
                  Gaps.h14,
                  StateDropDownButton(
                    initOption: option3,
                    onChangeOption: onChangeOption3,
                  ),
                  Gaps.h14,
                  StateDropDownButton(
                    initOption: option3,
                    onChangeOption: onChangeOption3,
                  ),
                  Gaps.h14,
                  StateDropDownButton(
                    initOption: option3,
                    onChangeOption: onChangeOption3,
                  ),
                  Gaps.h14,
                  StateDropDownButton(
                    initOption: option3,
                    onChangeOption: onChangeOption3,
                  ),
                ],
              ),
            ),
            Gaps.v6,
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) => LayoutBuilder(
                  builder: (context, constraints) => Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Sizes.size14,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const ClubComunityTestScreen(),
                          ),
                        );
                      },
                      child: Container(
                        width: constraints.maxWidth,
                        height: 150,
                        padding: const EdgeInsets.symmetric(
                          vertical: Sizes.size10,
                          horizontal: Sizes.size14,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            width: 1,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(
                              Sizes.size20,
                            ),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                title,
                                style: const TextStyle(
                                  fontSize: Sizes.size20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Divider(
                              thickness: 1,
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(
                                content * 5,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ),
                            const Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "SWAG 동아리",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "조회수 24",
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                separatorBuilder: (context, index) => Gaps.v10,
                itemCount: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
