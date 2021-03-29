import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../widgets/auth/auth_form.dart';
import '../widgets/auth/auth_form_doctor.dart';
import 'splash_screen.dart';
import 'tab_screen.dart';

class AuthDoctorScreen extends StatefulWidget {
  static const routeName = "/auth-form-doctor";
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthDoctorScreen> {
  var isLoading = false;

  void _authDoctorFormSubmit(
    String email,
    String username,
    String password,
    String address,
    String qualification,
    bool isLogin,
    BuildContext ctx,
  ) async {
    final _auth = FirebaseAuth.instance;
    AuthResult authResult;
    setState(() {
      isLoading = true;
    });
    try {
      if (isLogin) {
        print(username);
        authResult = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        await Firestore.instance
            .collection('doctors')
            .document(authResult.user.uid)
            .setData(
          {
            'email': email,
            'username': username,
            'user_id': authResult.user.uid,
            'address': address,
            'qualification': qualification,
          },
        );

        await Firestore.instance
            .collection('users')
            .document(authResult.user.uid)
            .setData(
          {
            'type': 'vet',
          },
        );
      }
    } on PlatformException catch (err) {
      var message = 'An error occured,please check credentials';

      if (err.message != null) {
        message = err.message;
      }
      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
      setState(() {
        isLoading = false;
      });
      return;
    } catch (err) {
      print(err);
      setState(
        () {
          isLoading = false;
        },
      );
      return;
    }
    Navigator.of(ctx).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthDoctorForm(_authDoctorFormSubmit, isLoading),
    );
  }
}
