import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  final docs;
  final int index;
  Question(this.docs, this.index);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 6,
      ),
      child: Card(
        elevation: 5,
        child: Container(
          margin: EdgeInsets.all(10),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 5,
              ),
              Column(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      docs[index]['question'],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        'View Answers',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
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
