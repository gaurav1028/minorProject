import 'package:flutter/material.dart';
import 'package:minorProject/provider/user.dart';
import 'package:provider/provider.dart';

class BioData extends StatelessWidget {
  final userData;

  const BioData(this.userData, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final type = Provider.of<UserType>(context).type;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 4,
      margin: EdgeInsets.all(10),
      child: Container(
        padding: const EdgeInsets.all(15),
        width: width * 0.9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Name: ${userData['username']}',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Email: ${userData['email']}',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Address: ${userData['address']}',
              style: TextStyle(fontSize: 20),
            ),
            if (type == 'doctors')
              Text(
                'Qualification: ${userData['qualification']}',
                style: TextStyle(fontSize: 20),
              ),
            Text(
              'Address: ${userData['address']}',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Colors.grey,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
