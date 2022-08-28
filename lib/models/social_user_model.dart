import 'package:cloud_firestore/cloud_firestore.dart';

class BuzzerUserModel {
  String? name;
  String? email;
  String? phone;
  String? uId;
  String? image;



  BuzzerUserModel({
    this.email,
    this.name,
    this.phone,
    this.uId,
    this.image,
  });

  BuzzerUserModel.fromJson(Map<String, dynamic> json)
  {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    image = json['image'];

  }

  Map<String, dynamic> toMap()
  {
    return {
      'name':name,
      'email':email,
      'phone':phone,
      'uId':uId,
      'image':image,
    };
  }


  factory BuzzerUserModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return BuzzerUserModel(
      email: data?['email'],
      name: data?['name'],
      phone: data?['phone'],
      uId: data?['uId'],
      image: data?['image'],
    );
  }





}