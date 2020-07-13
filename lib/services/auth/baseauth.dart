

import 'package:grasp/model/usermodel.dart';

abstract class BaseAuth {
  Future signInUser({UserModel userInfo});
  Future createNewUser ({UserModel userInfo});
  Future signOut ();
  Future getCurrentUser();
  Future<void> emailVerification();
  Future<bool> checkemailVerificationStatus();
}

