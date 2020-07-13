import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grasp/views/home.dart';
import 'package:grasp/views/login.dart';
import 'package:grasp/widget/app_name.dart';

class MySplashScreen extends StatefulWidget {
  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> with TickerProviderStateMixin {

  AnimationController _controller;
  Animation _animation;

  @override

  void initState () {
    super.initState();

    _controller = AnimationController(vsync: this, duration: Duration(seconds: 2));

    Future.delayed(Duration(seconds: 2), (){
      print('Pushing to a new page');
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MyLoginScreen()));
//      Navigator.push(context, MaterialPageRoute(builder: (context) => MyHome()));
    });
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MyAppName()
      ),
    );
  }
}
