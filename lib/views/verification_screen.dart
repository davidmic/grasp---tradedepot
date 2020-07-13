import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grasp/view_model/auth_viewmodel.dart';
import 'package:grasp/views/login.dart';
import 'package:grasp/widget/app_name.dart';
import 'package:grasp/widget/clickable_row.dart';
import 'package:grasp/widget/customraisedbutton.dart';
import 'package:provider/provider.dart';

class MyVerificationScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var emailVerifyViewModel = Provider.of<AuthViewModel>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: ListView(
            padding: EdgeInsets.only(left: 30, right: 30),
            children: [
              SizedBox(
                height: height * 0.25,
              ),
              Center(
                child: MyAppName(),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Text(
                  "Welcome! Please check your email for verification mail, if verified you can proceed to Log in.",
                textAlign: TextAlign.justify,
                style: GoogleFonts.montserrat(
                  letterSpacing: 1.5,
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Center(
                child: CustomRaisedButton(
                  text: 'I have Verified My Email',
                  textColor: Colors.white,
                  color: Color(0xff62D9A2),
                  onPressed: () async {
                    Navigator.pushNamed(context, "/login");
//                    await emailVerifyViewModel.getEmailVerificationStatus();
//                    if (emailVerifyViewModel.status == Status.successful) {
//                      Navigator.push((context), MaterialPageRoute(builder: (_) => MyLoginScreen()));
//                    }
//                    else if (emailVerifyViewModel.status == Status.unverified) {
//                      print('email address not verified');
//                    }
                  },
                ),
              ),
              SizedBox(
                height: height * 0.08,
              ),
              ClickableSingleTextRow(
                firstChildText: 'Having problem? Email us at ',
                secondChildText: 'contact@grasp.com',
                onTap: (){},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
