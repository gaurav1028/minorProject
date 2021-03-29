import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minorProject/provider/user.dart';
import 'package:minorProject/screens/chat_screen.dart';
import 'package:minorProject/screens/home_screen.dart';
import 'package:minorProject/screens/portal_screen.dart';
import 'package:minorProject/screens/request_list_screen.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:minorProject/screens/doctor_list_screen.dart';

class TabScreen extends StatefulWidget {
  final String type;
  TabScreen(this.type);
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  List<Map<String, Object>> _pages;
  List<Map<String, Object>> _pages2;

  var _selectedPageIndex = 0;
  var type = 'customer';

  Future<void> getData(ctx) async {
    final user = await FirebaseAuth.instance.currentUser();
    print(user);
    final userDoc = await Firestore.instance
        .collection('users')
        .document('${user.uid}')
        .get();

    type = userDoc['type'];
    Provider.of<UserType>(ctx, listen: false).setType(type);
    Provider.of<UserType>(ctx, listen: false).setUid(user.uid);
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  initState() {
    _pages2 = [
      {
        'page': PortalScreen(),
        'title': 'Portal',
      },
      {
        'page': HomeScreen(),
        'title': 'Feed',
      },
      {
        'page': FriendRequestsScreen(),
        'title': 'DoctorList',
      },
      {
        'page': ChatScreen(),
        'title': 'Chat',
      },
    ];
    _pages = [
      {
        'page': PortalScreen(),
        'title': 'Portal',
      },
      {
        'page': HomeScreen(),
        'title': 'Feed',
      },
      {
        'page': DoctorListScreen(),
        'title': 'RequestList',
      },
      {
        'page': ChatScreen(),
        'title': 'Chat',
      },
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Scaffold(
            body: type == 'customers'
                ? _pages[_selectedPageIndex]['page']
                : _pages2[_selectedPageIndex]['page'],
            bottomNavigationBar: BottomNavigationBar(
              onTap: _selectPage,
              fixedColor: Colors.black,
              type: BottomNavigationBarType.fixed,
              currentIndex: _selectedPageIndex,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  title: Text(""),
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.search,
                  ),
                  title: Text(""),
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.list,
                  ),
                  title: Text(""),
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.all_inbox,
                  ),
                  title: Text(""),
                ),
                // if (_imageUrl != null)
                //   BottomNavigationBarItem(
                //     icon: CircleAvatar(
                //       backgroundImage:  NetworkImage(_imageUrl),
                //       backgroundColor: Colors.white,
                //     ),
                //     title: Text(""),
                //   ),
              ],
            ),
          );
        }
      },
    );
  }
}
