import 'package:flutter/material.dart';
import 'dart:async';

import './LoginFormFields.dart';
import './RememberForgot.dart';
import './Welcome.dart';

class LoginForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<LoginForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _loginFormKey = GlobalKey<FormState>();
  bool rememberMe = false;
  bool _loginBtnOpen = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedContainer(
            curve: Curves.easeIn,
            duration: Duration(seconds: 10),
            child: Text(
              'Login',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Form(
            key: _loginFormKey,
            child: LoginFormFields(emailController, passwordController),
          ),
          SizedBox(
            height: 10,
          ),
          RememberForgot(rememberMe, _updateRememberMe),
          SizedBox(
            height: 10,
          ),
          Center(
            child: RaisedButton(
              color: Colors.blue[600],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 1000),
                curve: Curves.fastLinearToSlowEaseIn,
                width: _loginBtnOpen ? 500 : 25,
                padding: _loginBtnOpen ? EdgeInsets.all(15.0) : null,
                child: _loginBtnOpen
                    ? Text(
                        'Login',
                        style: Theme.of(context).textTheme.body1.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                        textAlign: TextAlign.center,
                      )
                    : Container(
                        height: 50,
                        width: 50,
                        child: Image.asset(
                          'assets/images/loading_transparent_red_gif.gif',
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
              onPressed: () {
                _setStateOfLoginBtn(false);
                // if (_loginFormKey.currentState.validate()) {}
                String invalidField;
                invalidField = _validateFormFields();
                if (invalidField != null) {
                  new Timer(Duration(seconds: 1),
                      () => _handleLogin(context, invalidField));
                } else {
                  // login complete!
                  _setStateOfLoginBtn(true);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Welcome(emailController.text),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void _handleLogin(BuildContext context, String invalidField) {
    _setStateOfLoginBtn(true);
    _showScaffold(context, invalidField);
  }

  void _updateRememberMe(newVal) {
    setState(() {
      this.rememberMe = newVal;
    });
  }

  void _setStateOfLoginBtn(bool open) {
    setState(() {
      _loginBtnOpen = open;
    });
  }

  String _validateFormFields() {
    if (emailController.text.isEmpty ||
        !emailController.text.contains(RegExp('[^@ ]+@[^\. ]+\.[^ ]+'))) {
      return 'email';
    } else if (passwordController.text.isEmpty) {
      return 'password';
    }
    return null;
  }

  void _showScaffold(BuildContext context, String invalidField) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        duration: Duration(milliseconds: 1000),
        backgroundColor: Colors.blue[700],
        content: Container(
          child: Text(
            invalidField == 'email'
                ? 'Please enter valid Email Id'
                : 'Please enter valid Password',
            style: Theme.of(context).textTheme.body1.copyWith(
                  color: Colors.white,
                ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
