
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grasp/model/usermodel.dart';
import 'package:grasp/services/firebase_storage.dart';
import 'package:grasp/services/http_calls.dart';
import 'package:grasp/services/image_service.dart';
import 'package:grasp/view_model/auth_viewmodel.dart';
import 'package:grasp/view_model/kycupgradelvlOne_viewmodel.dart';
import 'package:grasp/widget/alert.dart';
import 'package:grasp/widget/customflatbutton.dart';
import 'package:grasp/widget/customraisedbutton.dart';
import 'package:provider/provider.dart';

class KYCUpgradeOne extends StatefulWidget {

  String checkVerified;
  String kycLevel1ImagePath;
  String email;

  KYCUpgradeOne({this.checkVerified, this.kycLevel1ImagePath, this.email});


  @override
  _KYCUpgradeOneState createState() => _KYCUpgradeOneState();
}

class _KYCUpgradeOneState extends State<KYCUpgradeOne> {

  bool isUploaded = false;

  @override
  Widget build(BuildContext context) {
    var kycUpgradeOne = Provider.of<KYCUpgradeViewModel>(context);
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
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: ListView(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              RichText(
                text: TextSpan(
                  text: 'Note: ',
                  style: GoogleFonts.playfairDisplay(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  children: [
                    TextSpan(
                      text: 'passport document or utility bill should clearly show the customers address.',
                      style: GoogleFonts.playfairDisplay(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ],
                )
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                width: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xff62D9A2), width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: widget.checkVerified == null ?
                MyImageService.fileImage == null ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.image, size: 60, color: Colors.grey,),
                    CustomFlatButton(
                      text: 'Select Photo',
                      onPressed: () async {
                        await MyImageService().pickImage();
                        setState(() {});
                      },
                    ),
                  ],
                ) : Image.asset(MyImageService.fileImage.path, fit: BoxFit.fill,)
                    : Image.network(widget.kycLevel1ImagePath, fit: BoxFit.fill,),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              widget.checkVerified == 'verified' ?  Container() : Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      InkWell(
                        onTap: () async {
                          setState(() {
                            isUploaded = true;
                          });
                          await MyFireStorage().uploadFile(imagePath: MyImageService.fileImage, folder: 'kycLevel1');
                          setState(() {
                            isUploaded = false;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.green,
                          ),
                          child: Icon(
                            Icons.file_upload,
                            color: Colors.white,
                            size: 50,
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text('Upload'),
                    ],
                  ),
                  Column(
                    children: [
                      InkWell(
                        onTap: (){
                          setState(() {
                            MyImageService.fileImage = null;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                          ),
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 50,
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text('Cancel'),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Center(
                child: widget.checkVerified == 'verified' ? Container() :
               isUploaded ? Container(child: CircularProgressIndicator(),) : CustomRaisedButton(
                  text: 'Upgrade to Level 1',
                  onPressed: () async {
                    if (MyFireStorage.uploadFileURL == null) {
                      print("KYC Image not yet Uploaded");
                      return;
                    }
                    await kycUpgradeOne.updateKYCUpgradeOne(
                      userId: userId.userId,
                      kycLevel: 'LevelOne',
                      userData: UserModel(
                        imagePath: MyFireStorage.uploadFileURL,
                      ),
                    );
                    print(kycUpgradeOne.status.toString());
                    if(kycUpgradeOne.status == KYCStatus.successful) {
                      Navigator.pop(context);
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
                      HttpCalls().sendMail(email: widget.email);
                    }
                    else if(kycUpgradeOne.status == KYCStatus.failed) {
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
                      print("failed");
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
