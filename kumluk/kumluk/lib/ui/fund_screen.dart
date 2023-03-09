import 'package:flutter/material.dart';
import 'package:kumluk/utils/kumluk_sizes.dart';
import 'package:url_launcher/url_launcher.dart';

class FundScreen extends StatefulWidget {
  @override
  State<FundScreen> createState() => _FundScreenState();
}

class _FundScreenState extends State<FundScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
            width: KumlukSizes.getWidth(),
            child: Column(children: [
              Text(
                'İsmet Yıldıran Çınar',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                  onTap: () => phoneCall('tel://05545623773'),
                  child: Container(
                    width: KumlukSizes.getWidth() / 4,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), 
                    color: Colors.blue),
                      child: Row( mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(
                      '0554 562 37 73',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 30,),
                    Icon(Icons.phone, color: Colors.white,),
                    Text('Ara' , style: TextStyle(color: Colors.white),)
                  ])))
            ])),
        Container(
          width: KumlukSizes.getWidth() / 3.5,
          color: Colors.orange,
          height: 1,
        ),
        Container(
            width: KumlukSizes.getWidth(),
            child: Column(children: [
              Text(
                'Ferhat Baloğlu',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                  onTap: () => phoneCall('tel://05544686454'),
                  child: Container(
                    width: KumlukSizes.getWidth() / 4,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), 
                    color: Colors.blue),
                      child: Row( mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(
                      '0554 468 64 54',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 30,),
                    Icon(Icons.phone, color: Colors.white,),
                    Text('Ara', style: TextStyle(color: Colors.white),)
                  ])))
            ]))
      ],
    ));
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
