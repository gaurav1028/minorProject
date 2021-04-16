import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:minorProject/provider/user.dart';
import 'package:provider/provider.dart';

class InputField extends StatefulWidget {
  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  final textController = TextEditingController();
  void submitData(ctx) async {
    var text = textController.text;
    if (text == null || text.length == 0) {
      return;
    }
    final time = DateTime.now().toIso8601String();
    final uid = Provider.of<UserType>(context, listen: false).uid;
    final id = time + uid;
    Firestore.instance.collection('faqs').document(id).setData(
      {
        'id': id,
        'question': text,
      },
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Text(
                'Please ask anything you want!!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Your Question:',
                  labelStyle: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                //onChanged: (value) => inputTitle = value,
                controller: textController,
                onSubmitted: (_) => submitData(context),
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                child: Text('Ask Question'),
                textColor: Theme.of(context).textTheme.button.color,
                color: Theme.of(context).primaryColor,
                onPressed: () => submitData(context),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
