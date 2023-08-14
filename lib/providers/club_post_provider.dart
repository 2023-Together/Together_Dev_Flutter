import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:swag_cross_app/models/post_card_model.dart';

import 'package:http/http.dart' as http;

class ClubPostProvider extends ChangeNotifier {
  List<PostCardModel>? _clubPostList;
  final bool _isSearched = false;
  String? _searchText;

  List<PostCardModel>? get clubPostList => _clubPostList ?? [];

  Future<void> refreshClubPostDispatch(
      {required int? userId, required int clubId}) async {
    clubPostGetDispatch(userId: userId!, clubId: clubId);
    _searchText = null;
    notifyListeners();
  }

  Future<void> clubPostGetDispatch(
      {required int userId, required int clubId}) async {
    final url =
        Uri.parse("http://58.150.133.91:80/together/post/getPostsByClubId");
    final headers = {'Content-Type': 'application/json'};
    final data = {
      "userId": userId,
      "clubId": clubId,
    };
    final response =
        await http.post(url, headers: headers, body: jsonEncode(data));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final jsonResponse = jsonDecode(response.body) as List<dynamic>;
      print("동아리 커뮤니티 : 성공");

      // 응답 데이터를 ClubSearchModel 리스트로 파싱
      _clubPostList = _insertAds(
          jsonResponse.map((data) => PostCardModel.fromJson(data)).toList(), 5);
    } else {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception("게시물 데이터를 불러오는데 실패하였습니다.");
    }
    notifyListeners();
  }

  Future<void> clubPostSearchDispatch({
    required int userId,
    required int clubId,
    required String keyword,
  }) async {
    final url =
        Uri.parse("http://58.150.133.91:80/together/post/getPostForKeyword");
    final headers = {'Content-Type': 'application/json'};
    final data = {
      "userId": userId,
      "clubId": clubId,
      "keyword": keyword,
    };

    final response =
        await http.post(url, headers: headers, body: jsonEncode(data));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final jsonResponse = jsonDecode(response.body) as List<dynamic>;
      print("메인 커뮤니티 검색 : 성공");

      // 응답 데이터를 PostCardModel 리스트로 파싱
      _clubPostList = _insertAds(
          jsonResponse.map((data) => PostCardModel.fromJson(data)).toList(), 5);
    } else {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception("게시물 데이터를 불러오는데 실패하였습니다.");
    }
  }

  Future<void> onChangePostLike({required int index}) async {
    _clubPostList![index].postLikeId = !_clubPostList![index].postLikeId;
    notifyListeners();
  }

  // 리스트에 광고 삽입하는 함수
  List<PostCardModel> _insertAds(
      List<PostCardModel> originalList, int adInterval) {
    List<PostCardModel> resultList = [];

    for (int i = 0; i < originalList.length; i++) {
      // 광고를 삽입할 위치인지 확인
      if (i > 0 && i % adInterval == 0) {
        // 광고를 삽입할 위치라면 광고 모델을 생성하여 리스트에 추가
        resultList.add(_createAdModel());
      }

      // 원본 리스트의 요소를 리스트에 추가
      resultList.add(originalList[i]);
    }

    return resultList;
  }

  // 가상의 광고 모델 생성 함수
  PostCardModel _createAdModel() {
    // 광고 모델을 생성하여 반환하는 로직 구현
    // 여기서는 가상의 광고 모델을 생성하여 반환하도록 가정
    // 필요에 따라 광고 모델을 별도로 정의하고 초기화해야 합니다.
    return PostCardModel(
      postId: 0,
      postBoardId: 0,
      postUserId: 0,
      userNickname: "",
      postTitle: "",
      postContent: "",
      postTag: [],
      postCreationDate: DateTime.now(),
      postLikeId: false,
      postLikeCount: 0,
      postCommentCount: 0,
      isAd: true,
    );
  }
}
