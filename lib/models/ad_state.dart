import 'package:flutter/material.dart';

class AdState extends ChangeNotifier {
  bool _isAdWatched = false;

  bool get isAdWatched => _isAdWatched;

  void setAdWatched(bool value) {
    _isAdWatched = value;
    notifyListeners();
  }
}
