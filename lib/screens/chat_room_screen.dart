import 'package:flutter/material.dart';
import 'package:minorProject/provider/user.dart';
import 'package:minorProject/widgets/chat_screen/messages.dart';
import 'package:minorProject/widgets/chat_screen/new_message.dart';
import 'package:provider/provider.dart';

class ChatRoomScreen extends StatelessWidget {
  static const routeName = '/chat-room-screen';

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;
    final username = args['username'];
    final id = args['userid'];
    final type = Provider.of<UserType>(context).type;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          username,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Messages(id),
            ),
            NewMessage(id, type),
          ],
        ),
      ),
    );
  }
}
