import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../resources/app_color.dart';
import '../resources/components/round_button.dart';
import '../utils/utils.dart';
class ForgetPasswordScreen extends StatefulWidget{
  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}
class _ForgetPasswordScreenState extends State<ForgetPasswordScreen>  {
  TextEditingController email = TextEditingController();
  TextEditingController forgetPassword = TextEditingController();
  FocusNode emailFocus = FocusNode();
  FocusNode loginFocus = FocusNode();
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Forgot Password",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
          padding: const EdgeInsets.only(top: 100, right: 20, left: 20),
          child:
          Column(
                children: [
                  TextFormField(
                    controller: email,
                    focusNode: emailFocus,
                    keyboardType: TextInputType.emailAddress,
                    onFieldSubmitted: (val1){
                      Utils.fieldFocusNode(context, emailFocus,loginFocus);
                    },
                    decoration: InputDecoration(
                      prefixIcon:  Icon(
                        Icons.email,
                        color: AppColors.blue,
                      ),
                      hintText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: AppColors.black26,

                        ),
                      ),
                      focusedBorder:
                      OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                              color: AppColors.blueAccent,
                              width: 2
                          )
                      ),

                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  RoundButton(
                    text: "Forgot",
                    focusNode: loginFocus,
                    onPress: () {
                      _auth
                          .sendPasswordResetEmail(
                          email: email.text.toString().trim())
                          .then((value) {
                        Utils.toastMessage("CODE SENT IN GIVEN EMAIL");

                      }).onError((error, stackTrace) {
                        debugPrint("VFDVFDFVDFDFDFD$error");
                        Utils.toastMessage(error.toString());
                      });
                    }, color: AppColors.blue,
                  )
                ],
              )
           ),
    );
  }
}