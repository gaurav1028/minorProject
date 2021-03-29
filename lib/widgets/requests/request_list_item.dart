import 'package:flutter/material.dart';

class RequestListItem extends StatelessWidget {
  final String username;
  final String uid;
  final Function acceptHandler;
  final Function deleteHandler;

  RequestListItem(
    this.username,
    this.uid,
    this.acceptHandler,
    this.deleteHandler,
  );

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
              Row(
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    username,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                children: [
                  RaisedButton(
                    onPressed: () {
                      acceptHandler(uid, username);
                    },
                    child: Text('Accept'),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  RaisedButton(
                    onPressed: () {
                      deleteHandler(uid);
                    },
                    child: Text('Delete'),
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
