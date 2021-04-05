import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  SettingScreen({Key key}) : super(key: key);
  static const routeName = '/settings';

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  String dropdownValue = 'One';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: <Widget>[
          InkWell(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 4,
              margin: EdgeInsets.all(10),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Select your langague ?',
                    ),
                    DropdownButton<String>(
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(color: Colors.black),
                      underline: Container(
                        height: 2,
                        color: Colors.green,
                      ),
                      onChanged: (newValue) {
                        setState(
                          () {
                            dropdownValue = newValue;
                          },
                        );
                      },
                      items: <String>['One', 'Two', 'Free', 'Four']
                          .map<DropdownMenuItem<String>>(
                        (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        },
                      ).toList(),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.red,
                      Colors.pink,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
          InkWell(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 4,
              margin: EdgeInsets.all(10),
              child: Container(
                padding: const EdgeInsets.all(15),
                child: Text('Log Out'),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.red,
                      Colors.pink,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
