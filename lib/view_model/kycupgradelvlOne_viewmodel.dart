
import 'package:flutter/material.dart';
import 'package:grasp/database/database.dart';
import 'package:grasp/model/usermodel.dart';

enum KYCStatus {uninitialized, successful, failed}

class KYCUpgradeViewModel extends ChangeNotifier {

  CloudFirestore store = CloudFirestore();

  KYCStatus _status = KYCStatus.uninitialized;

  get status => _status;
  set status (KYCStatus val) => _status = val;


  Future updateKYCUpgradeOne ({String userId, UserModel userData, String kycLevel}) async {
    try {
      await store.addKYC(userId: userId, kycLevel: kycLevel, userInfo: UserModel(
        imagePath: userData.imagePath,
       ),
      );
      status = KYCStatus.successful;
      notifyListeners();
      return;
    }
    catch (e) {
      print(e.toString());
      status = KYCStatus.failed;
      notifyListeners();
    }
  }
}