import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:swag_cross_app/constants/gaps.dart';

import 'package:http/http.dart' as http;
import 'package:swag_cross_app/models/DBModels/club_data_model.dart';
import 'package:swag_cross_app/constants/http_ip.dart';

class ClubSelectScreenArgs {
  final ClubDataModel clubData;

  ClubSelectScreenArgs({required this.clubData});
}

class ClubSelectScreen extends StatefulWidget {
  const ClubSelectScreen({
    super.key,
    required this.clubData,
  });

  final ClubDataModel clubData;

  @override
  State<ClubSelectScreen> createState() => _ClubSelectScreenState();
}

class _ClubSelectScreenState extends State<ClubSelectScreen> {
  List<String>? _clubMembers;

  Future<List<String>> _clubMembersDispatch() async {
    final url =
        Uri.parse("${HttpIp.communityUrl}/together/club/getClubMemberByClubId");
    final headers = {'Content-Type': 'application/json'};
    final data = {"clubId": widget.clubData.clubId};

    final response =
        await http.post(url, headers: headers, body: jsonEncode(data));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final jsonResponse = jsonDecode(response.body) as List<dynamic>;
      final List<String> clubMembers = jsonResponse
          .map((member) => member["userNickname"] as String)
          .toList();

      return clubMembers;
    } else {
      print("${response.statusCode} : ${response.body}");
      throw Exception("통신 실패!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("동아리원 목록"),
      ),
      body: FutureBuilder<List<String>>(
        future: _clubMembersDispatch(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // 데이터를 기다리는 동안 로딩 인디케이터 표시
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            // 에러가 발생한 경우 에러 메시지 표시
            print("${snapshot.error}");
            return Center(
              child: Text('오류 발생: ${snapshot.error}'),
            );
          } else {
            _clubMembers = snapshot.data!;

            return ListView.separated(
              itemBuilder: (context, index) => Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 8,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: ListTile(
                  title: Text("${index + 1}. ${_clubMembers![index]}"),
                ),
              ),
              separatorBuilder: (context, index) => Gaps.v6,
              itemCount: _clubMembers!.length,
            );
          }
        },
      ),
    );
  }
}
