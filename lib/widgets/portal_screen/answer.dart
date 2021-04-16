import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final docs;
  final int index;
  Answer(this.docs, this.index);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
      child: Card(
        elevation: 10,
        child: Container(
          margin: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          child: Text(
            '${index + 1})\t${docs[index]['answer']}',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
