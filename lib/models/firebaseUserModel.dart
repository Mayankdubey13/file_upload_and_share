class FirebaseUserStoreModel {
  String uid;
  String name;
  String email;


  FirebaseUserStoreModel({required this.name, required this.email,required this.uid});

  Map<String, dynamic> toMap() {
    return {
      'uid':uid,
      'name': name,
      'email': email,
    };
  }
  factory FirebaseUserStoreModel.fromJson(Map<String, dynamic> json) {
    return FirebaseUserStoreModel(
      name: json['name'],
      email: json['email'],
      uid:json['uid']
    );
  }
}
