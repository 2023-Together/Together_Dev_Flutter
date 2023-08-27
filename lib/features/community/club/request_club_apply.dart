import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/widget_tools/swag_platform_dialog.dart';
import 'package:swag_cross_app/models/DBModels/club_data_model.dart';
import 'package:swag_cross_app/models/club_request_model.dart';

import 'package:http/http.dart' as http;
import 'package:swag_cross_app/constants/http_ip.dart';

class RequestClubApplyArgs {
  final ClubDataModel clubData;

  RequestClubApplyArgs({required this.clubData});
}

class RequestClubApply extends StatefulWidget {
  static const routeName = "request_join";
  static const routeURL = "/request_join";
  const RequestClubApply({
    super.key,
    required this.clubData,
  });

  final ClubDataModel clubData;

  @override
  State<RequestClubApply> createState() => _RequestClubApplyState();
}

class _RequestClubApplyState extends State<RequestClubApply> {
  List<ClubRequestModel>? _requestList;

  Future<List<ClubRequestModel>> _getClubRequestDispatch() async {
    final url =
        Uri.parse("${HttpIp.communityUrl}/together/club/getJoinClubQueue");
    final headers = {'Content-Type': 'application/json'};
    final data = {"clubId": widget.clubData.clubId};

    final response =
        await http.post(url, headers: headers, body: jsonEncode(data));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final jsonResponse = jsonDecode(response.body) as List<dynamic>;

      final filterList =
          jsonResponse.map((data) => ClubRequestModel.fromJson(data)).toList();

      return filterList.where((element) => element.joinState == 0).toList();
    } else {
      print("${response.statusCode} : ${response.body}");
      throw Exception("통신 실패!");
    }
  }

  // 동아리원 신청 승인 여부 모달 창
  Future<void> _requestTap(int index, ClubRequestModel requestData) async {
    swagPlatformDialog(
      context: context,
      title: "신청 승인",
      message: "${requestData.joinUserId}의 신청을 승인하시겠습니까?",
      actions: [
        TextButton(
          onPressed: () async {
            final url = Uri.parse(
                "${HttpIp.communityUrl}/together/club/joinClubRefusal");
            final headers = {'Content-Type': 'application/json'};
            final data = {
              "joinQueueId": requestData.joinQueueId,
            };

            final response =
                await http.post(url, headers: headers, body: jsonEncode(data));

            if (response.statusCode >= 200 && response.statusCode < 300) {
              print("신청 거부 : 성공");
              _requestList!.removeAt(index);
              context.pop();
              setState(() {});
            } else {
              if (!mounted) return;
              swagPlatformDialog(
                context: context,
                title: "오류! ${response.statusCode}",
                message: response.body,
                actions: [
                  TextButton(
                    onPressed: () => context.pop(),
                    child: const Text("알겠습니다"),
                  ),
                ],
              );
            }
          },
          child: const Text("거부"),
        ),
        TextButton(
          onPressed: () async {
            final url = Uri.parse(
                "${HttpIp.communityUrl}/together/club/joinClubApproval");
            final headers = {'Content-Type': 'application/json'};
            final data = {
              "joinQueueId": requestData.joinQueueId,
              "joinUserId": requestData.joinUserId,
              "joinClubId": requestData.joinClubId,
            };

            final response =
                await http.post(url, headers: headers, body: jsonEncode(data));

            if (response.statusCode >= 200 && response.statusCode < 300) {
              print("신청 승인 : 성공");
              _requestList!.removeAt(index);
              context.pop();
              setState(() {});
            } else {
              if (!mounted) return;
              swagPlatformDialog(
                context: context,
                title: "오류! ${response.statusCode}",
                message: response.body,
                actions: [
                  TextButton(
                    onPressed: () => context.pop(),
                    child: const Text("알겠습니다"),
                  ),
                ],
              );
            }
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
            child: FutureBuilder<List<ClubRequestModel>>(
              future: _getClubRequestDispatch(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // 데이터를 기다리는 동안 로딩 인디케이터 표시
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  // 에러가 발생한 경우 에러 메시지 표시
                  return Center(
                    child: Text('오류 발생: ${snapshot.error}'),
                  );
                } else {
                  // 데이터를 성공적으로 가져왔을 때 ListView 표시
                  _requestList = snapshot.data!;

                  return _requestList!.isEmpty
                      ? Center(
                          child: Text(
                            "신청자가 존재하지 않습니다!",
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        )
                      : ListView.separated(
                          itemBuilder: (context, index) => ListTile(
                            title: Text(
                                "${index + 1}. ${_requestList![index].userNickname}"),
                            subtitle:
                                _requestList![index].joinContent!.isNotEmpty
                                    ? Text(
                                        "${_requestList![index].joinContent}",
                                        maxLines: null,
                                      )
                                    : null,
                            trailing: ElevatedButton(
                              onPressed: () {
                                _requestTap(index, _requestList![index]);
                              },
                              child: const Text("확인"),
                            ),
                          ),
                          separatorBuilder: (context, index) => Gaps.v4,
                          itemCount: _requestList!.length,
                        );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
