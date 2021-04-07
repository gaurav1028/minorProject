import 'package:minorProject/screens/chat_room_screen.dart';
import 'package:flutter/material.dart';

class UserListItem extends StatelessWidget {
  final String username;
  final String userid;
  final String userImage;
  final Key key;

  UserListItem(
    this.username,
    this.userid,
    this.userImage, {
    this.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListTile(
        contentPadding: EdgeInsets.all(0),
        leading: Stack(
          children: <Widget>[
            CircleAvatar(
              backgroundImage: userImage == null
                  ? AssetImage(
                      'assets/placeholder.png',
                    )
                  : NetworkImage(userImage),
              radius: 25,
            ),
          ],
        ),
        title: Text(
          "$username",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: () {
          Navigator.of(context).pushNamed(
            ChatRoomScreen.routeName,
            arguments: {
              'userid': userid,
              'username': username,
            },
          );
        },
      ),
    );

    // ListTile(
    //   title: Text(username),
    //   onTap: () {
    //     Navigator.of(context).pushNamed(ChatRoomScreen.routeName, arguments: {
    //       'userid': userid,
    //       'username': username,
    //     });
    //   },
    // );
  }
}
