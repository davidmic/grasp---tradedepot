
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grasp/services/http_calls.dart';
import 'package:grasp/view_model/auth_viewmodel.dart';
import 'package:grasp/view_model/verify_number_viewModel.dart';
import 'package:grasp/widget/alert.dart';
import 'package:grasp/widget/customraisedbutton.dart';
import 'package:grasp/widget/customtextformfield.dart';
import 'package:grasp/widget/instructiontext.dart';
import 'package:provider/provider.dart';

class KYCUpgradeTwo extends StatefulWidget {

  String checkVerified;

  KYCUpgradeTwo({this.checkVerified});

  @override
  _KYCUpgradeTwoState createState() => _KYCUpgradeTwoState();
}

class _KYCUpgradeTwoState extends State<KYCUpgradeTwo> {

  var _formKey = GlobalKey<FormState>();
  String bvn;

  @override
  Widget build(BuildContext context) {
    var kycUpgradeTwo = Provider.of<VerifyNumberFromBVN>(context);
    var userId = Provider.of<AuthViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "KYC Upgrade",
          style: GoogleFonts.montserrat(
            color: Colors.white,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: ListView(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
                RichText(
                  textAlign: TextAlign.justify,
                    text: TextSpan(
                      text: 'Note: ',
                      style: GoogleFonts.playfairDisplay(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      children: [
                        TextSpan(
                          text: 'Provide bank verification number to upgrade to level 2,',
                          style: GoogleFonts.playfairDisplay(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    )
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                widget.checkVerified == null ? CustomTextFormField(
                  useLabel: true,
                  label: 'Bank Verification Number',
                  icon: Icons.verified_user,
                  keyboardType: TextInputType.number,
                  hintText: '11 Digits',
                  onSaved: (val){
                    bvn = val;
                  },
                  validator: (val){
                    if(val.isEmpty) {
                      return 'BVN Required';
                    }
                    return null;
                  },
                ):
                    InstructionText(
                      emphasisText: 'Status',
                      message: 'BVN Verified',
                      useIcon: true,
                    ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Center(
                  child: CustomRaisedButton(
                    text: 'Upgrade to Level 2',
                    onPressed:  widget.checkVerified == null ? () async {
                        if(! _formKey.currentState.validate()) {
                          return;
                        }
                      _formKey.currentState.save();
                     var user = await HttpCalls().getRequest(bvn: bvn);
                      await kycUpgradeTwo.verifyBVNUserNumber(
                        userId: userId.userId,
                        bvn: user['bvn'],
                        mobileNumber: user['mobile'],
                        dateOfBirth: user['dob'],
                        context: context,
                      );
                      if (kycUpgradeTwo.status == BVNStatus.successful) {
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
//                        Navigator.pop(context);
                      }
                    if (kycUpgradeTwo.status == BVNStatus.failed) {
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
                    } : null,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
