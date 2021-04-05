import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:minorProject/provider/user.dart';
import 'package:minorProject/screens/chat_room_screen.dart';
import 'package:minorProject/screens/selection_screen.dart';
import 'package:minorProject/screens/settings_screen.dart';
import 'package:provider/provider.dart';
import 'screens/splash_screen.dart';
import 'screens/tab_screen.dart';
import 'screens/auth_screen_customer.dart';
import 'screens/auth_screen_doctor.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Future<String> getData(ctx) async {
    final user = await FirebaseAuth.instance.currentUser();
    print(user);
    final userDoc = await Firestore.instance
        .collection('users')
        .document('${user.uid}')
        .get();

    String type = userDoc['type'];
    Provider.of<UserType>(ctx, listen: false).setType(type);
    Provider.of<UserType>(ctx, listen: false).setUid(user.uid);
    return type;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: UserType(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.amber,
          canvasColor: Color.fromRGBO(255, 254, 220, 1),
          fontFamily: 'Raleway',
          tabBarTheme: TabBarTheme(
            labelColor: Colors.pink[50],
          ),
          textTheme: ThemeData.light().textTheme.copyWith(
                body1: TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                body2: TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                title: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'RobotoCondensed',
                ),
              ),
          buttonTheme: ButtonTheme.of(context).copyWith(
            buttonColor: Colors.red,
            textTheme: ButtonTextTheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          primaryIconTheme: IconThemeData(
            color: Colors.green,
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.onAuthStateChanged,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SplashScreen();
            }
            if (snapshot.hasData) {
              return FutureBuilder(
                builder: (ctx, ss) {
                  if (ss.connectionState == ConnectionState.waiting) {
                    return SplashScreen();
                  } else {
                    return TabScreen(ss.data);
                  }
                },
                future: getData(context),
              );
            }
            return SelectionScreen();
          },
        ),
        routes: {
          AuthDoctorScreen.routeName: (context) => AuthDoctorScreen(),
          AuthCustomerScreen.routeName: (context) => AuthCustomerScreen(),
          ChatRoomScreen.routeName: (context) => ChatRoomScreen(),
          SettingScreen.routeName: (context) => SettingScreen(),
        },
      ),
    );
  }
}
