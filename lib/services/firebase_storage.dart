

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;

class MyFireStorage {

  FirebaseStorage _storage = FirebaseStorage.instance;
  static String uploadFileURL;

  Future uploadFile ({File imagePath, String folder}) async {
    try {
      StorageReference storageReference = _storage.ref()
          .child('$folder/${Path.basename(imagePath.path)}');
      StorageUploadTask uploadTask = storageReference.putFile(imagePath);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      print('File Uploaded');
      await storageReference.getDownloadURL().then((fileURL) {
        // setState(() {
        uploadFileURL = fileURL;
//        status = UploadStatus.Successful;
//        notifyListeners();
        // });
        // return uploadFileURL;
      });
    } catch (e) {
//      status = UploadStatus.Failed;
      print (e.toString());
//      notifyListeners();
    }
  }
}