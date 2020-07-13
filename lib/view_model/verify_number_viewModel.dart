
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grasp/database/database.dart';
import 'package:grasp/widget/customflatbutton.dart';
import 'package:grasp/widget/customtextformfield.dart';

enum BVNStatus {successful, failed, unitialized}

class VerifyNumberFromBVN extends ChangeNotifier {

  FirebaseAuth _auth = FirebaseAuth.instance;
  CloudFirestore _store = CloudFirestore();

  BVNStatus _status = BVNStatus.unitialized;

  get status => _status;
  set status (BVNStatus val) => _status = val;

  var code;

  verifyBVNUserNumber ({String userId, String bvn, String mobileNumber, BuildContext context, String dateOfBirth}) async {
    String number = mobileNumber.substring(1, 11);
    print(number);
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: "+234$number",
          timeout: Duration(seconds: 120),
          verificationCompleted: (AuthCredential credential) async {
            print('Done');
          },
          verificationFailed: (AuthException exception){
            print(exception);
          },
          codeSent: (String verificationId, [int forceResendingToken]){
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Enter User OTP?"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        CustomTextFormField(
                          onSaved: (val){
                            code = val;
                          },
                        ),
                      ],
                    ),
                    actions: <Widget>[
                      CustomFlatButton(
                        text: "Confirm",
                        onPressed: () async{
                          AuthCredential credential = PhoneAuthProvider.getCredential(verificationId: verificationId, smsCode: code);
                          print(credential.toString());
                          await _store.kycBVNVerification(
                            userId: userId,
                            numberAssociatedWithBVN: mobileNumber,
                            kycLevel: 'LevelTwo',
                            bvn: bvn,
                            dateOfBirth: dateOfBirth,
                          );
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          status = BVNStatus.successful;
                        notifyListeners();
                        },
                      )
                    ],
                  );
                }
            );
          },
          codeAutoRetrievalTimeout: null
      );
    }
    catch (e) {
      status = BVNStatus.failed;
      notifyListeners();
    }

  }
}

//      {status: true, message: BVN resolved,
//      data: {first_name: DAVID, last_name: MICHEAL, dob: 21-May-95,
//      formatted_dob: 1995-05-21, mobile: 08142951042, bvn: 22240446110},
//      meta: {calls_this_month: 1, free_calls_left: 9}}