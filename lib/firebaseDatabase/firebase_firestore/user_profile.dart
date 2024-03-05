import 'package:assignment_firebase/models/firebaseUserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../../utils/utils.dart';

class UserProfile{
  static final dataBaseStore = FirebaseFirestore.instance.collection("user");

  setUserProfileDetail(FirebaseUserStoreModel firebaseUserStoreModel) async{
    await dataBaseStore.doc(firebaseUserStoreModel.uid).set(firebaseUserStoreModel.toMap()).then((value) {
      Utils.toastMessage("Profile Data Store");
      debugPrint("data upload");
    }).onError((error, stackTrace) {
      Utils.toastMessage(error.toString());
    });

  }
}