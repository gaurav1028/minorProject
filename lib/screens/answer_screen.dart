import 'package:flutter/material.dart';
import 'package:minorProject/widgets/portal_screen/answer_list.dart';

class AnswerScreen extends StatelessWidget {
  static const routeName = '/answers';
  const AnswerScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    print(id);
    return Scaffold(
      appBar: AppBar(
        title: Text('View Answers'),
      ),
      body: AnswerList(id),
    );
  }
}
