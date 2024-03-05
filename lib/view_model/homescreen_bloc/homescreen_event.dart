abstract class HomeScreenEvent{

}
class SelectFileEvent extends HomeScreenEvent{
 bool cond ;
 SelectFileEvent({required this.cond});
}
class FileUploadEvent extends HomeScreenEvent{
  String mesage;
  FileUploadEvent({required this.mesage});

}
class ShareFileEvent extends HomeScreenEvent{
  String mesage;
  String recieverMail;
    ShareFileEvent({required this.mesage,required this.recieverMail});
}