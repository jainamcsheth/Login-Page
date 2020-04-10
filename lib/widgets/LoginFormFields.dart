import 'package:flutter/material.dart';

class LoginFormFields extends StatelessWidget {
  final emailController;
  final passwordController;

  LoginFormFields(this.emailController, this.passwordController);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.purple[100],
          blurRadius: 50.0,
          spreadRadius: -5,
          offset: Offset(0, 5),
        )
      ]),
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Container(
                child: TextFormField(
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Emai Id',
                    prefixIcon: Icon(Icons.email),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  controller: emailController,
                  onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                  textInputAction: TextInputAction.next,
                  // validator: (emailVal) {
                  // },
                ),
              ),
              Container(
                child: TextFormField(
                  autofocus: false,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    prefixIcon: Icon(Icons.lock_outline),
                    border: InputBorder.none,
                  ),
                  controller: passwordController,
                  textInputAction: TextInputAction.done,
                  // onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
