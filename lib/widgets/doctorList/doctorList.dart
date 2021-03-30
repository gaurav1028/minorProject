import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import './doctorTile.dart';

class DoctorList extends StatelessWidget {
  final userId;

  DoctorList(this.userId);

  List<String> doctors = [];
  List<String> requests = [];
  List<String> requests_sent = [];

  Future<bool> sendRequest(String doctorId, String doctorUsername) async {
    final userData =
        await Firestore.instance.document('customers/$userId').get();
    print(userData);
    Map<String, dynamic> requestData = {
      'senderId': userId,
      'senderUsername': userData['username'],
      'status': false,
    };

    Map<String, dynamic> requestSentData = {
      'sentTo': doctorId,
      'username': doctorUsername,
      'status': false,
    };

    print(requestData);
    print(requestSentData);
    await Firestore.instance
        .collection('doctors/$doctorId/requests')
        .document('$userId')
        .setData(requestData);

    await Firestore.instance
        .collection('customers/$userId/request_sent')
        .document('$doctorId')
        .setData(requestSentData);

    return true;
  }

  Future<void> getUserData() async {
    final friendsData = await Firestore.instance
        .collection('customers/$userId/doctors')
        .getDocuments();

    final requestSentData = await Firestore.instance
        .collection('customers/$userId/request_sent')
        .getDocuments();

    print(friendsData.documents.length);
    print(requestSentData.documents.length);

    List.generate(requestSentData.documents.length, (index) {
      requests_sent.add(requestSentData.documents[index].data['sentTo']);
    });

    List.generate(friendsData.documents.length, (index) {
      doctors.add(friendsData.documents[index].data['uid']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getUserData(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else
            return StreamBuilder(
              stream: Firestore.instance.collection('doctors').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  final doctorData = snapshot.data.documents;
                  // return Text('tp');
                  return ListView.builder(
                    itemCount: doctorData.length,
                    itemBuilder: (ctx, index) {
                      final id = doctorData[index]['user_id'];
                      int type = 0;
                      if (userId == id) return Container();
                      if (doctors.contains(id)) {
                        type = 1; //doctor
                      }
                      if (requests_sent.contains(id)) {
                        type = 2; //you sent them request
                      }
                      print(doctorData[index]);
                      return DoctorTile(doctorData[index], sendRequest, type);
                    },
                  );
                }
              },
            );
        });
  }
}
