import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class User with ChangeNotifier {
  String _username;
  String _uid;
  String _imageUrl;
  String _email;

  Future<void> setAndFetchValues() async {
    final user = await FirebaseAuth.instance.currentUser();
    _uid = user.uid;
    final userDoc =
        await Firestore.instance.collection('users').document('$_uid').get();

    _email = userDoc['email'];
    _username = userDoc['username'];
    _imageUrl = userDoc['image_url'];
    notifyListeners();
  }

  String get username {
    return _username;
  }

  String get uid {
    return _uid;
  }

  String get email {
    return _email;
  }

  String get imageUrl {
    return _imageUrl;
  }
}
