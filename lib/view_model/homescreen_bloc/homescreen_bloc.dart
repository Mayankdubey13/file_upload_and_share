import 'dart:async';
import 'dart:io';

import 'package:assignment_firebase/view_model/homescreen_bloc/homescreen_event.dart';
import 'package:assignment_firebase/view_model/homescreen_bloc/homescreen_state.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../firebaseDatabase/firebase_firestore/user_upload.dart';
import '../../firebaseDatabase/firebase_stroage/upload_file_firebase.dart';
import '../../models/firebasedetailUploadFileModel.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent,HomeScreenState>{
  final auth = FirebaseAuth.instance;
  bool isPicked = false;
  File? pickedImage;
  String _imgUrl ="";
  int count =0;
  HomeScreenBloc():super(IntialState()){
    on<SelectFileEvent>(selectFile);
    on<FileUploadEvent>(fileUpload);
    on<ShareFileEvent>(shareFile);
  }
  FutureOr<void> selectFile(SelectFileEvent event, Emitter<HomeScreenState> emit) async{
    emit(ImageSelectState());
    await fetchImage().then((value){
    //  debugPrint("########$value");
      if(value == true){
        emit(ImageSucessState(img:pickedImage!.absolute, cond: event.cond));
      }
    });

  }

  FutureOr<void> fileUpload(FileUploadEvent event, Emitter<HomeScreenState> emit) async{
   // debugPrint("come is always the fileUpload");
    try {
      await uploadImage();
      UserUpload().uploadFile(FirebaseDetailUploadFileModel(
          senderEmail: auth.currentUser!.email.toString(),
          receiverEmail: auth.currentUser!.email.toString(),
          img: _imgUrl,
          message: event.mesage));
    }
    catch(e){
      emit(ErrorState(error: e.toString()));
    }
  }

  FutureOr<void> shareFile(ShareFileEvent event, Emitter<HomeScreenState> emit) async{
 //   debugPrint("come in sharefile");
    try {
      await uploadImage();
    //  debugPrint("${event.recieverMail}");
      UserUpload().uploadFile(FirebaseDetailUploadFileModel(
          senderEmail: auth.currentUser!.email.toString(),
          receiverEmail: event.recieverMail.toString(),
          img: _imgUrl,
          message: event.mesage.toString()));
    }
    catch(e){
      emit(ErrorState(error: e.toString()));

    }
  }

  // Future<void> requestPermission() async {
  //   PermissionStatus status = await Permission.camera.request();
  //   // Check the permission status
  //   if (status.isGranted) {
  //     debugPrint("Going to fetch Image");
  //     await fetchImage();
  //   } else {
  //     await fetchImage();
  //    debugPrint("Image Fetched now going to upload in else");
  //     // await uploadImage();
  //     // openAppSettings();
  //   }
  // }


  Future<bool> fetchImage() async {
    try {
      XFile? pickImage = await ImagePicker().pickImage(source: ImageSource.gallery, maxHeight: 200, maxWidth: 300);
      if (pickImage == null) {
        isPicked=false;
      }
      else {
   //    debugPrint("this is pathhh${pickImage.path}");
        final tmpImage = File(pickImage.path);
        pickedImage = tmpImage;
        isPicked = true;
        debugPrint("Image Picked");
      //  return isPicked;
      }
    } catch (e) {
      debugPrint(e.toString());
      debugPrint("Image Picked error");
    }
   return isPicked;
  }


  Future<void> uploadImage() async {
    debugPrint("Image Picked status $isPicked");
    if (!isPicked) {
      return debugPrint("Image not Picked");
    } else {
      await FirebaseFileUpload().uploadFile(pickedImage)
          .then((value) {
        debugPrint("Image uploaded on db url: $value");
        _imgUrl = value;
        reset();
    //    debugPrint("$_imgUrl");
      }).onError((error, stackTrace) {
     //   debugPrint("Error during Uploading and getting the url \nError:$error");
      });
    }
  }

  reset(){
    isPicked = false;
    pickedImage = null;
  }

}