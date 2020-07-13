
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grasp/model/usermodel.dart';
import 'package:grasp/view_model/auth_viewmodel.dart';
import 'package:grasp/views/home.dart';
import 'package:grasp/views/signup.dart';
import 'package:grasp/views/verification_screen.dart';
import 'package:grasp/widget/alert.dart';
import 'package:grasp/widget/app_name.dart';
import 'package:grasp/widget/clickable_row.dart';
import 'package:grasp/widget/customraisedbutton.dart';
import 'package:grasp/widget/customtextformfield.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class MyLoginScreen extends StatefulWidget {
  @override
  _MyLoginScreenState createState() => _MyLoginScreenState();
}

class _MyLoginScreenState extends State<MyLoginScreen> {

  var _formKey = GlobalKey<FormState>();
  bool _loading = false;

  UserModel userData = UserModel();

  @override


  Widget build(BuildContext context) {
    var loginViewModel = Provider.of<AuthViewModel>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ModalProgressHUD(
          progressIndicator: Container(
            height: MediaQuery.of(context).size.height * 0.15,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    backgroundColor: Colors.black,
                  ),
                  SizedBox(height: 10,),
                  Text('Authenticating User ...'),
                ],
              ),
            ),
          ),
          inAsyncCall: _loading,
          child: Container(
//            height: MediaQuery.of(context).size.height * 0.1,
            padding: EdgeInsets.only(left: 30, right: 30),
            child: ListView(
              children: [
                SizedBox(
                  height: height * 0.25,
                ),
                Center(
                  child: MyAppName(),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                CustomTextFormField(
                  onSaved: (val){
                    userData.email = val;
                  },
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Enter Valid Email Address";
                    }
                    return null;
                  },
                  icon: Icons.mail_outline,
                  iconSize: 30,
                  hintText: 'example@mail.com',
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                CustomTextFormField(
                  onSaved: (val){
                    userData.password = val;
                  },
                  validator: (val) {
                    if (val.length < 6) {
                      return "Password is incorrect";
                    }
                    return null;
                  },
                  icon: Icons.lock_outline,
                  iconSize: 30,
                  hintText: '********',
                  obsecureText: true,
                ),
                SizedBox(
                  height: height * 0.025,
                ),
                CustomRaisedButton(
                  text: 'Login',
                  textColor: Colors.white,
                  color: Color(0xff62D9A2),
                  onPressed: () async {
                   if (!_formKey.currentState.validate()){
                     return;
                   }
                    _formKey.currentState.save();
                    setState(() {
                      _loading = true;
                    });

                   await loginViewModel.signIn(userData: UserModel(
                     email: userData.email,
                     password: userData.password,
                   ));

                   setState(() {
                     _loading = false;
                   });
                   if (loginViewModel.status == Status.successful) {
//                     Navigator.push(context, MaterialPageRoute(builder: (_) => MyHome()));
                     Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
                     showDialog(
                         context: context,
                         builder: (context) {
                           Future.delayed(Duration(seconds: 2), () {
                             Navigator.of(context).pop();
                           });
                           return MyAlert(
                             message: 'Success',
                             icon: Icons.check,
                             iconColor: Colors.green,
                           );
                         }
                     );
                   }
                   else if (loginViewModel.status == Status.failed) {
                     showDialog(
                         context: context,
                         builder: (context) {
                           Future.delayed(Duration(seconds: 2), () {
                             Navigator.of(context).pop();
                           });
                           return MyAlert(
                             message: 'Failed',
                             icon: Icons.close,
                             iconColor: Colors.red,
                           );
                         }
                     );

                   }
                   else if (loginViewModel.status == Status.unverified) {
                     Navigator.push(context, MaterialPageRoute(builder: (_) => MyVerificationScreen()));
                   }
                  },
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                ClickableSingleTextRow(
                  firstChildText: 'Forgot Password? ',
                  secondChildText: 'Recover Here',
                  onTap: (){},
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                ClickableSingleTextRow(
                  firstChildText: 'Don\'t have an account? ',
                  secondChildText: 'Sign Up',
                  onTap: (){
                    print('tapped');
//                    Navigator.push(context, MaterialPageRoute(builder: (context) => MySignUpScreen()));
                      Navigator.pushNamed(context, "/signup");
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
