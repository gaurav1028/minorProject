import 'package:flutter/material.dart';

class DoctorTile extends StatefulWidget {
  final doctor;
  Function handler;
  int type;
  DoctorTile(this.doctor, this.handler, this.type);

  @override
  _DoctorTileState createState() => _DoctorTileState();
}

class _DoctorTileState extends State<DoctorTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 6,
      ),
      child: Card(
        elevation: 5,
        color: Colors.grey[350],
        child: Container(
          margin: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  CircleAvatar(
                    backgroundImage: widget.doctor['user_img'] == null
                        ? AssetImage(
                            "assets/placeholder.png",
                          )
                        : NetworkImage(
                            widget.doctor['user_img'],
                          ),
                    radius: 20,
                  ),
                  SizedBox(width: 5),
                  Text(
                    widget.doctor['username'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  RaisedButton(
                    onPressed: widget.type == 0
                        ? () {
                            widget.handler(widget.doctor['user_id'],
                                widget.doctor['username']);
                            setState(() {
                              widget.type = 2;
                            });
                          }
                        : null,
                    child: LoadButtonText(widget.type),
                  ),
                  SizedBox(
                    width: 5,
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

class LoadButtonText extends StatelessWidget {
  final int type;
  LoadButtonText(this.type);
  var text;

  @override
  Widget build(BuildContext context) {
    if (type == 0) {
      text = 'Send Request';
    } else if (type == 1) {
      text = 'Message';
    } else if (type == 2) {
      text = 'Request Pending';
    }

    return Text(text);
  }
}
