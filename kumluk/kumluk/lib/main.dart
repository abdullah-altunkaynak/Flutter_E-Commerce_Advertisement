import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:kumluk/constant/app_routes.dart';
import 'package:kumluk/controller/auth.dart';
import 'package:kumluk/controller/product.dart';
import 'package:kumluk/services/auth_services.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(ProductController());
  Get.put(AuthController());
  Get.put(AuthService());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  bool isFirstRoute = true;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Kumluk",
      color: Colors.white,
      scrollBehavior: ScrollBehavior(),
      initialRoute: '/welcome',
      getPages: AppRoutes.staticRoutes,
    );
  }
}


