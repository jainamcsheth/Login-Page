import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomButton {
  String buttonText;
  Function buttonFunc;

  CustomButton(this.buttonText, this.buttonFunc);
}

class CustomDialog extends StatefulWidget {
  final Widget childWidget;
  final double xAxis, yAxis;
  final List<CustomButton> buttons;

  CustomDialog({this.childWidget, this.xAxis, this.yAxis, this.buttons});

  @override
  _CustomDialogState createState() => _CustomDialogState(
      childWidget: childWidget, xAxis: xAxis, yAxis: yAxis, buttons: buttons);
}

class _CustomDialogState extends State<CustomDialog> {
  final Widget childWidget;
  final double xAxis, yAxis;
  final List<CustomButton> buttons;

  _CustomDialogState({this.childWidget, this.xAxis, this.yAxis, this.buttons});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        children: [
          Positioned(
            // top: 504, left: 915,
            top: yAxis,
            left: xAxis,
            child: AlertDialog(
              content: childWidget != null
                  ? childWidget
                  : Text(
                      'Showig default child and buttons since no child passed \n Are you sure?'),
              actions: (buttons != null && buttons.length > 0)
                  ? customButtons
                  : defaultButtons,
            ),
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }

  get defaultButtons {
    return [
      RawKeyboardListener(
        focusNode: FocusNode(),
        onKey: (event) {
          print('Tab key - ${LogicalKeyboardKey.tab.keyId} - 4295426091');
          if (event.runtimeType == RawKeyDownEvent &&
              (event.logicalKey.keyId == LogicalKeyboardKey.enter.keyId)) {
            Navigator.pop(context);
          }
        },
        child: FlatButton(
          child: Text("Yes"),
          onPressed: () => Navigator.pop(context),
          focusColor: Colors.red,
        ),
      ),
      RawKeyboardListener(
        focusNode: FocusNode(),
        onKey: (event) {
          if (event.runtimeType == RawKeyDownEvent &&
              (event.logicalKey.keyId == LogicalKeyboardKey.enter.keyId)) {
            Navigator.pop(context);
          }
        },
        child: FlatButton(
          child: Text("No"),
          onPressed: () => Navigator.pop(context),
          focusColor: Colors.red,
        ),
      ),
    ];
  }

  get customButtons {
    var actions = [];

    buttons.forEach((button) {
      actions.add(
        RawKeyboardListener(
          focusNode: FocusNode(),
          onKey: (event) {
            if (event.runtimeType == RawKeyDownEvent &&
                (event.logicalKey.keyId == LogicalKeyboardKey.enter.keyId)) {
              button.buttonFunc();
            }
          },
          child: FlatButton(
            child: Text(button.buttonText),
            onPressed: () => button.buttonFunc(),
            focusColor: Colors.red,
          ),
        ),
      );
    });

    return actions.cast<Widget>();
  }
}
