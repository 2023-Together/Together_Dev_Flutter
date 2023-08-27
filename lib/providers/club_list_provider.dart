import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:swag_cross_app/constants/http_ip.dart';
import 'package:swag_cross_app/models/DBModels/club_data_model.dart';

import 'package:http/http.dart' as http;

class ClubListProvider extends ChangeNotifier {
  List<ClubDataModel>? _clubList;

  List<ClubDataModel>? get clubList => _clubList ?? [];

  Future<void> myClubGetDispatch({required int userId}) async {
    final url =
        Uri.parse("${HttpIp.communityUrl}/together/club/getAffiliatedClub");
    final headers = {'Content-Type': 'application/json'};
    final data = {
      "userId": userId,
    };

    final response =
        await http.post(url, headers: headers, body: jsonEncode(data));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final jsonResponse = jsonDecode(response.body) as List<dynamic>;
      print("가입된 동아리 리스트 : 성공");

      _clubList =
          jsonResponse.map((data) => ClubDataModel.fromJson(data)).toList();
    } else {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
    notifyListeners();
  }
}
