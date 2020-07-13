import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grasp/model/usermodel.dart';
import 'package:grasp/services/auth/baseauth.dart';



class EmailAndPasswordAuth implements BaseAuth {

  FirebaseAuth _auth = FirebaseAuth.instance;

  // Firebase Email Password Authentication

  Future<FirebaseUser> signInUser ({UserModel userInfo}) async {
    AuthResult userAuth = await _auth.signInWithEmailAndPassword(email: userInfo.email, password: userInfo.password);
    return userAuth.user;
  }

  // Firebase Email Password Authentication

  Future<String> createNewUser ({UserModel userInfo}) async {
    AuthResult userAuth = await _auth.createUserWithEmailAndPassword(email: userInfo.email, password: userInfo.password);
    return userAuth.user.uid;
  }

  // Get Current User

  Future getCurrentUser() async {
    var user = await _auth.currentUser();
    return user;
  }

  //Verification Mail

  Future<void> emailVerification () async {
    final user = await _auth.currentUser();
    user.sendEmailVerification();
  }

  Future<bool> checkemailVerificationStatus () async {
    final user = await _auth.currentUser();
    return user.isEmailVerified;
  }

  //Sign Out

  Future<void> signOut () async {
    await _auth.signOut();
  }

//  Stream<FirebaseUser> onAuthChanged () async* {
//    var user = await _auth.onAuthStateChanged;
////    user.listen((event) { })
//    return;
//  }

}