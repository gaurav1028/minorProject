import 'package:flutter/material.dart';
import '../widgets/main_screen/button.dart';
import './auth_screen_doctor.dart';
import './auth_screen_customer.dart';

class SelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Please Select'),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 300),
        child: Center(
          child: Column(
            children: [
              Text(
                'You are a ..',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink,
                ),
              ),
              SizedBox(
                height: 5,
              ),
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
