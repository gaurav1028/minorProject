import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  final docs;
  final int index;
  final String type;
  Question(this.docs, this.index, this.type);

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
          height: 50,
          margin: EdgeInsets.all(10),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 2,
              ),
              Column(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      docs[index]['question'],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'View Answers',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // if (type == 'doctors')
                      Text(
                        'Answer it!',
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
