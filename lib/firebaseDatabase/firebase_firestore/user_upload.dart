import 'package:assignment_firebase/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/firebasedetailUploadFileModel.dart';

class UserUpload{

  static final dataStoreFirebase = FirebaseFirestore.instance.collection("file");
  static final auth = FirebaseAuth.instance;

  uploadFile(FirebaseDetailUploadFileModel firebaseDetailUploadFileModel) async{
    final uploadDetailFile = dataStoreFirebase.doc(firebaseDetailUploadFileModel.receiverEmail).collection("upload_detail");
    String dateTime = DateTime.now().millisecondsSinceEpoch.toString();
    uploadDetailFile.doc(dateTime).set(firebaseDetailUploadFileModel.toMap()).then((value) {
      Utils.toastMessage("File Upload");
    }).onError((error, stackTrace) {
      Utils.toastMessage("Something wrong to upload file");
    });
  }

 static Stream<List<FirebaseDetailUploadFileModel>> fetchAllFile(){
    final fetchFile = dataStoreFirebase.doc(auth.currentUser!.email.toString()).collection("upload_detail").snapshots();
     return fetchFile.map((QuerySnapshot<Map<String, dynamic>> snapshot) {
       List<FirebaseDetailUploadFileModel> fetchData =[];
       for(final DocumentSnapshot<Map<String, dynamic>> doc in snapshot.docs){
         final Map<String, dynamic> data = doc.data()!;
         fetchData.add(FirebaseDetailUploadFileModel.fromJson(data));
       }
       return fetchData;

    }
    );
 }


}