import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login/widgets/CustomDialog.dart';
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

  GlobalKey key = new GlobalKey();

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
            child: RawKeyboardListener(
              focusNode: FocusNode(),
              onKey: (event) {
                if (event.runtimeType == RawKeyDownEvent &&
                    (event.logicalKey.keyId ==
                        LogicalKeyboardKey.enter.keyId)) {
                  _showCustomDialogBox();
                }
              },
              child: RaisedButton(
                color: Colors.blue[600],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                child: AnimatedContainer(
                  key: key,
                  duration: Duration(milliseconds: 1000),
                  curve: Curves.fastLinearToSlowEaseIn,
                  width: _loginBtnOpen ? 500 : 30,
                  padding: _loginBtnOpen ? EdgeInsets.all(15.0) : null,
                  child: loginBtnText,
                ),
                onPressed: () => _showCustomDialogBox(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget get loginBtnText {
    return (_loginBtnOpen
        ? Text(
            'Login',
            style: Theme.of(context).textTheme.bodyText2.copyWith(
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
          ));
  }

  void _handleLoginPressed(BuildContext context) {
    _setStateOfLoginBtn(false);
    // if (_loginFormKey.currentState.validate()) {}
    String invalidField;
    invalidField = _validateFormFields();
    if (invalidField != null) {
      new Timer(
          Duration(seconds: 1), () => _handleLoginError(context, invalidField));
    } else {
      // login complete!
      _setStateOfLoginBtn(true);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => Welcome(emailController.text),
        ),
      );
    }
  }

  void _showCustomDialogBox() {
    final RenderBox box = key.currentContext.findRenderObject();
    var position = box.localToGlobal(Offset.zero);
    // print('Size - ${box.size} , Position - $position');

    showDialog(
      context: context,
      builder: (_) {
        return CustomDialog(
          childWidget: Text('My custom Widget - Do you want to login???'),
          xAxis: box.size.width + position.dx,
          yAxis: position.dy - (box.size.height / 2),
          buttons: [
            CustomButton('Yes', () {
              _handleLoginPressed(context);
              Navigator.pop(context);
            }),
            CustomButton('Cancel', () => Navigator.pop(context)),
            CustomButton('No', () => Navigator.pop(context)),
          ],
        );
      },
    );
  }

  void _handleLoginError(BuildContext context, String invalidField) {
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
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                  color: Colors.white,
                ),
            textAlign: TextAlign.center,
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
