import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grasp/database/database.dart';
import 'package:grasp/model/usermodel.dart';
import 'package:grasp/services/auth/auth.dart';
import 'package:grasp/services/auth/baseauth.dart';

enum Status { uninitialized, successful, failed, unverified}

class AuthViewModel extends ChangeNotifier {
  BaseAuth _baseAuth = EmailAndPasswordAuth();
  CloudFirestore _firestore = CloudFirestore();

  Status _status = Status.uninitialized;
  String _userId;

  get status => _status;
  set status (Status val) => _status = val;

  get userId => _userId;
  set userId (String val) => _userId = val;

  Future<FirebaseUser> signIn ({UserModel userData}) async {
    try {
      final user = await _baseAuth.signInUser(userInfo: UserModel(
        email: userData.email,
        password: userData.password,
      ));
      if (!user.isEmailVerified) {
        user.sendEmailVerification();
        status = Status.unverified;
        notifyListeners();
        return user;
      } else {
        userId = user.uid;
        status = Status.successful;
        notifyListeners();
        return user;
      }

    }
    catch (e) {
      print(e.code.toString());
      status = Status.failed;
      notifyListeners();
    }
  }


  Future<String> signUp ({UserModel userData}) async {
    try {
      final user = await _baseAuth.createNewUser(userInfo: UserModel(
        email: userData.email,
        password: userData.password,
      ));
      final saveData = await _firestore.userData(userInfo: UserModel(
          email: userData.email,
          fullName: userData.fullName,
          mobileNumber: userData.mobileNumber,
          imagePath: userData.imagePath,
        ),
        userId: user,
      );
      print("SignUp View Model");
      await _baseAuth.emailVerification();
      status = Status.successful;
      notifyListeners();
      return user;
    }
    catch (e) {
      print(e.toString());
      status = Status.failed;
      notifyListeners();
    }
  }

  Future<bool> getEmailVerificationStatus () async {
    try{
      final verificationStatus = await _baseAuth.checkemailVerificationStatus();
      print(verificationStatus.toString());
      if (verificationStatus) {
        status = Status.successful;
        notifyListeners();
        return true;
      }
      else {
        status = Status.unverified;
        _baseAuth.emailVerification();
//        getEmailVerificationStatus();
      }
    }
    catch (e) {

    }
  }
}