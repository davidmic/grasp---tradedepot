import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Firestore _store = Firestore.instance;

class ProfileViewModel extends ChangeNotifier {

  Stream<DocumentSnapshot> userInformation ({String userId}) async* {
    yield* _store.collection('usermanagement').document(userId).snapshots();
  }

}