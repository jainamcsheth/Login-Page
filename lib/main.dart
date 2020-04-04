import 'package:flutter/material.dart';

import './widgets/LoginPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: ThemeData.light().textTheme.copyWith(
              body1: TextStyle(
                fontSize: 18,
              ),
            ),
      ),
      home: LoginPage(),
    );
  }
}
