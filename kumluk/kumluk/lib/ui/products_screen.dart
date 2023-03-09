import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kumluk/controller/product.dart';
import 'package:kumluk/utils/kumluk_sizes.dart';
import 'package:intl/intl.dart';

class ProductsScreen extends StatefulWidget {
  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        Flexible(
            flex: 1,
            child: Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.filter_list,
                          color: Colors.amber.shade800,
                        ),
                        Text(
                          '   Filtrele',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )
                      ],
                    )),
                    Flexible(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.sort_by_alpha, color: Colors.amber.shade800),
                        Text('   Sırala',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold))
                      ],
                    ))
                  ],
                )))),
        (Flexible(
            flex: 10,
            child: Container(
              width: KumlukSizes.getWidth(),
              color: Color.fromRGBO(108, 100, 255, 0.1),
              child: ListView.builder(
                itemBuilder: (_, index) => productWidget(index),
                itemCount: ProductController.to.products.length,
              ),
            )))
      ],
    ));
  }

  productWidget(var index) {

  NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
    print('index: ' + index.toString());
    var product = ProductController.to.products[index];
    return GestureDetector(
        onTap: () => Get.toNamed('/product-details', arguments: product),
        child: Padding(
            padding: EdgeInsets.only(left: 0),
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 0.5, color: Colors.grey))),
              width: KumlukSizes.getWidth() - 20,
              height: KumlukSizes.getHeight() / 15,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                      flex: 1,
                      child: Padding(
                          padding: EdgeInsets.only(
                              left: 5, right: 5, top: 8, bottom: 8),
                          child: Container(
                              height: KumlukSizes.getHeight() / 15,
                              width: KumlukSizes.getWidth(),
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, top: 10, bottom: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 0.5, color: Colors.grey)),
                              child: Image(
                                image: NetworkImage(product.images![0]),
                              )))),
                  Flexible(
                      flex: 2,
                      child: Container(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  product.name!,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(right: 10),
                                    child: Text(product.category.toString()))
                              ]),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                
                                Padding(
                                    padding: EdgeInsets.only(top: 10,right: 10),
                                    child: Text(
                                      myFormat.format(int.parse(product.price!)),
                                      style: TextStyle(
                                          color: Colors.blue.shade900,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ])
                        ],
                      )))
                ],
              ),
            )));
  }
}
