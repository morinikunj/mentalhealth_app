import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:mentalhealth_app/experts/auth/authservice.dart';
import 'package:mentalhealth_app/experts/auth/model/model.dart';
import 'package:mentalhealth_app/user/authentication/model/user_model.dart';
import 'package:mentalhealth_app/user/authentication/register/model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class Database {
  static FirebaseStorage _storage = FirebaseStorage.instance;

  static DatabaseReference _userref =
      FirebaseDatabase.instance.ref().child('experts');

  static updateDetails(UserModel user) async {
    await FirebaseAuth.instance.currentUser!.updateDisplayName(user.name);
    await FirebaseAuth.instance.currentUser!.updateEmail(user.email);

    await _userref.child(AuthServices.user!.uid).update({
      'name': user.name,
      'email': user.email,
      'phoneNo': user.phoneno,
      'dob': user.dob,
      'profession': user.profession,
      'location': user.location,
    });
  }

  Future<void> saveUserData(ExpertModel user) async {
    await _userref.child(user.name).set({
      'fees': user.fees,
      'about': user.about,
      'imageUrl': user.imageUrl,
      'name': user.name,
      'email': user.email,
      'phoneNo': user.phoneno,
      'experience': user.experience,
      'profession': user.profession,
      'city': user.city,
      'street': user.street,
    });
  }

  Future<void> updateProfile(ExpertModel user) async {
    await _userref.child(user.name).update({

       'fees': user.fees,
      'about': user.about,
      'imageUrl': user.imageUrl,
      'name': user.name,
      'email': user.email,
      'phoneNo': user.phoneno,
      'experience': user.experience,
      'profession': user.profession,
      'city': user.city,
      'street': user.street,

    });
  }

  static Future<ExpertModel> fetchUserDeatails() async {
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    String name = AuthServices.user!.displayName!;
    DataSnapshot dataSnapshot =
        await databaseReference.child('experts').child(name).get();

    if (dataSnapshot.exists) {
      // UserModel userModel =
      //     UserModel.fromJson(Map<dynamic, dynamic>.from(dataSnapshot.value));

      Map<Object?, dynamic> map = dataSnapshot.value as dynamic;

      ExpertModel expertModel = ExpertModel.fromJson(map);

      return expertModel;
    } else {
      throw Exception;
    }
  }

  static Stream<List<ExpertModel>> fetchUsers() {
    try {
      return _userref.onValue.map((event) {
        Map<Object?, dynamic> expertsMap = event.snapshot!.value as dynamic;

        final appointmentList = expertsMap.entries
            .map((e) => ExpertModel.fromJson(e.value))
            .toList();

        return appointmentList;
      }).handleError((e) {
        print(e.toString());
      });
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<String> uploadImage(XFile imageFile) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference reference = _storage.ref().child('images/$fileName');
    UploadTask uploadTask = reference.putFile(File(imageFile!.path));

    TaskSnapshot storageTaskSnapshot = await uploadTask;
    String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();

    return downloadUrl;
  }
}
