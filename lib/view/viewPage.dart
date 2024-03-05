
import 'package:assignment_firebase/view_model/viewpagescreen_bloc/viewpagescreen_bloc.dart';
import 'package:assignment_firebase/view_model/viewpagescreen_bloc/viewpagescreen_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view_model/viewpagescreen_bloc/viewpagescreen_event.dart';

class ViewPageScreen extends  StatefulWidget{
  @override
  State<ViewPageScreen> createState() => _ViewPageScreenState();
}

class _ViewPageScreenState extends State<ViewPageScreen> {
  ViewPageScreenBloc viewPageScreenBloc = ViewPageScreenBloc();
  @override
  void initState() {
    viewPageScreenBloc.add(IntialViewPageScreenEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("View Your Uploaded File"),
      ),
      body:Column(
        children: [
          BlocBuilder<ViewPageScreenBloc ,ViewPageScreenState>(
            bloc: viewPageScreenBloc,
            builder: (BuildContext context, ViewPageScreenState state) {
              if(state is ViewLoadingState ){
                return const Center(child: CircularProgressIndicator(),);
              }
              else if(state is ViewLoaderState){
                return  StreamBuilder(
                  builder: (context, snap) {
                    if(snap.hasData && snap.data != null && !snap.hasError){
                      return Expanded(
                        child: ListView.builder(
                            itemCount: snap.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return  Padding(
                                padding: const EdgeInsets.only(top: 10,left: 10),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 80,
                                        width: 80,
                                        child: Image.network(snap.data![index].img.toString(),fit: BoxFit.fill,)),
                                    SizedBox(width: 20,),
                                    Expanded(child: Text(snap.data![index].message.toString()))
                                  ],
                                ),
                              );
                            }),
                      );
                    }
                    else {
                      return const Center(child: CircularProgressIndicator());
                    }

                  }, stream: state.fetchData,
                );
              }
              else if (state is ViewErrorState){
               return Text(state.message);
              }
               else{
                 return Container(
                   height: 50,
                   width: 50,
                   color: Colors.blue,
                 );
              }
            },

          ),
        ],
      )
    );

  }

}


