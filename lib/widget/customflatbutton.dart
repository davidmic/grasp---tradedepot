import 'package:flutter/material.dart';

class CustomFlatButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  CustomFlatButton({this.onPressed, this.text});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      textColor: Color(0xff62D9A2),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        side: BorderSide(color: Color(0xff62D9A2), width: 1.0),
      ),
      child: Text(
        text ?? '',
        style: TextStyle(
            color:Color(0xff62D9A2)
        ),
      ),
      onPressed: onPressed,
    );
  }
}
