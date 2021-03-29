import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:minorProject/provider/user.dart';
import 'package:minorProject/screens/selection_screen.dart';
import 'package:provider/provider.dart';
import 'screens/splash_screen.dart';
import 'screens/tab_screen.dart';
import 'screens/auth_screen_customer.dart';
import 'screens/auth_screen_doctor.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: UserType(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.blue,
          backgroundColor: Colors.purple,
          accentColor: Colors.red,
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
              return TabScreen(snapshot.data.uid);
            }
            return SelectionScreen();
          },
        ),
        routes: {
          AuthDoctorScreen.routeName: (context) => AuthDoctorScreen(),
          AuthCustomerScreen.routeName: (context) => AuthCustomerScreen(),
        },
      ),
    );
  }
}
