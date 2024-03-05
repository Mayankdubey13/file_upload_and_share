import 'dart:async';
import 'package:assignment_firebase/models/firebaseUserModel.dart';
import 'package:assignment_firebase/view_model/signup_bloc/signup_event.dart';
import 'package:assignment_firebase/view_model/signup_bloc/signup_state.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../../firebaseDatabase/firebase_firestore/user_profile.dart';

class SignupBloc extends Bloc<SignUpEvent,SignupState>{
 // AuthReposistory authReposistory = AuthReposistory();
  final auth = FirebaseAuth.instance;
  bool?res;
  bool isObx = true;
  bool isObxConform = true;
  SignupBloc():super(IntialState()){
    on<SucessSignUpEvent>(signup);
    on<ShowPasswordEvent>(showPassword);
    on<ShowConformPasswordEvent>(showConformPassword);

  }
  FutureOr<void> signup(SucessSignUpEvent event, Emitter<SignupState> emit) async{
   // res =     await authReposistory.registerUserWithEmailPassword(event.email,event.password);
     await auth.createUserWithEmailAndPassword(email: event.email, password: event.password).then((value) async{
       String uid = FirebaseAuth.instance.currentUser!.uid;
       await UserProfile().setUserProfileDetail(FirebaseUserStoreModel(name:event.name,email: event.email, uid: uid));
       emit(SucessSignUpState());
     }).onError((error, stackTrace)  {
       emit(ErrorSignUpState(error: "Enter Correct Email and Password"));
     });
  }
  FutureOr<void> showPassword(ShowPasswordEvent event, Emitter<SignupState> emit) {
    isObx = !isObx;
    emit(ShowPasswordState());
    // debugPrint(isObx.toString());
  }

  FutureOr<void> showConformPassword(ShowConformPasswordEvent event, Emitter<SignupState> emit) {
    isObxConform = !isObxConform;
    emit(ShowConFormPasswordState());
    debugPrint(isObxConform.toString());
  }
}