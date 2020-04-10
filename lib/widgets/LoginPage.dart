import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;

import './LoginForm.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    var orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
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
                horizontal: orientation == Orientation.portrait
                    ? (screenWidth > 575 ? screenWidth / 5 : 35)
                    : screenWidth > 1028
                        ? screenWidth / 3
                        : (screenWidth > 767
                            ? screenWidth / 4
                            : screenWidth / 5),
                vertical: 18,
              ),
              height: orientation == Orientation.portrait && screenHeight > 569
                  ? screenHeight
                  : 650, // screenHeight > 650 ? screenHeight : 650,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 10,
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
                      style: Theme.of(context).textTheme.bodyText2,
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
