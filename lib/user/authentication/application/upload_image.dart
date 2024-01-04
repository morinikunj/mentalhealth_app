import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImageUpload {
 static XFile? imageFile;
  static XFile? pickedFile;

  static FirebaseStorage storage = FirebaseStorage.instance;


  Future<String> uploadImage() async {
  String fileName = DateTime.now().millisecondsSinceEpoch.toString();
  Reference reference = storage.ref().child('images/$fileName');
  UploadTask uploadTask = reference.putFile(File(imageFile!.path));

  TaskSnapshot storageTaskSnapshot = await uploadTask;
  String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();

  return downloadUrl;
}

  Future<void> pickImage(load()) async {
    final ImagePicker picker = ImagePicker();
   

    try {
      pickedFile = await picker.pickImage(source: ImageSource.gallery);
    } catch (e) {
      print("Error picking image: $e");
    }

    if (pickedFile != null) {
      load();
      // setState(() {
      //   _imageFile = pickedFile;

      // });
    }
  }
}
