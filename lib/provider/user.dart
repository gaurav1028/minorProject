import 'package:flutter/material.dart';

class UserType with ChangeNotifier {
  String _type;
  String _uid;
  bool _isFarmer;

  void setAndFetchValues(String type) {
    _type = type;
    notifyListeners();
  }

  void setStatus(bool isFarmer) {
    _isFarmer = isFarmer;
    notifyListeners();
  }

  void setType(String type) {
    _type = type;
  }

  void setUid(String uid) {
    _uid = uid;
  }

  String get type {
    return _type;
  }

  String get uid {
    return _uid;
  }

  bool get isFarmer {
    return _isFarmer;
  }
}
