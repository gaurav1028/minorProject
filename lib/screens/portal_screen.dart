import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minorProject/provider/user.dart';
import 'package:minorProject/widgets/portal_screen/input_field.dart';
import 'package:minorProject/widgets/portal_screen/question_list.dart';
import 'package:provider/provider.dart';

class PortalScreen extends StatefulWidget {
  PortalScreen({Key key}) : super(key: key);

  @override
  _PortalScreenState createState() => _PortalScreenState();
}

class _PortalScreenState extends State<PortalScreen> {
  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: InputField(),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final userType = Provider.of<UserType>(context).type;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        actions: [
          if (userType != 'doctors')
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                startAddNewTransaction(context);
              },
            )
        ],
        title: Text('Portal'),
      ),
      body: QuestionList(),
    );
  }
}
