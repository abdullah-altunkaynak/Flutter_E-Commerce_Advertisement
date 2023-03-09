import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kumluk/controller/auth.dart';
import 'package:kumluk/controller/product.dart';
import 'package:kumluk/custom_widgets/carousel_slider.dart';
import 'package:kumluk/custom_widgets/dropdown_button.dart';
import 'package:kumluk/custom_widgets/kumluk_button.dart';
import 'package:kumluk/utils/kumluk_sizes.dart';

class AddProductScreen extends StatefulWidget {
  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  List<XFile>? _imageFileList;
  List<Widget>? _sliderImageList = [];
  void _setImageFileListFromFile(XFile? value) {
    _imageFileList = value == null ? null : <XFile>[value];
  }

  dynamic _pickImageError;
  bool isVideo = false;
  final TextEditingController maxWidthController = TextEditingController();
  final TextEditingController maxHeightController = TextEditingController();
  final TextEditingController qualityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController commentController = TextEditingController();
  final TextEditingController sellerNoteController = TextEditingController();
  final TextEditingController productNameController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  var categorySelectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
            child: Column(
      children: [
        Container(
          color: Colors.transparent,
          height: 20,
        ),
        Container(
            width: KumlukSizes.getWidth(),
            color: Colors.transparent,
            child: Center(
                child: Text(
              'Ürün Fotoğraflarını Ekleyiniz',
              style: TextStyle(color: Colors.orange, fontSize: 20),
            ))),
        Container(
          color: Colors.transparent,
          height: 10,
        ),
        Container(
            color: Colors.transparent,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                  width: KumlukSizes.getWidth(),
                  decoration: BoxDecoration(
                      color: Colors.amber.shade400,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.transparent, width: 0)),
                  child: _imageFileList == null
                      ? GestureDetector(
                          child: Container(
                            width: KumlukSizes.getWidth() / 12,
                            height: 250,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade400,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Colors.transparent, width: 0)),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                          onTap: () => openGallery(),
                        )
                      : Container(
                          // border: Border(bottom: BorderSide(width: 7, color: Colors.blue.shade900)),
                          decoration:
                              BoxDecoration(color: Colors.grey.shade400),

                          child: Center(
                              child: CarouselSliderDesign(
                                  autoPlay: false,
                                  aspectRatio: 16 / 9,
                                  bottomStatusBar: BottomStatusBar.below,
                                  bottomStatusBarCircle:
                                      BottomStatusBarCircle.big,
                                  sliderChildren: _sliderImageList != null
                                      ? _sliderImageList!
                                      : [
                                          Image(
                                              image: NetworkImage(
                                                  'https://cdnuploads.aa.com.tr/uploads/Contents/2021/01/29/thumbs_b_c_d9cfb848a77e76f9934c807db071149e.jpg?v=143246'))
                                        ])),
                        )),
            )),
        Container(
          color: Colors.transparent,
          height: 8,
        ),
        Container(
          height: 1,
          color: Colors.grey,
          width: KumlukSizes.getWidth() / 3,
        ),
        Container(
          color: Colors.transparent,
          height: 17,
        ),
        Container(
            color: Colors.transparent,
            width: KumlukSizes.getWidth(),
            child: Center(
                child: Text(
              'Ürün İsmi Giriniz',
              style: TextStyle(color: Colors.orange, fontSize: 20),
            ))),
        Container(
          color: Colors.transparent,
          height: 10,
        ),
        Container(
            padding: EdgeInsets.only(left: 40, right: 40, bottom: 20),
            width: KumlukSizes.getWidth(),
            color: Colors.transparent,
            child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: Container(
                    width: KumlukSizes.getWidth() / 4,
                    child: TextField(
                      controller: productNameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          labelText: 'Bu isim ürün sergilenirken gösterilir',
                          labelStyle: TextStyle(
                              color: Color.fromARGB(255, 53, 152, 234),
                              fontSize: 20),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 53, 152, 234))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 53, 152, 234))),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 53, 152, 234)))),
                    )))),
        Container(
          color: Colors.transparent,
          height: 8,
        ),
        Container(
          height: 1,
          color: Colors.grey,
          width: KumlukSizes.getWidth() / 3,
        ),
        Container(
          color: Colors.transparent,
          height: 17,
        ),
        Container(
            color: Colors.transparent,
            width: KumlukSizes.getWidth(),
            child: Center(
                child: Text(
              'Ürün Kategorisi Seçiniz',
              style: TextStyle(color: Colors.orange, fontSize: 20),
            ))),
        Container(
          color: Colors.transparent,
          height: 10,
        ),
        Center(
            child: Container(
                width: KumlukSizes.getWidth(),
                height: KumlukSizes.getHeight() / 18,
                color: Colors.transparent,
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                    ),
                    itemCount: ProductController.to.productCategories.length,
                    itemBuilder: (context, index) => categoriesButton(index)))),
        Container(
          color: Colors.transparent,
          height: 8,
        ),
        Container(
          height: 1,
          color: Colors.grey,
          width: KumlukSizes.getWidth() / 3,
        ),
        Container(
          color: Colors.transparent,
          height: 17,
        ),
        Container(
            color: Colors.transparent,
            width: KumlukSizes.getWidth(),
            child: Center(
                child: Text(
              'Ürün Fiyat Bilgisi Giriniz',
              style: TextStyle(color: Colors.orange, fontSize: 20),
            ))),
        Container(
          color: Colors.transparent,
          height: 10,
        ),
        Container(
            padding: EdgeInsets.only(left: 40, right: 40, bottom: 20),
            width: KumlukSizes.getWidth(),
            color: Colors.transparent,
            child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: Container(
                    width: KumlukSizes.getWidth() / 4,
                    child: TextField(
                      controller: priceController,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                          labelText: 'Fiyat',
                          labelStyle: TextStyle(
                              color: Color.fromARGB(255, 53, 152, 234),
                              fontSize: 20),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 53, 152, 234))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 53, 152, 234))),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 53, 152, 234)))),
                    )))),
        Container(
          color: Colors.transparent,
          height: 8,
        ),
        Container(
          height: 1,
          color: Colors.grey,
          width: KumlukSizes.getWidth() / 3,
        ),
        Container(
          color: Colors.transparent,
          height: 17,
        ),
        Container(
            width: KumlukSizes.getWidth(),
            color: Colors.transparent,
            child: Center(
                child: Text(
              'Telefon Bilgisi Giriniz',
              style: TextStyle(color: Colors.orange, fontSize: 20),
            ))),
        Container(
          color: Colors.transparent,
          height: 10,
        ),
        Container(
            width: KumlukSizes.getWidth(),
            color: Colors.transparent,
            padding: EdgeInsets.only(left: 40, right: 40, bottom: 20),
            child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: Container(
                    width: KumlukSizes.getWidth() / 4,
                    child: TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          labelText: 'Telefon',
                          labelStyle: TextStyle(
                              color: Color.fromARGB(255, 53, 152, 234),
                              fontSize: 20),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 53, 152, 234))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 53, 152, 234))),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 53, 152, 234)))),
                    )))),
        Container(
          color: Colors.transparent,
          height: 8,
        ),
        Container(
          height: 1,
          color: Colors.grey,
          width: KumlukSizes.getWidth() / 3,
        ),
        Container(
          color: Colors.transparent,
          height: 17,
        ),
        Container(
            color: Colors.transparent,
            width: KumlukSizes.getWidth(),
            child: Center(
                child: Text(
              'Ürün Açıklaması Giriniz',
              style: TextStyle(color: Colors.orange, fontSize: 20),
            ))),
        Container(
          color: Colors.transparent,
          height: 10,
        ),
        Container(
            width: KumlukSizes.getWidth(),
            color: Colors.transparent,
            padding: EdgeInsets.only(left: 40, right: 40, bottom: 20),
            child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: Container(
                    width: KumlukSizes.getWidth() / 4,
                    child: TextField(
                      controller: commentController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          labelText: 'Açıklama',
                          labelStyle: TextStyle(
                              color: Color.fromARGB(255, 53, 152, 234),
                              fontSize: 20),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 53, 152, 234))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 53, 152, 234))),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 53, 152, 234)))),
                    )))),
        Container(
          color: Colors.transparent,
          height: 8,
        ),
        Container(
          height: 1,
          color: Colors.grey,
          width: KumlukSizes.getWidth() / 3,
        ),
        Container(
          color: Colors.transparent,
          height: 17,
        ),
        Container(
            width: KumlukSizes.getWidth(),
            color: Colors.transparent,
            child: Center(
                child: Text(
              'Satıcı Notu Giriniz',
              style: TextStyle(color: Colors.orange, fontSize: 20),
            ))),
        Container(
          color: Colors.transparent,
          height: 10,
        ),
        Container(
            width: KumlukSizes.getWidth(),
            color: Colors.transparent,
            padding: EdgeInsets.only(left: 40, right: 40, bottom: 20),
            child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: Container(
                    width: KumlukSizes.getWidth() / 4,
                    child: TextField(
                      controller: sellerNoteController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          labelText: 'Satıcı Notu',
                          labelStyle: TextStyle(
                              color: Color.fromARGB(255, 53, 152, 234),
                              fontSize: 20),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 53, 152, 234))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 53, 152, 234))),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 53, 152, 234)))),
                    )))),
        SizedBox(
          height: 40,
        ),
        KumlukButton(
          onPressed: () {
            ProductController.to.saveProductFirebase(
                productName: productNameController.text,
                category: ProductController
                    .to.productCategories[categorySelectedIndex].string,
                    price: priceController.text,
                    phone: phoneController.text,
                    comment: commentController.text,
                    sellerNote: sellerNoteController.text,
                    productImages: _imageFileList!);
          },
          buttonColor: Color.fromARGB(255, 6, 191, 28),
          buttonHeight: KumlukSizes.getHeight() / 28,
          child: Container(
              width: KumlukSizes.getWidth() / 6,
              child: Center(
                  child: Text(
                'Satışa Koy',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ))),
        ),
        SizedBox(
          height: 30,
        ),
      ],
    )));
  }

  Future<void> openGallery() async {
    print('galeri açıldı!!');
    await _displayPickImageDialog(context,
        (double? maxWidth, double? maxHeight, int? quality) async {
      print('_displayPickImageDialog çalıştı!');
      try {
        final List<XFile> pickedFileList = await _picker.pickMultiImage(
          maxWidth: maxWidth,
          maxHeight: maxHeight,
          imageQuality: quality,
        );
        print('pickedFileList alındı!' + pickedFileList.toString());
        setState(() {
          if (pickedFileList.length > 0) {
            _imageFileList = pickedFileList;
            for (var i = 0; i < _imageFileList!.length; i++) {
              _sliderImageList?.add(Image.file(File(_imageFileList![i].path)));
            }
          }

          print('setState ile _imageFileList değişti!' +
              _imageFileList.toString());
        });
      } catch (e) {
        setState(() {
          _pickImageError = e;
          print('error' + e.toString());
        });
      }
    });
  }

  Future<void> _displayPickImageDialog(
      BuildContext context, OnPickImageCallback onPick) async {
    print('imagedialog çalışacak!');
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Galeriye Devam et veya vazgeç!'),
            actions: <Widget>[
              TextButton(
                child: const Text('VAZGEÇ'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                  child: const Text('GALERİYİ AÇ'),
                  onPressed: () {
                    final double? width = maxWidthController.text.isNotEmpty
                        ? double.parse(maxWidthController.text)
                        : null;
                    final double? height = maxHeightController.text.isNotEmpty
                        ? double.parse(maxHeightController.text)
                        : null;
                    final int? quality = qualityController.text.isNotEmpty
                        ? int.parse(qualityController.text)
                        : null;
                    onPick(width, height, quality);
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
  }

  categoriesButton(int index) {
    bool selected = false;
    return GestureDetector(
      onTap: () => setState(() {
        categorySelectedIndex = index;
      }),
      child: Padding(
          padding: EdgeInsets.all(5),
          child: Container(
              decoration: BoxDecoration(
                  color: index != categorySelectedIndex
                      ? Colors.blue.shade100
                      : Colors.blue.shade600,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Center(
                  child: Text(
                ProductController.to.productCategories[index].string,
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              )))),
    );
  }
}

typedef OnPickImageCallback = void Function(
    double? maxWidth, double? maxHeight, int? quality);

class AspectRatioVideo extends StatefulWidget {
  const AspectRatioVideo({Key? key}) : super(key: key);

  @override
  AspectRatioVideoState createState() => AspectRatioVideoState();
}

class AspectRatioVideoState extends State<AspectRatioVideo> {
  bool initialized = false;

  void _onVideoControllerUpdate() {
    if (!mounted) {
      return;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (initialized) {
      return Center(child: Text('hey'));
    } else {
      return Container();
    }
  }
}
