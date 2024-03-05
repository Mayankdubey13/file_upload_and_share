import 'dart:io';

abstract class HomeScreenState{

}
class IntialState extends HomeScreenState{

}
class ImageSelectState extends HomeScreenState{

}
class ImageSucessState extends HomeScreenState{
 File img;
 bool cond;
 ImageSucessState({required this.img,required this.cond});
}

class ErrorState extends HomeScreenState{
    String error;
    ErrorState({required this.error});
}
