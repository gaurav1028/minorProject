import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<void> getData() async {
      final user = await FirebaseAuth.instance.currentUser();
      print(user);
      final userDoc = await Firestore.instance
          .collection('users')
          .document('${user.uid}')
          .get();
      print(userDoc['type']);
    }

    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: Text('Press'),
          onPressed: () {
            FirebaseAuth.instance.signOut();
            //getData();
          },
        ),
      ),
    );
  }
}
