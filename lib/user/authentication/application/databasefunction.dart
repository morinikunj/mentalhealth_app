import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:mentalhealth_app/user/authentication/application/auth_servieces.dart';
import 'package:mentalhealth_app/user/authentication/model/mood_model.dart';
import 'package:mentalhealth_app/user/authentication/model/user_model.dart';
import 'package:mentalhealth_app/user/authentication/register/model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:mentalhealth_app/user/sessions/model/session_model.dart';

class DatabaseServices {
  static FirebaseStorage _storage = FirebaseStorage.instance;

  static DatabaseReference _userref =
      FirebaseDatabase.instance.ref().child('users');

  static DatabaseReference _sessions =
      FirebaseDatabase.instance.ref().child('sessions');

  static updateDetails(UserModel user) async {
    await FirebaseAuth.instance.currentUser!.updateDisplayName(user.name);
    await FirebaseAuth.instance.currentUser!.updateEmail(user.email);

    await _userref.child(AuthServices.user!.uid).update({
      'imageUrl': user.imageUrl,
      'name': user.name,
      'email': user.email,
      'phoneNo': user.phoneno,
      'dob': user.dob,
      'profession': user.profession,
      'location': user.location,
    });
  }

  Future<void> saveUserData(UserModel user) async {
    await _userref.child(user.userid!).set({
      'imageUrl': user.imageUrl,
      'name': user.name,
      'email': user.email,
      'phoneNo': user.phoneno,
      'dob': user.dob,
      'profession': user.profession,
      'location': user.location,
    });
  }

  Future<void> createSession(SessionModel sessionModel) async {
    await _sessions.push().set({
      
      'url': sessionModel.url,
      'title': sessionModel.title,
      'description': sessionModel.description,
    });
  }

  Future<void> createMood(uid, happy, sad, angry, normal) async {
    DatabaseReference mood = FirebaseDatabase.instance.ref().child('moods');
    await mood
        .child(uid)
        .set({'happy': happy, 'sad': sad, 'angry': angry, 'normal': normal});
  }

  Future<void> updateMood(uid, happy, sad, angry, normal) async {
    DatabaseReference mood = FirebaseDatabase.instance.ref().child('moods');
    await mood
        .child(uid)
        .update({'happy': happy, 'sad': sad, 'angry': angry, 'normal': normal});
  }

  Future<MoodModel> MoodDeatails() async {
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref().child('moods');
    String uid = AuthServices.user!.uid;
    DataSnapshot dataSnapshot = await databaseReference.child(uid).get();

    if (dataSnapshot.exists) {
      // UserModel userModel =
      //     UserModel.fromJson(Map<dynamic, dynamic>.from(dataSnapshot.value));

      Map<Object?, dynamic> map = dataSnapshot.value as dynamic;

      MoodModel userModel = MoodModel.fromJson(map);

      return userModel;
    } else {
      throw Exception;
    }
  }

  static Stream<List<SessionModel>> fetchsessions() {
    try {
      return _sessions.onValue.map((event) {
        Map<Object?, dynamic> expertsMap = event.snapshot!.value as dynamic;

        final appointmentList = expertsMap.entries
            .map((e) => SessionModel.fromJson(e.value))
            .toList();

        return appointmentList;
      }).handleError((e) {
        print(e.toString());
      });
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<UserModel> fetchUserDeatails() async {
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    String uid = AuthServices.user!.uid;
    DataSnapshot dataSnapshot =
        await databaseReference.child('users/$uid').get();

    if (dataSnapshot.exists) {
      // UserModel userModel =
      //     UserModel.fromJson(Map<dynamic, dynamic>.from(dataSnapshot.value));

      Map<Object?, dynamic> map = dataSnapshot.value as dynamic;

      UserModel userModel = UserModel.fromJson(map);

      return userModel;
    } else {
      throw Exception;
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
