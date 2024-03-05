
class FirebaseDetailUploadFileModel {
  String senderEmail;
  String receiverEmail;
  String img;
  String message;

  FirebaseDetailUploadFileModel({
    required this.senderEmail,
    required this.receiverEmail,
    required this.img,
    required this.message,
  });

  // Method to convert the object into a Map
  Map<String, dynamic> toMap() {
    return {
      'senderEmail': senderEmail,
      'receiverEmail': receiverEmail,
      'img': img,
      'message': message,
    };
  }

  // Factory method to create an object from a Map
  factory FirebaseDetailUploadFileModel.fromJson(Map<String, dynamic> json) {
    return FirebaseDetailUploadFileModel(
      senderEmail: json['senderEmail'],
      receiverEmail: json['receiverEmail'],
      img: json['img'],
      message: json['message'],
    );
  }
}
