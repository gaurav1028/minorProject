import 'package:flutter/material.dart';
import '../widgets/main_screen/button.dart';

class SelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 400),
        child: Center(
          child: Column(
            children: [
              MainButton(
                'Vet',
              ),
              MainButton(
                'Customer',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
