import 'dart:async';

import 'package:assignment_firebase/view_model/viewpagescreen_bloc/viewpagescreen_event.dart';
import 'package:assignment_firebase/view_model/viewpagescreen_bloc/viewpagescreen_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import '../../firebaseDatabase/firebase_firestore/user_upload.dart';
import '../../models/firebasedetailUploadFileModel.dart';

class ViewPageScreenBloc extends Bloc <ViewPageScreenEvent,ViewPageScreenState>{
  ViewPageScreenBloc():super(ViewIntialState()){
    on<IntialViewPageScreenEvent>(fetchData);
  }
  FutureOr<void> fetchData(IntialViewPageScreenEvent event, Emitter emit) {
    try {

      emit(ViewLoadingState());

      Stream<List<FirebaseDetailUploadFileModel>> fetchFileFirebase = UserUpload.fetchAllFile();

      emit(ViewLoaderState(fetchData: fetchFileFirebase));
    }
    catch(e){
      emit(ViewErrorState(message: e.toString()));
    }
  }
}