import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minorProject/provider/user.dart';
import 'package:minorProject/widgets/doctorList/doctorList.dart';
import 'package:provider/provider.dart';

class DoctorListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Find Doctors"),
      ),
      body: DoctorList(Provider.of<UserType>(context, listen: false).uid),
    );
  }
}
