import 'package:flutter/material.dart';

class UnknownRoutePage extends StatelessWidget {
  const UnknownRoutePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF8F9FA),
        appBar: AppBar(
          elevation: 0.0,
          title: const Text('Not Found'),
        ),
        body: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 104, horizontal: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Image.asset(
                      'assets/icons/ic-logo-black.png',
                      width: 186,
                      height: 48.0,
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Page Not Found',
                          style: TextStyle(fontSize: 32.0),
                        ),
                        Image.asset(
                          'assets/icons/ic-board.png',
                          height: 200,
                          width: 260,
                        )
                      ],
                    ),
                  ),
                )
              ],
            )));
  }
}
