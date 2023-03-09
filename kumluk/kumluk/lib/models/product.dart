import 'dart:ffi';

class Product {
  late String id;
  late String sellerId;
  List<String>? images;
  String? name;
  String? sellerName;
  String? sellerSurname;
  String? category;
  String? price;
  String? phone;
  String? comment;
  String? sellerNote;
  int? favoritesCount;

  Product(
      {
      required this.sellerId,  
      required this.id,
      this.images,
      this.name,
      this.sellerName,
      this.sellerSurname,
      this.category,
      this.price,
      this.phone,
      this.comment,
      this.sellerNote,
      this.favoritesCount});

  Product.fromJson(Map<String, dynamic> json) {
    images = json['images'].cast<String>();
    sellerId = json['sellerId'];
    id = json['id'];
    sellerName = json['sellerName'];
    sellerSurname = json['sellerSurname'];
    favoritesCount = json['favoritesCount'];
    name = json['name'];
    category = json['category'];
    price = json['price'];
    phone = json['phone'];
    comment = json['comment'];
    sellerNote = json['sellerNote'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['images'] = this.images;
    data['sellerId'] = this.sellerId;
    data['sellerName'] = this.sellerName;
    data['id'] = this.id;
    data['sellerSurname'] = this.sellerSurname;
    data['favoritesCount'] = this.favoritesCount;
    data['name'] = this.name;
    data['category'] = this.category;
    data['price'] = this.price;
    data['phone'] = this.phone;
    data['comment'] = this.comment;
    data['sellerNote'] = this.sellerNote;
    return data;
  }
}