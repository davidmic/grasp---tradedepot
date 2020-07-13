import 'package:flutter/material.dart';
import 'package:grasp/view_model/auth_viewmodel.dart';
import 'package:grasp/view_model/kycupgradelvlOne_viewmodel.dart';
import 'package:grasp/view_model/profile_viewmodel.dart';
import 'package:grasp/view_model/verify_number_viewModel.dart';
import 'package:grasp/views/home.dart';
import 'package:grasp/views/login.dart';
import 'package:grasp/views/signup.dart';
import 'package:grasp/views/splash_screen.dart';
import 'package:grasp/views/verification_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => AuthViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProfileViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => KYCUpgradeViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => VerifyNumberFromBVN(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color(0xff62D9A2),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: {
          '/' : (_) => MySplashScreen(),
          '/home' : (_) => MyHome(),
          '/verification' : (_) => MyVerificationScreen(),
          '/signup' : (_) => MySignUpScreen(),
          '/login' : (_) => MyLoginScreen(),
        },
      ),
    );
  }
}

