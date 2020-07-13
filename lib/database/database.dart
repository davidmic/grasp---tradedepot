import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grasp/model/usermodel.dart';

class CloudFirestore {

//  String userProfileData;

  Firestore store = Firestore.instance;

  Future userData ({String userId, UserModel userInfo}) async {
    print("SignUp User Data");
    try {
      await store.collection('usermanagement').document(userId).setData({
        'fullName': userInfo.fullName,
        'email': userInfo.email,
        'mobileNumber':  userInfo.mobileNumber,
        'imagePath': userInfo.imagePath,
        'userId' : userId,
        'level' : 'Level 0',
        'kycLevel0' : 'verified',
        'kycLevel1' : null,
        'kycLevel2' : null,
      });
    }
    catch (e) {
      print(e.toString());
      print("Error in Datasore");
    }
  }

  Future addKYC ({String userId, UserModel userInfo, String kycLevel}) async {
    print("SignUp User Data");
    try {
      await store.collection('verification').document(userId).collection('KYC').document(kycLevel).setData({
        'imagePath': userInfo.imagePath,
        'userId' : userId,
      });
      await store.collection('usermanagement').document(userId).updateData({
        'kycLevel1' : 'pending',
        'kycLevel1imagePath': userInfo.imagePath,
      });
      print('kyc updated successfully');
    }
    catch (e) {
      print(e.toString());
      print("Error in Datasore");
    }
  }

  Future kycBVNVerification ({String userId, String numberAssociatedWithBVN, String kycLevel, String bvn, String dateOfBirth}) async {
    print("SignUp User Data");
    try {
      await store.collection('verification').document(userId).collection('KYC').document(kycLevel).setData({
        'userId' : userId,
        'numberAssociatedWithNumber' : numberAssociatedWithBVN,
        'bvn' : bvn,
        'dateOfBirth' : dateOfBirth,
      });
      await store.collection('usermanagement').document(userId).updateData({
        'kycLevel2' : 'verified',
        'level' : 'Level 2',
      });
      print('kyc updated successfully');
    }
    catch (e) {
      print(e.toString());
      print("Error in Datasore");
    }
  }
}