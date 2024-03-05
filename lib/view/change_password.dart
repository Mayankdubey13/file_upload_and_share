import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../resources/app_color.dart';
import '../resources/components/round_button.dart';
import '../utils/utils.dart';
class ChangePasswordScreen extends StatefulWidget{
  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}
class _ChangePasswordScreenState extends State<ChangePasswordScreen>  {
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  FocusNode oldFocus = FocusNode();
  FocusNode newFocus = FocusNode();
  FocusNode loginFocus = FocusNode();
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Change Password",
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
                controller: oldPassword,
                focusNode: oldFocus,
        //        keyboardType: TextInputType.emailAddress,
                onFieldSubmitted: (val1){
                  Utils.fieldFocusNode(context, oldFocus,newFocus);
                },
                decoration: InputDecoration(
                  prefixIcon:  Icon(
                    Icons.password_outlined,
                    color: AppColors.blue,
                  ),
                  hintText: 'Old Password',
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
              TextFormField(
                controller: newPassword,
                focusNode: newFocus,
                keyboardType: TextInputType.emailAddress,
                onFieldSubmitted: (val1){
                  Utils.fieldFocusNode(context, newFocus,oldFocus);
                },
                decoration: InputDecoration(
                  prefixIcon:  Icon(
                    Icons.password_rounded,
                    color: AppColors.blue,
                  ),
                  hintText: 'New Password',
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
                text: "Update",
                focusNode: loginFocus,
                onPress: () async {
    final user = await FirebaseAuth.instance.currentUser;
    final cred = EmailAuthProvider.credential(
    email: user!.email.toString(), password: oldPassword.text.toString());
    user.reauthenticateWithCredential(cred).then((value) {
    user.updatePassword(newPassword.text.toString()).then((_) {
      Utils.toastMessage("Your Password update");
    }).catchError((error) {
      Utils.toastMessage(error.toString());
    });
    });}, color: AppColors.blue,
              )
            ],
          )
      ),
    );
  }
}