import 'package:flutter/material.dart';

class MainNavigationProvider extends ChangeNotifier {
  int _navigationIndex = 0;

  int get navigationIndex => _navigationIndex;

  void changeIndex(int index) {
    if (_navigationIndex == index) return;
    _navigationIndex = index;
    notifyListeners();
  }
}