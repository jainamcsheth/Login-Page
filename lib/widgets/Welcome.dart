import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  final userName;

  Welcome(this.userName);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Welcome $userName'),
    );
  }
}