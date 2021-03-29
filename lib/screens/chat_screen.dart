import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:minorProject/provider/user.dart';
import 'package:minorProject/widgets/chat_screen/user_list.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  static const routeName = "/chat-screen";
  Widget build(BuildContext context) {
    final user = Provider.of<UserType>(context, listen: false);
    print(user.type);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chatroom',
        ),
      ),
      body: UserList(
        user.uid,
        user.type,
      ),
    );
  }
}
