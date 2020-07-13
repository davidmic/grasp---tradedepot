
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyAlert extends StatelessWidget {

  String message;
  IconData icon;
  Color iconColor;

  MyAlert({this.message, this.icon, this.iconColor});
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(dialogBackgroundColor: Colors.white),
      child: SimpleDialog(
        title: Center(
          child: Column(
            children: <Widget>[
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: iconColor,
                ),
                child: Icon(
                  icon,
                  size: 40,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(message, style: TextStyle(color: Color(0xff62D9A2), fontWeight: FontWeight.bold, fontSize: 22, fontFamily: 'Sansation', fontStyle: FontStyle.normal), ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}