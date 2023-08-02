import 'package:flutter/material.dart';
import 'package:swag_cross_app/models/post_card_model.dart';

class CurrentPostProvider extends ChangeNotifier {
  late PostCardModel _postData;

  PostCardModel get postData => _postData;

  void changePostData(PostCardModel data) {
    _postData = data;
    notifyListeners();
  }
}