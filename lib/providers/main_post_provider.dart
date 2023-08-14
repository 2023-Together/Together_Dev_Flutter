import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:swag_cross_app/models/post_card_model.dart';

import 'package:http/http.dart' as http;

class MainPostProvider extends ChangeNotifier {
  List<PostCardModel>? _postList;
  bool _isSearched = false;
  String? _searchText;

  List<PostCardModel>? get postList => _postList ?? [];

  Future<void> refreshMainPostDispatch({required int? userId}) async {
    mainPostGetDispatch(userId: userId);
    _searchText = null;
    notifyListeners();
  }

  Future<void> mainPostGetDispatch({required int? userId}) async {
    final url =
        Uri.parse("http://58.150.133.91:80/together/post/getAllPostForMain");
    final headers = {'Content-Type': 'application/json'};
    final data = {
      "userId": userId,
    };
    final response =
        await http.post(url, headers: headers, body: jsonEncode(data));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final jsonResponse = jsonDecode(response.body) as List<dynamic>;
      print("메인 커뮤니티 : 성공");
      print(jsonResponse);

      // 응답 데이터를 PostCardModel 리스트로 파싱
      _postList = _insertAds(
          jsonResponse.map((data) => PostCardModel.fromJson(data)).toList(), 5);
    } else {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return;
    }
    notifyListeners();
  }

  Future<void> mainPostSearchDispatch(
      {required userId, required String keyword}) async {
    final url =
        Uri.parse("http://58.150.133.91:80/together/post/getPostForKeyword");
    final headers = {'Content-Type': 'application/json'};
    final data = {
      "userId": userId,
      "keyword": keyword,
    };

    final response =
        await http.post(url, headers: headers, body: jsonEncode(data));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final jsonResponse = jsonDecode(response.body) as List<dynamic>;
      print("메인 커뮤니티 검색 : 성공");

      // 응답 데이터를 PostCardModel 리스트로 파싱
      _postList = _insertAds(
          jsonResponse.map((data) => PostCardModel.fromJson(data)).toList(), 5);
      _isSearched = true;
      _searchText = keyword;
    } else {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return;
    }
  }

  Future<void> scrollEndAddPostDispatch({required int? userId}) async {
    if (!_isSearched) {
      final url =
          Uri.parse("http://58.150.133.91:80/together/post/getAllPostForMain");
      final headers = {'Content-Type': 'application/json'};
      final data = {
        "userId": userId,
      };

      final response =
          await http.post(url, headers: headers, body: jsonEncode(data));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final jsonResponse = jsonDecode(response.body) as List<dynamic>;
        print("메인 커뮤니티 : 성공");

        List<PostCardModel> currentPostList =
            List.from(_postList!.where((element) => !element.isAd));

        // 응답 데이터를 PostCardModel 리스트로 파싱
        _postList = _insertAds(
            currentPostList +
                jsonResponse
                    .map((data) => PostCardModel.fromJson(data))
                    .toList(),
            5);
      } else {
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
        return;
      }
    } else {
      final url =
          Uri.parse("http://58.150.133.91:80/together/post/getPostForKeyword");
      final headers = {'Content-Type': 'application/json'};
      final data = {"keyword": _searchText};

      final response =
          await http.post(url, headers: headers, body: jsonEncode(data));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final jsonResponse = jsonDecode(response.body) as List<dynamic>;
        print("메인 커뮤니티 검색 : 성공");

        List<PostCardModel> currentPostList =
            List.from(_postList!.where((element) => !element.isAd));

        // 응답 데이터를 PostCardModel 리스트로 파싱
        _postList = _insertAds(
            currentPostList +
                jsonResponse
                    .map((data) => PostCardModel.fromJson(data))
                    .toList(),
            5);
      } else {
        print("${response.statusCode} : ${response.body}");
        return;
      }
    }
    notifyListeners();
  }

  Future<void> onChangePostLike({required int index}) async {
    _postList![index].postLikeId = !_postList![index].postLikeId;
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
