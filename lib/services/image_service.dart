import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyImageService extends ChangeNotifier {
  static File fileImage;
  final _picker = ImagePicker();
  static String imagePath;

  FirebaseStorage _storage = FirebaseStorage.instance;


 Future<File> pickImage () async {
    PickedFile image = await _picker.getImage(source: ImageSource.gallery);
    print('Print me');
    imagePath = image.path;
    fileImage = File(image.path);
//    print(_image.toString());
    notifyListeners();
    return fileImage;
  }

}