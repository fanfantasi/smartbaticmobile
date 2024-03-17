import 'package:flutter/material.dart';

class InactivePage extends StatelessWidget {
  const InactivePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/images/inactive.png',
            ),
          ),
          Center(
            child: Image.asset(
              'assets/images/logo.png',
              height: 64,
            ),
          ),
        ],
      ),
    );
  }
}
