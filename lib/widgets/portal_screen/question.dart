import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:minorProject/screens/answer_screen.dart';

class Question extends StatelessWidget {
  final docs;
  final int index;
  final id;
  final String type;
  Question(this.docs, this.index, this.id, this.type);

  @override
  Widget build(BuildContext context) {
    Future<void> _showMyDialog() async {
      final controller = TextEditingController();
      void submit() {
        final text = controller.text;
        if (text.length < 4) {
          return;
        }
        final id = docs[index]['id'];
        Firestore.instance.collection('faqs/$id/answers').document().setData(
          {
            'answer': text,
          },
        );
        Navigator.of(context).pop();
      }

      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Your Answer'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  TextField(
                    autocorrect: true,
                    controller: controller,
                    textCapitalization: TextCapitalization.sentences,
                    enableSuggestions: true,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Enter your answer here!!',
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Submit'),
                onPressed: submit,
              ),
            ],
          );
        },
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 5,
      ),
      child: Card(
        elevation: 5,
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  docs[index]['question'],
                  style: TextStyle(
                    fontSize: 30,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 1,
                width: double.maxFinite,
                color: Colors.grey,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        AnswerScreen.routeName,
                        arguments: {
                          'id': docs[index]['id'],
                        },
                      );
                    },
                    child: Text(
                      'View Answer',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  if (type == 'doctors')
                    Container(
                      width: 1,
                      height: 20,
                      color: Colors.grey,
                    ),
                  if (type == 'doctors')
                    TextButton(
                      onPressed: _showMyDialog,
                      child: Text(
                        'Answer it!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
