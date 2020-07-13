import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
//  final Color boxShadowColor;
  final Color textColor;
  final Color color;
  final String text;
  final Function onPressed;

  CustomRaisedButton({
//    this.boxShadowColor,
    this.textColor,
    this.color,
    this.text,
    this.onPressed,
});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0xff62d9a2).withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.06,
        width: MediaQuery.of(context).size.height * 0.5,
        child: RaisedButton(
          elevation: 1,
          textColor: textColor ?? Colors.white,
          color: color ?? Color(0xff62D9A2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          onPressed: onPressed,
          child: Text(
              text ?? ''
          ),
        ),
      ),
    );
  }
}
