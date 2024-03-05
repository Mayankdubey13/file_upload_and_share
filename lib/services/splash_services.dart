import 'dart:async';
import 'package:assignment_firebase/view/homePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../view/signinPage.dart';



class SplashServices {
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user != null) {
      Timer(const Duration(seconds: 2),
              () {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomePageScreen()),(Route<dynamic> route) => false);
              });
    } else
    {
      Timer(const Duration(seconds: 2), () {
       Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignInScreen()));
      });
    }
  }
}
