import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:minorProject/widgets/portal_screen/answer.dart';

class AnswerList extends StatefulWidget {
  final id;
  AnswerList(this.id);

  @override
  _AnswerListState createState() => _AnswerListState();
}

class _AnswerListState extends State<AnswerList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection('faqs/${widget.id['id']}/answers')
          .snapshots(),
      builder: (context, ss) {
        if (ss.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          final docs = ss.data.documents;
          print(docs.length);
          if (docs.length < 1) {
            return Center(
              child: Text(
                'No answers to show',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
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
                          Answer(
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
    );
  }
}
