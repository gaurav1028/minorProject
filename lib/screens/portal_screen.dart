import 'package:flutter/material.dart';
import 'package:minorProject/provider/user.dart';
import 'package:minorProject/widgets/portal_screen/question_list.dart';
import 'package:provider/provider.dart';

class PortalScreen extends StatelessWidget {
  void addQuestion() {}
  @override
  Widget build(BuildContext context) {
    final userType = Provider.of<UserType>(context).type;
    return Scaffold(
      appBar: AppBar(
        actions: [
          if (userType == 'customers')
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
