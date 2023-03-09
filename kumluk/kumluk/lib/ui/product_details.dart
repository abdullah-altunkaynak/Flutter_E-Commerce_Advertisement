import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kumluk/custom_widgets/carousel_slider.dart';
import 'package:kumluk/custom_widgets/kumluk_button.dart';
import 'package:kumluk/models/product.dart';
import 'package:kumluk/utils/kumluk_sizes.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetails extends StatefulWidget {
  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails>
    with SingleTickerProviderStateMixin, RestorationMixin {
  late TabController _tabController;
  final RestorableInt tabIndex = RestorableInt(0);
  @override
  // TODO: implement restorationId
  String get restorationId => 'tab_non_scrollable_demo';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(tabIndex, 'tab_index');
    _tabController.index = tabIndex.value;
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );
    _tabController.addListener(() {
      // When the tab controller's value is updated, make sure to update the
      // tab index value, which is state restorable.
      setState(() {
        tabIndex.value = _tabController.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Product product = Get.arguments;
    List<Widget> sliderImagesList= [];
    for(var i = 0; i < product.images!.length; i++){
     var widgetImage =  Image(
                  image: NetworkImage(
                       product.images![i]));
                       sliderImagesList.add(widgetImage);
    }
    final tabs = ['İlan Bilgileri', 'Açıklama', 'Konumu'];
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: (Container(
          width: KumlukSizes.getWidth() / 8,
          height: 50,
          child: KumlukButton(
            onPressed: () => phoneCall('tel://0' + product.phone!),
            buttonColor: Colors.blue,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.phone,
                  color: Colors.white,
                  size: 20,
                ),
                Text(
                  'Ara',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )
              ],
            ),
          ))),
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
        title: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Flexible(
              flex: 3,
              child: Text(
                'İlan Detayı',
                textAlign: TextAlign.start,
              )),
          Flexible(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    child: Icon(
                      Icons.share,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 15),
                  GestureDetector(
                    child: Icon(
                      Icons.star,
                      color: Colors.white,
                    ),
                  )
                ],
              ))
        ]),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Column(children: [
        Container(
          padding: EdgeInsets.all(10),
          width: KumlukSizes.getWidth(),
          color: Colors.grey.shade300,
          child: Text(
            product.name!,
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          // border: Border(bottom: BorderSide(width: 7, color: Colors.blue.shade900)),
          decoration: BoxDecoration(color: Color.fromARGB(255, 255, 255, 255)),

          child: Center(
              child: CarouselSliderDesign(
            autoPlay: false,
            aspectRatio: 16 / 9,
            bottomStatusBar: BottomStatusBar.below,
            bottomStatusBarCircle: BottomStatusBarCircle.big,
            sliderChildren: 
            sliderImagesList
          )),
        ),
        Container(
          padding: EdgeInsets.all(10),
          width: KumlukSizes.getWidth(),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      width: 1, color: Color.fromARGB(255, 200, 198, 198))),
              color: Colors.white),
          child: Text(
            product.sellerName! + ' ' + product.sellerSurname!,
            style: TextStyle(color: Colors.blue.shade600, fontSize: 17),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          width: KumlukSizes.getWidth(),
          child: Text(
            'Konya, Çumra, Deve Taşı Mah.',
            style: TextStyle(
                color: Color.fromARGB(255, 138, 137, 137), fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          width: KumlukSizes.getWidth(),
          height: 500,
          color: Color.fromARGB(255, 255, 255, 255),
          child: Column(
            children: [
              Container(
                  width: KumlukSizes.getWidth(),
                  height: 50,
                  child: TabBar(
                    labelColor: Colors.black,
                    indicator: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10))),
                    controller: _tabController,
                    isScrollable: false,
                    tabs: [for (final tab in tabs) Tab(text: tab)],
                  )),
              Container(
                  width: KumlukSizes.getWidth(),
                  height: 450,
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(color: Colors.orange, width: 2))),
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      for (final tab in tabs)
                      tab != 'Açıklama' ?
                        Center(
                          child: Text(tab),
                        ) : Center(child: Text(product.comment!),),
                    ],
                  ))
            ],
          ),
        ),
        Container(
            color: Color.fromARGB(255, 208, 207, 207),
            padding: EdgeInsets.all(10),
            width: KumlukSizes.getWidth(),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Satıcı Notu',
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    product.sellerNote!,
                    style: TextStyle(color: Color.fromARGB(255, 111, 110, 110)),
                  )
                ])),
        SizedBox(
          height: 75,
        ),
      ])),
    );
  }
}

phoneCall(var s) async {
  print('tıklandı arama işlemine yonlendirecek');

  print('fonksiyon çalışıyor');
  var tel = {s};
  try {
    await launch(s);
  } catch (_e) {
    print(_e);
  }
}
