import 'package:flutter/material.dart';
import 'package:minorProject/screens/home_screen.dart';
import 'package:minorProject/screens/portal_screen.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TabScreen extends StatefulWidget {
  final String uid;
  TabScreen(this.uid);
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  List<Map<String, Object>> _pages;

  var _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  initState() {
    _pages = [
      {
        'page': PortalScreen(),
        'title': 'Portal',
      },
      {
        'page': HomeScreen(),
        'title': 'Feed',
      },
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPageIndex]['page'],
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
}
