import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grasp/model/usermodel.dart';
import 'package:grasp/services/firebase_storage.dart';
import 'package:grasp/services/image_service.dart';
import 'package:grasp/utils/validator.dart';
import 'package:grasp/view_model/auth_viewmodel.dart';
import 'package:grasp/views/verification_screen.dart';
import 'package:grasp/widget/alert.dart';
import 'package:grasp/widget/app_name.dart';
import 'package:grasp/widget/customflatbutton.dart';
import 'package:grasp/widget/customraisedbutton.dart';
import 'package:grasp/widget/customtextformfield.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class MySignUpScreen extends StatefulWidget {
  @override
  _MySignUpScreenState createState() => _MySignUpScreenState();
}

class _MySignUpScreenState extends State<MySignUpScreen> {

  bool obsecureText = true;
  var _formKey = GlobalKey<FormState>();
  bool _loading = false;
  bool _isUploading = false;

  //Variables

  UserModel userData = UserModel();

  @override
  Widget build(BuildContext context) {
    var signUpViewModel = Provider.of<AuthViewModel>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ModalProgressHUD(
          inAsyncCall: _loading,
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
                  Text('Creating User Profile .....'),
                ],
              ),
            ),
          ),
          child: Container(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: ListView(
              children: [
                SizedBox(
                  height: height * 0.02,
                ),
                Center(
                  child: MyAppName(),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                CustomTextFormField(
                  onSaved: (val){
                    userData.fullName = val;
                  },
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Enter Full Name";
                    }
                    return null;
                  },
                  useLabel: true,
                  label: 'Full Name',
                  icon: Icons.person_outline,
                  iconSize: 30,
                  hintText: 'John Doe',
                  keyboardType: TextInputType.text,
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                CustomTextFormField(
                  onSaved: (val){
                    userData.email = val;
                  },
                  validator: MyValidator().emailValidator,
                  useLabel: true,
                  label: 'Email',
                  icon: Icons.mail_outline,
                  iconSize: 30,
                  hintText: 'example@mail.com',
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                CustomTextFormField(
                  onSaved: (val){
                    userData.mobileNumber = val;
                  },
                  maxLength: 11,
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Enter Mobile Number";
                    }
                    return null;
                  },
                  useLabel: true,
                  label: 'Mobile Number',
                  icon: Icons.phone,
                  iconSize: 30,
                  hintText: '000-0000-0000',
                  keyboardType: TextInputType.phone,
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
                  obsecureText: obsecureText,
                  useLabel: true,
                  useSuffixIcon: true,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.remove_red_eye),
                    iconSize: 30,
                    onPressed: (){
                      setState(() {
                       obsecureText ? obsecureText = false : obsecureText = true;
                      });
                    },
                  ),
                  label: 'Password',
                  icon: Icons.lock_outline,
                  iconSize: 30,
                  hintText: '*******',
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                Text(
                    'Add User Profile Photo',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 80,
                          backgroundColor: Color(0xff62D9A2).withOpacity(0.2),
                          backgroundImage:  MyImageService.imagePath == null ? AssetImage("assets/images/avatar.png") :
                          AssetImage(MyImageService.imagePath),
                        ),
                        MyImageService.imagePath == null ? Positioned(
                          right: 0,
                          top: 0,
                          child: Badge(
                            elevation: 0,
                            badgeColor: Color(0xff62D9A2),
                            padding: EdgeInsets.all(0.0),
                            badgeContent: IconButton(
                              icon: Icon(Icons.add),
                              iconSize: 30,
                              color: Colors.white,
                              onPressed: () async {
                               await MyImageService().pickImage();
                                setState(() {});
                              },
                            ),
                          ),
                        ): Positioned(
                          right: 0,
                          top: 0,
                          child: Badge(
                            elevation: 0,
                            badgeColor: Colors.red,
                            padding: EdgeInsets.all(0.0),
                            badgeContent: IconButton(
                              icon: Icon(Icons.close),
                              iconSize: 30,
                              color: Colors.white,
                              onPressed: (){
                                setState(() {
                                  MyImageService.imagePath = null;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                   MyImageService.fileImage == null ? Container() :
                   MyFireStorage.uploadFileURL == null ?
                   _isUploading == false ? CustomFlatButton(
                      text: 'Upload',
                      onPressed: () async {
                        setState(() {
                          _isUploading = true;
                        });
                        await MyFireStorage().uploadFile(folder: 'UserProfileImage', imagePath: MyImageService.fileImage);
                        setState(() {
                          _isUploading = false;
                        });
                      },
                    ) : CircularProgressIndicator()
                       :
                   Icon(
                     Icons.check_circle,
                     size: 30,
                     color: Color(0xff62D9A2),
                   ),
                  ],
                ),
                SizedBox(
                  height: height * 0.1,
                ),
                CustomRaisedButton(
                  text: 'Complete my Registration',
                  textColor: Colors.white,
                  color: Color(0xff62D9A2),
                  onPressed: () async {
                    if (!_formKey.currentState.validate()) {
                      return;
                    }
                    if (MyImageService.imagePath == null) {
                      print('No Image');
                      return;
                    }
                    if (MyFireStorage.uploadFileURL == null) {
                      print('Image Not Uploaded');
                      return;
                    }
                    _formKey.currentState.save();
                    setState(() {
                      _loading = true;
                    });
                    await signUpViewModel.signUp(
                      userData: UserModel(
                        fullName: userData.fullName,
                        email: userData.email,
                        password: userData.password,
                        mobileNumber: userData.mobileNumber,
                        imagePath: MyFireStorage.uploadFileURL,
                      ),
                    );
                    setState(() {
                      _loading = false;
                    });
                    print(signUpViewModel.status.toString());
                    if (signUpViewModel.status == Status.successful) {
//                      Navigator.push(context, MaterialPageRoute(builder: (_) => MyVerificationScreen()));
                      MyImageService.imagePath = null;
                      MyImageService.fileImage = null;
                      Navigator.of(context).pushNamedAndRemoveUntil('/verification', (Route<dynamic> route) => false);
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
                    else if (signUpViewModel.status == Status.failed) {
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
