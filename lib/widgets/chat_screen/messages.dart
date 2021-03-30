import 'package:minorProject/widgets/chat_screen/image_message.dart';

import 'message_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  final String userid;
  Messages(this.userid);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (context, futuresnapshot) {
        if (futuresnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return StreamBuilder(
          stream: Firestore.instance
              .collection('chat/${futuresnapshot.data.uid}/$userid')
              .orderBy('createdAt', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final chatDocs = snapshot.data.documents;
            return ListView.builder(
              reverse: true,
              itemCount: chatDocs.length,
              itemBuilder: (context, index) => chatDocs[index]['type'] == 0
                  ? MessageBubble(
                      chatDocs[index]['text'],
                      chatDocs[index]['sender'] == futuresnapshot.data.uid,
                      key: ValueKey(
                        chatDocs[index].documentID,
                      ),
                    )
                  : ImageMessage(
                      chatDocs[index]['sender'] == futuresnapshot.data.uid,
                      chatDocs[index]['type'],
                      chatDocs[index],
                    ),
            );
          },
        );
      },
    );
  }
}
