
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class FirebaseFileUpload{
  String uid = FirebaseAuth.instance.currentUser!.uid;
  Future<String> uploadFile(File?pickImage) async{
    String timeId = DateTime.now().millisecondsSinceEpoch.toString();
    Reference ref = FirebaseStorage.instance.ref("/upload_photo/$uid/$timeId");
   // debugPrint("absoultttt${pickImage!.absolute}");
    UploadTask task = ref.putFile(pickImage!.absolute);
    await Future.value(task);
    String imUrl = await ref.getDownloadURL();
    return imUrl;
    //addd
  }
}