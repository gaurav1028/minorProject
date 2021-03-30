import 'package:minorProject/screens/chat_room_screen.dart';
import 'package:flutter/material.dart';

class UserListItem extends StatelessWidget {
  final String username;
  final String userid;
  final Key key;

  UserListItem(
    this.username,
    this.userid, {
    this.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(username),
      onTap: () {
        Navigator.of(context).pushNamed(ChatRoomScreen.routeName, arguments: {
          'userid': userid,
          'username': username,
        });
      },
    );
  }
}
