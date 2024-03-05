import 'dart:io';

import 'package:assignment_firebase/view/change_password.dart';
import 'package:assignment_firebase/view/signinPage.dart';
import 'package:assignment_firebase/view/viewPage.dart';
import 'package:assignment_firebase/view_model/homescreen_bloc/homescreen_bloc.dart';
import 'package:assignment_firebase/view_model/homescreen_bloc/homescreen_event.dart';
import 'package:assignment_firebase/view_model/homescreen_bloc/homescreen_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageScreen extends StatefulWidget{
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final auth = FirebaseAuth.instance;

  HomeScreenBloc homeScreenBloc = HomeScreenBloc();

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
  return  Scaffold(
    appBar: AppBar(
      actions: [
        InkWell(
            onTap: () async{
              Navigator.push(context, MaterialPageRoute(builder: (context)=> ChangePasswordScreen()));
            }
            ,child: const Icon(Icons.password_rounded,size: 24,color: Colors.black,)),
        SizedBox(width: 15,),
        InkWell(
         onTap: () async{
           await auth.signOut();
           Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignInScreen()));
         }
            ,child: const Icon(Icons.logout,size: 24,color: Colors.black,))
      ],
    ),
    body:BlocConsumer<HomeScreenBloc,HomeScreenState>(
      bloc: homeScreenBloc,
      builder: (BuildContext context, HomeScreenState state) {
        return  Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment:  CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.blue,
                    child:  InkWell(
                      child: const Icon(Icons.upload,color: Colors.black,size: 25,),
                      onTap: () {

                     homeScreenBloc.add(SelectFileEvent(cond: true));
                      },
                    ),
                  ),
                  SizedBox(width: 10,),
                  Text("Upload")
                ],
              ),
              const SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.blue,
                    child:  InkWell(
                      child: const Icon(Icons.share,color: Colors.black,size: 25,),
                      onTap: () {
                        homeScreenBloc.add(SelectFileEvent(cond: false));
                      },
                    ),
                  ),
                  SizedBox(width: 10,),
                  Text("Share")
                ],
              ),
              SizedBox(height: 30,),
              InkWell(
                onTap: (){

                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.blue,
                      child:  InkWell(
                        child: const Icon(Icons.remove_red_eye,color: Colors.black,size: 25,),
                        onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewPageScreen()));
                        },
                      ),
                    ),
                    SizedBox(width: 10,),
                    Text("View")
                  ],
                ),
              ),


            ],
          ),
        );
      },


      listener: (BuildContext context, HomeScreenState state) {
        if(state is ImageSucessState){
           return  customDialog(context,state.img, state.cond);
        }
      },


    )
  );
  }

  customDialog(BuildContext context, File img, bool fact) {
    TextEditingController text = TextEditingController();
    TextEditingController receiverText = TextEditingController();
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero, // Added to remove default padding
          content: SizedBox(
            height: fact ? 300 : 400, // Adjusted height based on condition
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min, // Ensure minimum size
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    child: Image.file(img),
                  ),
                  const SizedBox(height: 10,),
                  TextFormField(
                    controller: text,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                      hintText: "Enter the message",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  if (!fact)
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: TextFormField(
                        controller: receiverText,
                        decoration: const InputDecoration(
                          contentPadding:  EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                          hintText: "Enter the receiver mail",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel")),
                      const SizedBox(width: 10,),
                      InkWell(
                          onTap: () {
                            if (fact) {
                              homeScreenBloc
                                  .add(FileUploadEvent(mesage: text.text.toString()));
                            } else {
                              homeScreenBloc.add(ShareFileEvent(
                                  mesage: text.text.toString(),
                                  recieverMail: receiverText.text.trim().toString()));
                            }
                            Navigator.pop(context);
                          },
                          child: const Text("Upload",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

}