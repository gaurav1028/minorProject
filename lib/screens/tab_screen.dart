import 'package:chatapp/screens/friend_request_screen.dart';
import 'package:chatapp/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'create_post_screen.dart';
import 'feed_screen.dart';
import 'friend_list_screen.dart';
import 'profile_screen.dart';
import 'all_screen.dart';
import '../providers/user.dart';
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
        'page': FeedScreen(widget.uid),
        'title': 'Feed',
      },
      {
        'page': AllScreen(),
        'title': 'Feed',
      },
      {
        'page': CreatePostScreen(),
        'title': 'Feed',
      },
      {
        'page': FriendRequestsScreen(),
        'title': 'Feed',
      },
      {
        'page': ProfileScreen(),
        'title': 'Favorites',
      }
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final url = Provider.of<User>(context).imageUrl;
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
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_box,
            ),
            title: Text(""),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite_border,
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

          BottomNavigationBarItem(
            icon: CircleAvatar(
              backgroundImage: url == null
                  ? AssetImage('assets/download.png')
                  : NetworkImage(url),
              backgroundColor: Colors.white,
            ),
            title: Text(""),
          ),
        ],
      ),
    );
  }
}
