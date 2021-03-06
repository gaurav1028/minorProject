import 'dart:io';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:minorProject/provider/user.dart';
import 'package:minorProject/screens/settings_screen.dart';
import 'package:minorProject/widgets/profile/bioData.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final uid = Provider.of<UserType>(context).uid;
    final type = Provider.of<UserType>(context).type;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).pushNamed(SettingScreen.routeName);
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: Firestore.instance.document('$type/$uid').get(),
        builder: (ctx, ss) {
          if (ss.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final userData = ss.data;
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 40),
                    CircleAvatar(
                      backgroundImage: userData['user_img'] == null
                          ? AssetImage(
                              "assets/placeholder.png",
                            )
                          : NetworkImage(
                              userData['user_img'],
                            ),
                      radius: 100,
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    BioData(userData),

                    // SizedBox(height: 20),
                    // Row(
                    //   mainAxisSize: MainAxisSize.min,
                    //   children: <Widget>[
                    //     FlatButton(
                    //       child: Icon(
                    //         Icons.message,
                    //         color: Colors.white,
                    //       ),
                    //       color: Colors.grey,
                    //       onPressed: () {},
                    //     ),
                    //     SizedBox(width: 10),
                    //     FlatButton(
                    //       child: Icon(
                    //         Icons.add,
                    //         color: Colors.white,
                    //       ),
                    //       color: Theme.of(context).accentColor,
                    //       onPressed: () {},
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(height: 40),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: 50),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: <Widget>[
                    //       Column(
                    //         children: <Widget>[
                    //           Text(
                    //             random.nextInt(10000).toString(),
                    //             style: TextStyle(
                    //               fontWeight: FontWeight.bold,
                    //               fontSize: 22,
                    //             ),
                    //           ),
                    //           SizedBox(height: 4),
                    //           Text(
                    //             "Posts",
                    //             style: TextStyle(),
                    //           ),
                    //         ],
                    //       ),
                    //       Column(
                    //         children: <Widget>[
                    //           Text(
                    //             random.nextInt(10000).toString(),
                    //             style: TextStyle(
                    //               fontWeight: FontWeight.bold,
                    //               fontSize: 22,
                    //             ),
                    //           ),
                    //           SizedBox(height: 4),
                    //           Text(
                    //             "Friends",
                    //             style: TextStyle(),
                    //           ),
                    //         ],
                    //       ),
                    //       Column(
                    //         children: <Widget>[
                    //           Text(
                    //             random.nextInt(10000).toString(),
                    //             style: TextStyle(
                    //               fontWeight: FontWeight.bold,
                    //               fontSize: 22,
                    //             ),
                    //           ),
                    //           SizedBox(height: 4),
                    //           Text(
                    //             "Groups",
                    //             style: TextStyle(),
                    //           ),
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(height: 20),
                    // GridView.builder(
                    //   shrinkWrap: true,
                    //   physics: NeverScrollableScrollPhysics(),
                    //   primary: false,
                    //   padding: EdgeInsets.all(5),
                    //   itemCount: 15,
                    //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //     crossAxisCount: 3,
                    //     childAspectRatio: 200 / 200,
                    //   ),
                    //   itemBuilder: (BuildContext context, int index) {
                    //     return Padding(
                    //       padding: EdgeInsets.all(5.0),
                    //       child: Image.asset(
                    //         "assets/placeholder.png",
                    //         fit: BoxFit.cover,
                    //       ),
                    //     );
                    //   },
                    // ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
