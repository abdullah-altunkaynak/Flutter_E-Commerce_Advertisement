import 'package:flutter/material.dart';
import 'package:kumluk/ui/add_product_screen.dart';
import 'package:kumluk/ui/favorites_screen.dart';
import 'package:kumluk/ui/fund_screen.dart';
import 'package:kumluk/ui/products_screen.dart';
import 'package:kumluk/ui/profile_screen.dart';
import 'package:kumluk/utils/kumluk_colors.dart';
import 'package:kumluk/utils/kumluk_sizes.dart';

class KumlukNavigationBar extends StatefulWidget{
  const KumlukNavigationBar({super.key});

  @override
  State<KumlukNavigationBar> createState() => _KumlukNavigationBarState();

}

class _KumlukNavigationBarState extends State<KumlukNavigationBar>{
  var _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    var bottomNavigationBarItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(icon: Icon(Icons.search, color: Colors.white), label: 'İlanlar'),
      BottomNavigationBarItem(icon: Icon(Icons.star_border, color: Colors.white), label: 'Favorilerim'),
      BottomNavigationBarItem(icon: Icon(Icons.add, color: Colors.white), label: 'İlan Ekle'),
      BottomNavigationBarItem(icon: Icon(Icons.volunteer_activism_outlined, color: Colors.white), label: 'Fon'),
      BottomNavigationBarItem(icon: Icon(Icons.person_outline, color: Colors.white), label: 'Profilim'),
    ];
    var allPages = [
      ProductsScreen(),
      FavoritesScreen(),
      AddProductScreen(),
      FundScreen(),
      ProfileScreen()
    ];
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false, title: Text(bottomNavigationBarItems[_currentIndex].label.toString()), leading: bottomNavigationBarItems[_currentIndex].icon,),
      body: allPages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        items: bottomNavigationBarItems,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: (KumlukSizes.getHeight() / 64 + KumlukSizes.getHeight() / 64) / 4,
        unselectedFontSize: (KumlukSizes.getHeight() / 64 + KumlukSizes.getHeight() / 64) / 5,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Color.fromRGBO(108, 0, 255,1),
        unselectedItemColor: Colors.white,
        backgroundColor: KumlukColors.primaryBlue,
        selectedIconTheme: IconThemeData(color: Colors.white, shadows: [Shadow(color: Color.fromRGBO(108, 0, 255,1) ,blurRadius: 10)]),
      ),
    );
  }

}