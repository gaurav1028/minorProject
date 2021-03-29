import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minorProject/widgets/requests/request_list.dart';

class FriendRequestsScreen extends StatelessWidget {
  static const routeName = '/requests';
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (ctx, snapshot) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Requests',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: snapshot.connectionState == ConnectionState.waiting
            ? CircularProgressIndicator()
            : RequestList(snapshot.data.uid),
      ),
    );
  }
}
