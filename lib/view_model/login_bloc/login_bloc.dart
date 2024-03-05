import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent,LoginState>{
 // AuthReposistory authReposistory = AuthReposistory();
  final auth = FirebaseAuth.instance;
  bool isObx = true;
  bool?res;
  LoginBloc():super(IntialState()){
    on<SucessLoginEvent>(login);
    on<ShowPasswordEvent>(showPassword);
  }

  FutureOr<void> login(SucessLoginEvent event, Emitter<LoginState> emit) async{
   // res =     await authReposistory.loginUsingEmailAndPassword(event.email,event.password);
    await auth.signInWithEmailAndPassword(email: event.email, password: event.password).then((value) {
      emit(SucessLoginState());

    }).onError((error, stackTrace) {
      emit(ErrorLoginState(error: "Enter Correct Credential's"));
    });
  }
  FutureOr<void> showPassword(ShowPasswordEvent event, Emitter<LoginState> emit) {
    isObx =! isObx;
    emit(ShowPasswordState());
    debugPrint(isObx.toString());
  }
}