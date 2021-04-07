import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_list_item.dart';

class UserList extends StatelessWidget {
  final uid;
  final type;
  UserList(this.uid, this.type);

  @override
  Widget build(BuildContext context) {
    var str;
    if (type == 'doctors') {
      str = 'patients';
    } else {
      str = 'doctors';
    }
    print('$type, $uid, $str');
    return StreamBuilder(
      stream: Firestore.instance.collection('$type/$uid/$str').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDocs = snapshot.data.documents;
        return chatDocs.length < 1
            ? Center(
                child: Text('No users'),
              )
            : ListView.separated(
                padding: EdgeInsets.all(10),
                separatorBuilder: (BuildContext context, int index) {
                  return Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      height: 0.5,
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: Divider(),
                    ),
                  );
                },
                itemCount: chatDocs.length,
                itemBuilder: (context, index) => chatDocs[index]['uid'] == uid
                    ? Container()
                    : UserListItem(
                        chatDocs[index]['username'],
                        chatDocs[index]['uid'],
                        chatDocs[index]['user_img'],
                        key: ValueKey(
                          chatDocs[index].documentID,
                        ),
                      ),
              );

        //  ListView.builder(
        //     itemBuilder: (context, index) => chatDocs[index]['uid'] == uid
        //         ? Container()
        //         : UserListItem(
        //             chatDocs[index]['username'],
        //             chatDocs[index]['uid'],
        //             key: ValueKey(
        //               chatDocs[index].documentID,
        //             ),
        //           ),
        //     itemCount: chatDocs.length,
        //   );
      },
    );
  }
}
