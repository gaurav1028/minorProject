import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import './question.dart';
import 'package:provider/provider.dart';
import '../../provider/user.dart';

class QuestionList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          final docs = snapshot.data.documents;
          print(Provider.of<UserType>(context, listen: false).type);
          if (docs.length < 1) {
            return Center(
              child: Text('No posts to show'),
            );
          }

          return CustomScrollView(
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate(
                  List.generate(
                    docs.length,
                    (int index) {
                      return Column(
                        children: <Widget>[
                          Question(
                            docs,
                            index,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        }
      },
      future: Firestore.instance.collection('faqs/').getDocuments(),
    );
  }
}
