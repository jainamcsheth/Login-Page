import 'package:flutter/material.dart';

class RememberForgot extends StatelessWidget {
  final Function updateRememberMe;
  final bool rememberMe;

  RememberForgot(this.rememberMe, this.updateRememberMe);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 10),
      leading: Container(
        width: 175,
        child: Row(
          children: [
            SizedBox(
              height: 25,
              width: 25,
              child: Checkbox(
                value: rememberMe,
                onChanged: (newVal) {
                  updateRememberMe(newVal);
                },
              ),
            ),
            Text(
              'Remember Me',
              style: Theme.of(context).textTheme.body1.copyWith(
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
      trailing: FlatButton(
        child: Text(
          'Forgot Password?',
          style: Theme.of(context).textTheme.body1.copyWith(
            color: Colors.purple[400],
            fontSize: 14,
          ),
        ),
        onPressed: () {},
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
    );
  }
}
