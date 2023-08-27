import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/constants/http_ip.dart';
import 'package:swag_cross_app/features/widget_tools/swag_platform_dialog.dart';

import 'package:http/http.dart' as http;
import 'package:swag_cross_app/models/club_search_model.dart';
import 'package:swag_cross_app/providers/user_provider.dart';

class ClubSearchDetailScreenArgs {
  final ClubSearchModel clubData;

  ClubSearchDetailScreenArgs({
    required this.clubData,
  });
}

class ClubSearchDetailScreen extends StatelessWidget {
  static const routeName = "detail";
  static const routeURL = "detail";

  const ClubSearchDetailScreen({
    super.key,
    required this.clubData,
  });

  final ClubSearchModel clubData;

  void _onSubmit(BuildContext context) {
    swagPlatformDialog(
      context: context,
      title: "신청 알림",
      message: "정말로 ${clubData.clubName}에 신청하실건가요?",
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: const Text("아니오"),
        ),
        TextButton(
          onPressed: () async {
            final userData = context.read<UserProvider>().userData;
            final url =
                Uri.parse("${HttpIp.communityUrl}/together/club/joinClub");
            final headers = {'Content-Type': 'application/json'};
            final data = {
              "joinUserId": userData!.userId,
              "joinClubId": clubData.clubId,
            };

            final response =
                await http.post(url, headers: headers, body: jsonEncode(data));

            if (response.statusCode >= 200 && response.statusCode < 300) {
              if (!context.mounted) return;
              context.pop();
              context.pop();
              context.pop();
            } else {
              print("${response.statusCode} : ${response.body}");
              context.pop();
              throw Exception("통신 실패!");
            }
          },
          child: const Text("예"),
        ),
      ],
    );
  }

  Widget _title({required String title}) {
    return Text(
      title,
      style: const TextStyle(
        color: Color.fromARGB(255, 53, 50, 50),
        fontSize: 20,
        fontWeight: FontWeight.w800,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("동아리 신청"),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: ElevatedButton(
          onPressed: clubData.clubRecruiting ? () => _onSubmit(context) : null,
          style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(
              fontSize: 18,
            ),
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
          child: Text(clubData.clubRecruiting ? "신청" : "신청 불가능"),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Image.asset(
            //   'assets/images/club1.jpg',
            //   fit: BoxFit.cover,
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gaps.v10,
                  _title(title: clubData.clubName),
                  Gaps.v10,
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 180,
                    decoration: const BoxDecoration(
                      border: Border.symmetric(
                        horizontal: BorderSide(
                          color: Colors.black26,
                        ),
                      ),
                    ),
                    child: Scrollbar(
                      child: SingleChildScrollView(
                        child: Text(
                          clubData.clubDescription,
                          style: Theme.of(context).textTheme.bodyMedium,
                          maxLines: null,
                        ),
                      ),
                    ),
                  ),
                  Gaps.v10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: Theme.of(context).textTheme.bodyLarge,
                          children: [
                            const TextSpan(text: "동아리장 : "),
                            TextSpan(
                              text: clubData.clubMasterNickname,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Gaps.v10,
                  RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyLarge,
                      children: [
                        const TextSpan(text: "동아리 인원(명) : "),
                        TextSpan(
                          text: "${clubData.clubMemberCount}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
