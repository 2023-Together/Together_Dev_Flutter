import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/alert/alert_screen.dart';
import 'package:swag_cross_app/features/club/club_post_detail_page.dart';
import 'package:swag_cross_app/features/page_test/club_comunity_test_screen.dart';
import 'package:swag_cross_app/features/page_test/widgets/state_dropDown_button.dart';

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
        //color: Colors.grey .shade200,
        color: Colors.white,
        child: ListView.separated(
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                // boxShadow: [ 
                //   BoxShadow (
                //   color: Colors.grey.withOpacity(0.7),
        
                //   offset: const Offset(0, 7),
                // ),]
//         color: Colors.grey.shade200,
//         child: Column(
//           children: [
//             Container(
//               height: 45,
//               color: Colors.white,
//               padding: const EdgeInsets.symmetric(
//                 horizontal: Sizes.size14,
//               ),
//               child: ListView(
//                 scrollDirection: Axis.horizontal,
//                 children: [
//                   StateDropDownButton(
//                     title: "제목1",
//                     initOption: option1,
//                     onChangeOption: onChangeOption1,
//                   ),
//                   Gaps.h14,
//                   StateDropDownButton(
//                     title: "제목2",
//                     initOption: option2,
//                     onChangeOption: onChangeOption2,
//                   ),
//                   Gaps.h14,
//                   StateDropDownButton(
//                     title: "제목3",
//                     initOption: option3,
//                     onChangeOption: onChangeOption3,
//                   ),
//                   Gaps.h14,
//                   StateDropDownButton(
//                     title: "제목3",
//                     initOption: option3,
//                     onChangeOption: onChangeOption3,
//                   ),
//                   Gaps.h14,
//                   StateDropDownButton(
//                     title: "제목3",
//                     initOption: option3,
//                     onChangeOption: onChangeOption3,
//                   ),
//                   Gaps.h14,
//                   StateDropDownButton(
//                     title: "제목3",
//                     initOption: option3,
//                     onChangeOption: onChangeOption3,
//                   ),
//                 ],
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
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          club_def,
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    )
                    // // 동아리원 모집 글 Listview
                    // Expanded(
                    //   child: ListView.separated(
                    //     shrinkWrap: true,
                    //     itemBuilder: (context, index) => LayoutBuilder(
                    //       builder: (context, constraints) => Padding(
                    //         padding: const EdgeInsets.symmetric(
                    //           horizontal: Sizes.size14,
                    //         ),
                    //         child: GestureDetector(
                    //           onTap: () {
                    //             Navigator.push(
                    //               context,
                    //               MaterialPageRoute(
                    //                 builder: (context) =>
                    //                     const ClubComunityTestScreen(),
                    //               ),
                    //             );
                    //           },
                    //           child: Container(
                    //             width: constraints.maxWidth,
                    //             height: 150,
                    //             padding: const EdgeInsets.symmetric(
                    //               vertical: Sizes.size10,
                    //               horizontal: Sizes.size14,
                    //             ),
                    //             decoration: BoxDecoration(
                    //               color: Colors.white,
                    //               border: Border.all(
                    //                 width: 1,
                    //               ),
                    //               borderRadius: const BorderRadius.all(
                    //                 Radius.circular(
                    //                   Sizes.size20,
                    //                 ),
                    //               ),
                    //             ),
                    //             child: Column(
                    //               crossAxisAlignment: CrossAxisAlignment.start,
                    //               children: [
                    //                 Expanded(
                    //                   flex: 1,
                    //                   child: Text(
                    //                     title,
                    //                     style: const TextStyle(
                    //                       fontSize: Sizes.size20,
                    //                       fontWeight: FontWeight.bold,
                    //                     ),
                    //                   ),
                    //                 ),
                    //                 const Divider(
                    //                   thickness: 1,
                    //                 ),
                    //                 Expanded(
                    //                   flex: 3,
                    //                   child: Text(
                    //                     content * 5,
                    //                     maxLines: 3,
                    //                     overflow: TextOverflow.ellipsis,
                    //                     style: TextStyle(
                    //                       color: Colors.grey.shade500,
                    //                     ),
                    //                   ),
                    //                 ),
                    //                 const Expanded(
                    //                   flex: 1,
                    //                   child: Row(
                    //                     mainAxisAlignment:
                    //                         MainAxisAlignment.spaceBetween,
                    //                     children: [
                    //                       Text(
                    //                         "SWAG 동아리",
                    //                         style: TextStyle(
                    //                           fontWeight: FontWeight.bold,
                    //                         ),
                    //                       ),
                    //                       Text(
                    //                         "조회수 24",
                    //                         style: TextStyle(
                    //                           color: Colors.grey,
                    //                         ),
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //     separatorBuilder: (context, index) => Gaps.v10,
                    //     itemCount: 12,
                    //   ),
                    // ),
                  ],
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
