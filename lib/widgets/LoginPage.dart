import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import './LoginForm.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    var orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.3, 1],
              colors: [Colors.yellow[100], Colors.blue[300]],
            ),
          ),
          child: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            behavior: HitTestBehavior.opaque,
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: orientation == Orientation.portrait ? 35 : ( kIsWeb ? screenWidth/3 : screenWidth/4),
                  vertical: kIsWeb ? screenHeight - 50 : 20,
                ),
                height: orientation == Orientation.portrait
                    ? screenHeight
                    : 650,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 25,
                    ),
                    Flexible(
                      flex: 2,
                      child: Container(
                        // height: 225,
                        child: Image.asset(
                          'assets/images/login_security.png',
                          // fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Flexible(
                      flex: 3,
                      child: LoginForm(),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        'Create Account',
                        style: Theme.of(context).textTheme.body1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
    );
  }
}
