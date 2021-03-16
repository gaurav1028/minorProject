import 'package:flutter/material.dart';
import 'package:minorProject/provider/user.dart';
import '../../screens/auth_screen.dart';
import 'package:provider/provider.dart';

class MainButton extends StatelessWidget {
  final String name;

  MainButton(this.name);
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text(name),
      onPressed: () {
        Provider.of<UserType>(context, listen: false).setAndFetchValues(name);
        Navigator.of(context).pushNamed(
          AuthScreen.routeName,
          arguments: name,
        );
      },
    );
  }
}
