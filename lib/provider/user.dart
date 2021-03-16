import 'package:flutter/material.dart';

class UserType with ChangeNotifier {
  String _type;
  bool _isFarmer;
  void setAndFetchValues(String type) {
    _type = type;
    notifyListeners();
  }

  void setStatus(bool isFarmer) {
    _isFarmer = isFarmer;
    notifyListeners();
  }

  String get type {
    return _type;
  }

  bool get isFarmer {
    return _isFarmer;
  }
}
