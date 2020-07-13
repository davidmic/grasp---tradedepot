import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grasp/view_model/auth_viewmodel.dart';
import 'package:grasp/view_model/profile_viewmodel.dart';
import 'package:grasp/views/kyc_upgrade_one_screen.dart';
import 'package:grasp/views/kyc_upgrade_two_screen.dart';
import 'package:grasp/widget/customflatbutton.dart';
import 'package:grasp/widget/instructiontext.dart';
import 'package:provider/provider.dart';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    var getUserId = Provider.of<AuthViewModel>(context);
    var getProfileInfo = Provider.of<ProfileViewModel>(context);
    return SafeArea(
//      padding: EdgeInsets.only(left: 30, right: 30),
        child: StreamBuilder<DocumentSnapshot>(
      stream: getProfileInfo.userInformation(userId: getUserId.userId),
      builder: (context, snapshot) {
        Widget page;
        if (!snapshot.hasData) {
          page = Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
          final data = snapshot.data.data;
          page = ListView(children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xff62D9A2),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(80),
                    bottomRight: Radius.circular(80)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 50, bottom: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      radius: 90,
                      backgroundImage: NetworkImage(data['imagePath']),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data['fullName'] ?? 'Johne Doe',
//                          'Johne Doe',
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          data['email'] ?? 'example@mail.com',
//                          'example@mail.com',
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          data['mobileNumber'] ?? '081000000000',
//                          '081000000000',
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'KYC: ' + data['level'] ?? '0000',
//                          '081000000000',
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        CustomFlatButton(
                          text: 'Edit',
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 14, right: 14),
              child: Text(
                'KYC Verification',
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(
                            'Level 0',
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff62D9A2),
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              InstructionText(
                                emphasisText: 'Requirement: ',
                                message: 'User Email must be verified',
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              InstructionText(
                                emphasisText: 'Status: ',
                                message: data['kycLevel0'] == null
                                    ? 'N/A'
                                    : data['kycLevel0'],
                                useIcon: data['kycLevel0'] == 'verified'
                                    ? true
                                    : false,
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              data['kycLevel0'] == 'verified'
                                  ? Container()
                                  : CustomFlatButton(
                                      text: 'Upgrade Level',
                                      onPressed: () {},
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        title: Text(
                          'Level 1',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff62D9A2),
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            InstructionText(
                              emphasisText: 'Requirement: ',
                              message:
                                  'Upload passport or utility bill showing address',
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            InstructionText(
                              emphasisText: 'Status: ',
                              message: data['kycLevel1'] == null
                                  ? 'N/A'
                                  : data['kycLevel1'],
                              useIcon: data['kycLevel1'] == 'verified'
                                  ? true
                                  : false,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            data['kycLevel0'] == 'verified' &&
                                    data['kycLevel1'] == null
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomFlatButton(
                                        text: 'Upgrade Level',
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) => KYCUpgradeOne(
                                                        checkVerified:
                                                            data['kycLevel1'],
                                                        kycLevel1ImagePath: data[
                                                        'kycLevel1imagePath'],
                                                        email: data['email'],
                                                      )));
                                        },
                                      ),
                                    ],
                                  )
                                : Container(),
                            data['kycLevel1'] == 'pending'
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomFlatButton(
                                        text: 'Upgrade Level',
                                        onPressed: null,
                                      ),
                                    ],
                                  )
                                : Container(),
                            data['kycLevel1'] == 'rejected'
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomFlatButton(
                                        text: 'Upgrade Level',
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) => KYCUpgradeOne(
                                                        checkVerified:
                                                            data['kycLevel1'],
                                                        kycLevel1ImagePath: data[
                                                            'kycLevel1imagePath'],
                                                        email: data['email'],
                                                      )));
                                        },
                                      ),
                                    ],
                                  )
                                : Container(),
                            data['kycLevel1'] == 'verified'
                                ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomFlatButton(
                                  text: 'View',
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => KYCUpgradeOne(
                                              checkVerified:
                                              data['kycLevel1'],
                                              kycLevel1ImagePath: data[
                                              'kycLevel1imagePath'],
                                              email: data['email'],
                                            )));
                                  },
                                ),
                              ],
                            )
                                : Container(),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        title: Text(
                          'Level 2',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff62D9A2),
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            InstructionText(
                              emphasisText: 'Requirement: ',
                              message:
                                  'Perform BVN verification to verify identity',
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            InstructionText(
                              emphasisText: 'Status: ',
                              message: data['kycLevel2'] == null
                                  ? 'N/A'
                                  : data['kycLevel2'],
                              useIcon: data['kycLevel2'] == 'verified'
                                  ? true
                                  : false,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            data['kycLevel0'] == 'verified' &&
                                    data['kycLevel1'] == 'verified' &&  data['kycLevel2'] == null
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomFlatButton(
                                        text: 'Upgrade Level',
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      KYCUpgradeTwo(checkVerified: data['kycLevel2'],)));
                                        },
                                      ),
                                    ],
                                  )
                                : Container(),
                            data['kycLevel2'] == 'verified'
                                ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomFlatButton(
                                  text: 'View',
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                KYCUpgradeTwo(checkVerified: data['kycLevel2'],)));
                                  },
                                ),
                              ],
                            )
                                : Container(),
                          ],
                        ),
                      ),
                    ),
//                    Text(data['userId'].toString()),
                  ],
                )),
          ]);
        }
        return page;
      },
    ));
  }
}
