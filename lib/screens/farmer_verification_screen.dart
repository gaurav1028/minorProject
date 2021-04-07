import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:minorProject/provider/user.dart';
import 'package:provider/provider.dart';

class FarmerVerificationScreen extends StatefulWidget {
  static const routeName = '/farmer-verification-screen';
  FarmerVerificationScreen({Key key}) : super(key: key);

  @override
  _FarmerVerificationScreenState createState() =>
      _FarmerVerificationScreenState();
}

class _FarmerVerificationScreenState extends State<FarmerVerificationScreen> {
  bool isLoading = false;
  bool done = false;
  Future<bool> _trySubmit() async {
    setState(() {
      isLoading = true;
    });

    final uid = Provider.of<UserType>(context, listen: false).uid;
    final data = await Firestore.instance.document('farmers/$uid').get();
    final bool s = data['farmer'];
    if (s == false) {
      print('object');
      // ignore: deprecated_member_use

      setState(
        () {
          isLoading = false;
        },
      );
      return false;
    } else {
      await Firestore.instance.document('users/$uid').setData(
        {
          'isFarmer': true,
        },
        merge: true,
      );
      setState(
        () {
          isLoading = false;
          done = true;
        },
      );

      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify Your Farmer Status'),
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : RaisedButton(
                onPressed: done ? null : () => _trySubmit(),
                child: done ? Text('Already Verifed') : Text('Verify'),
              ),
      ),
    );
  }
}
