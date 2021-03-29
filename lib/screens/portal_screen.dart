import 'package:flutter/material.dart';
import 'package:minorProject/widgets/portal_screen/question_list.dart';

class PortalScreen extends StatelessWidget {
  void addQuestion() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: addQuestion,
          )
        ],
        title: Text('Portal'),
      ),
      body: QuestionList(),
    );
  }
}
