import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:kumluk/custom_widgets/navigation_bar.dart';
import 'package:kumluk/ui/add_product_screen.dart';
import 'package:kumluk/ui/favorites_screen.dart';
import 'package:kumluk/ui/fund_screen.dart';
import 'package:kumluk/ui/product_details.dart';
import 'package:kumluk/ui/products_screen.dart';
import 'package:kumluk/ui/profile_screen.dart';
import 'package:kumluk/ui/register_screen.dart';
import 'package:kumluk/ui/sign_phone_screen.dart';
import 'package:kumluk/ui/sign_screen.dart';
import 'package:kumluk/ui/welcome_screen.dart';

class AppRoutes {
  AppRoutes._(); //this is to prevent anyone from instantiating this object

  static final staticRoutes = [
    GetPage(
      name: '/welcome',
      page: () => WelcomeScreen()
    ),
    GetPage(name: '/sign', page: () => SignScreen()),
    GetPage(name: '/bottom-navigation', page: () => KumlukNavigationBar()),
    GetPage(name: '/products', page: () => ProductsScreen()),
    GetPage(name: '/favorites', page: () => FavoritesScreen()),
    GetPage(name: '/add-product', page: () => AddProductScreen()),
    GetPage(name: '/fund', page: () => FundScreen()),
    GetPage(name: '/profile', page: () => ProfileScreen()),
    GetPage(name: '/product-details', page: () => ProductDetails()),
    GetPage(name: '/sign-phone', page: () => SignInWithPhoneNumberScreen()),
    GetPage(name: '/register', page: () => RegisterScreen()),
  ];
}