import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kumluk/controller/auth.dart';
import 'package:kumluk/custom_widgets/show_loading_indicator.dart';
import 'package:kumluk/models/product.dart';

class ProductController extends GetxController {
  List<RxString> productCategories = [];
  List<Product> products = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  static ProductController to = Get.find<ProductController>();
  var nowProductId;
  @override
  void onInit() {
    getProductCategories();
    getProducts();
    super.onInit();
  }

  void getProductCategories() async {
    productCategories.clear();
    await _firestore.collection('productCategories').get().then((value) {
      if (value.docs.length != 0) {
        value.docs.forEach((element) {
          print('element: ' + element.id.toString());
          productCategories.add(element.id.obs);
        });
        print(productCategories.toString());
        print(productCategories[0].string);
      }
    });
  }

  void saveProductFirebase(
      {required String productName,
      required String category,
      required String price,
      required String phone,
      required String comment,
      required String sellerNote,
      required List<XFile> productImages}) async {
        getShowLoadingIndicator();
        nowProductId = DateTime.now().millisecondsSinceEpoch;
        Product product = Product(id: nowProductId.toString(), sellerId: _auth.currentUser!.uid);
        product.name = productName;
        product.category = category;
        product.price = price;
        product.phone = phone;
        product.comment = comment;
        product.sellerNote = sellerNote;
        product.favoritesCount = 0;
        product.sellerName = AuthController.to.currentUser.name;
        product.sellerSurname = AuthController.to.currentUser.surname;
        List<String> imageUrls = [];
        for(var i = 0; i < productImages.length; i++){
          var imageUrl = await saveProductImageFirebase(productImages[i],i);
          if(imageUrl != -1)
            imageUrls.add(imageUrl);
        }
        product.images = imageUrls;
        await _firestore.collection('products').doc(product.id).set(product.toJson());
        await getProducts();
        Get.offAllNamed('/bottom-navigation');
        getHideLoadingIndicator();
      }

  saveProductImageFirebase(XFile photo, int index) async {
    Uint8List bytePhoto = await photo.readAsBytes();
    var resultPhoto;
    try{
      resultPhoto = await FlutterImageCompress.compressWithList(
          bytePhoto,
          minWidth: 720,
          minHeight: 960,
        );
      var uploadTask = _firebaseStorage
            .ref("productImages/${nowProductId}")
            .child("product-Image${index}.jpg")
            .putData(resultPhoto);
        uploadTask.snapshotEvents.listen((event) {});

        var storageRef = await uploadTask.whenComplete(() => null);

        var imageUrl = await storageRef.ref.getDownloadURL();
        return imageUrl;
    }catch(e){
      return -1;
    }
  }
  
  getProducts() async {
    products.clear();
    await _firestore.collection('products').get().then((value) {
       if (value.docs.length != 0) {
        value.docs.forEach((element) {
          products.add(Product.fromJson(element.data()));
        });
      }
    });
  }
}
