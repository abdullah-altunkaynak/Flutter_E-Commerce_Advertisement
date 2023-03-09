import 'package:flutter/material.dart';
import 'package:kumluk/utils/kumluk_sizes.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class Products {
  String? isim;
  int? m2;
  String? mevki;
  double? fiyat;
  String? ozellik;
  String? resim;

  Products(
      {this.isim, this.m2, this.mevki, this.fiyat, this.ozellik, this.resim});
  factory Products.fromMap(var map) {
    return Products(
        isim: map['isim'],
        m2: map['m2'],
        mevki: map['mevki'],
        fiyat: map['fiyat'],
        ozellik: map['ozellik'],
        resim: map['resim']);
  }
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  static Products product1 = Products.fromMap({
    'isim': 'İcar 23 Dönüm',
    'm2': 23000,
    'mevki': 'Deve Taşı',
    'fiyat': 100.000,
    'ozellik': '',
    'resim':
        'https://cdnuploads.aa.com.tr/uploads/Contents/2021/01/29/thumbs_b_c_d9cfb848a77e76f9934c807db071149e.jpg?v=143246'
  });
  static Products product2 = Products.fromMap({
    'isim': 'Honda Civic',
    'm2': 0,
    'mevki': 'Kumluk',
    'fiyat': 705.000,
    'ozellik': '2018 1.6 Diesel Manuel 87.000km',
    'resim': 'https://i0.shbdn.com/photos/54/90/81/x5_9025490812se.jpg'
  });
  static Products product3 = Products.fromMap({
    'isim': 'İcar 23 Dönüm',
    'm2': 23000,
    'mevki': 'Deve Taşı',
    'fiyat': 100.000,
    'ozellik': '',
    'resim':
        'https://cdnuploads.aa.com.tr/uploads/Contents/2021/01/29/thumbs_b_c_d9cfb848a77e76f9934c807db071149e.jpg?v=143246'
  });
  static Products product4 = Products.fromMap({
    'isim': 'Honda Civic',
    'm2': 0,
    'mevki': 'Kumluk',
    'fiyat': 705.000,
    'ozellik': '2018 1.6 Diesel Manuel 87.000km',
    'resim': 'https://i0.shbdn.com/photos/54/90/81/x5_9025490812se.jpg'
  });
  List<Products> products = [
    product1,
    product2,
    product2,
    product3,
    product1,
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) => favoriteProduct(index)));
  }

  favoriteProduct(var index) {
    var product = products[index];
    return Padding(
        padding: EdgeInsets.all(7),
        child: Stack(children: [
          Container(
            width: KumlukSizes.getWidth() / 3,
            height: KumlukSizes.getHeight() / 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                    flex: 4,
                    child: Padding(
                        padding: EdgeInsets.all(0),
                        child: Container(
                            height: KumlukSizes.getHeight() / 12,
                            width: KumlukSizes.getWidth() / 3,
                            padding: EdgeInsets.all(1),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 0.5, color: Colors.grey)),
                            child: Image(
                              image: NetworkImage(product.resim!),
                              fit: BoxFit.cover,
                            )))),
                Flexible(
                    flex: 3,
                    child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(234, 224, 218, 1)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    product.isim!,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Yayında',
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ]),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(children: [
                                    Icon(
                                      Icons.location_on_rounded,
                                      color: Colors.grey.shade700,
                                      size: 12,
                                    ),
                                    Text(
                                      product.mevki.toString(),
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 12),
                                    )
                                  ]),
                                  Padding(
                                      padding: EdgeInsets.only(right: 0),
                                      child: Text(
                                        product.fiyat.toString(),
                                        style: TextStyle(
                                            color: Colors.blue.shade900,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ])
                          ],
                        )))
              ],
            ),
          ),Positioned(
              right: 3,
              top: 5,
              child: GestureDetector(
                onTap: () => print('tıklandı'),
                child: Container(padding: EdgeInsets.all(3),decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.white),child: Icon(
                  Icons.star,
                  color: Color.fromRGBO(255, 160, 0, 1),
                  size: 25,
                )),
              )),
        ]));
  }
}
