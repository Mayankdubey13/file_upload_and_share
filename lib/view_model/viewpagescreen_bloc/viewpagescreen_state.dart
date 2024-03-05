import 'package:flutter/cupertino.dart';

import '../../models/firebasedetailUploadFileModel.dart';

abstract class ViewPageScreenState {

}
class ViewIntialState extends ViewPageScreenState{

}
class ViewLoadingState extends ViewPageScreenState{

}
class ViewLoaderState extends ViewPageScreenState{
  Stream<List<FirebaseDetailUploadFileModel>> fetchData;
  ViewLoaderState({required this.fetchData});
}
class ViewErrorState extends ViewPageScreenState{
  String message ;
  ViewErrorState({required this.message});

}
