import 'package:flutter/material.dart';
import '../widgets/main_screen/button.dart';
import './auth_screen_doctor.dart';
import './auth_screen_customer.dart';

class SelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 400),
        child: Center(
          child: Column(
            children: [
              RaisedButton(
                child: Text("Vet"),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    AuthDoctorScreen.routeName,
                  );
                },
              ),
              RaisedButton(
                child: Text("Customer"),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    AuthCustomerScreen.routeName,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
