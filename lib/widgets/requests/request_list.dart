import 'package:firebase_auth/firebase_auth.dart';
import 'package:minorProject/provider/user.dart';
import 'package:minorProject/widgets/requests/request_list_item.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class RequestList extends StatelessWidget {
  final String userId;
  RequestList(this.userId);

  Future<void> acceptRequest(String id, String username) async {
    final userDoc = await Firestore.instance.document('doctors/$userId').get();

    final ref =
        Firestore.instance.collection('doctors/$userId/requests').document(id);

    final ref2 = Firestore.instance
        .collection('customers/$id/request_sent')
        .document(userId);

    if (ref2 == null) {
      return;
    }

    if (ref == null) {
      return;
    }
    await Firestore.instance
        .collection('customers/$id/doctors')
        .document(userId)
        .setData(
      {
        'uid': userId,
        'username': userDoc['username'],
      },
    );
    await Firestore.instance
        .collection('doctors/$userId/patients')
        .document(id)
        .setData(
      {
        'uid': id,
        'username': username,
      },
    );

    ref.delete();
    ref2.delete();
  }

  void deleteRequest(String id) {
    final ref = Firestore.instance
        .collection('customers/$userId/requests')
        .document(id);
    if (ref == null) {
      return;
    }
    ref.delete();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream:
          Firestore.instance.collection('doctors/$userId/requests').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          final requestDoc = snapshot.data.documents;

          return requestDoc.length == 0
              ? Center(child: Text('No requests found'))
              : ListView.builder(
                  itemCount: requestDoc.length,
                  itemBuilder: (context, index) => RequestListItem(
                    requestDoc[index]['senderUsername'],
                    requestDoc[index]['senderId'],
                    acceptRequest,
                    deleteRequest,
                  ),
                );
        }
      },
    );
  }
}
