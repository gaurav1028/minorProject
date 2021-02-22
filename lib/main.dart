import 'package:chatapp/screens/friend_list_screen.dart';
import 'package:chatapp/screens/tab_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'screens/splash_screen.dart';
import 'screens/auth_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/feed_screen.dart';
import 'providers/user.dart';
import 'screens/friend_request_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: Colors.black,
          backgroundColor: Colors.white,
          accentColor: Colors.white,
          buttonTheme: ButtonTheme.of(context).copyWith(
            buttonColor: Colors.black,
            textTheme: ButtonTextTheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          primaryIconTheme: IconThemeData(
            color: Colors.black,
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          appBarTheme: AppBarTheme(
            color: Colors.white,
          )),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SplashScreen();
          }
          if (snapshot.hasData) {
            return TabScreen(snapshot.data.uid);
          }
          return AuthScreen();
        },
      ),
      routes: {},
    );
  }
}
