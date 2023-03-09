import 'package:cloud_firestore/cloud_firestore.dart';
class UserModel {
  String? uid;
  String? name;
  String? surname;
  String? profilPhoto;
  List<String>? favorites;
  List<String>? productsSelling;
  String? device;
  List<String>? fcmTokens;
  Timestamp? lastLogin;
  Timestamp? creationDate;
  String? phoneNumber;
  String? loginType;

  UserModel(
      {this.uid,
      this.name,
      this.surname,
      this.profilPhoto,
      this.favorites,
      this.productsSelling,
      this.device,
      this.fcmTokens,
      this.lastLogin,
      this.creationDate,
      this.phoneNumber,
      this.loginType});

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    surname = json['surname'];
    profilPhoto = json['profil-photo'];
    favorites = json['favorites'] == null ? null :  json['favorites'].cast<String>();
    productsSelling = json['productsSelling'] == null ? null : json['productsSelling'].cast<String>();
    device = json['device'];
    fcmTokens = json['fcmTokens'] == null ? null : json['fcmTokens'].cast<String>();
    lastLogin = json['lastLogin'];
    creationDate = json['creationDate'];
    phoneNumber = json['phoneNumber'];
    loginType = json['loginType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['name'] = this.name;
    data['surname'] = this.surname;
    data['profil-photo'] = this.profilPhoto;
    data['favorites'] = this.favorites;
    data['productsSelling'] = this.productsSelling;
    data['device'] = this.device;
    data['fcmTokens'] = this.fcmTokens;
    data['lastLogin'] = this.lastLogin;
    data['creationDate'] = this.creationDate;
    data['phoneNumber'] = this.phoneNumber;
    data['loginType'] = this.loginType;
    return data;
  }
}