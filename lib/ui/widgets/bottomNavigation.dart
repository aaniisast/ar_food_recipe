import 'package:ar_food_recipe/ui/pages/home_page.dart';
import 'package:ar_food_recipe/ui/pages/kelas_page.dart';
import 'package:ar_food_recipe/ui/pages/bantuan_page.dart';
import 'package:ar_food_recipe/ui/pages/scan_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:ar_food_recipe/shared/theme.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  var _currentIndex = 0;
  final List<Widget> _pages = [
    HomePage(),
    ScanPage(),
    KelasPage(),
    // BantuanPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: _pages[_currentIndex],
      bottomNavigationBar: SalomonBottomBar(
        backgroundColor: whiteColor,
        currentIndex: _currentIndex,
        onTap: (i) => setState(() {
          _currentIndex = i;
        }),
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: Icon(Icons.home),
            title: Text("Buku Resep"),
            selectedColor: Colors.green,
          ),

          /// Likes
          SalomonBottomBarItem(
            icon: Icon(Icons.qr_code_scanner),
            title: Text("Scan"),
            selectedColor: Colors.green,
          ),

          /// Search
          SalomonBottomBarItem(
            icon: Icon(Icons.search),
            title: Text("Kelas"),
            selectedColor: Colors.green,
          ),

          /// Profile
          // SalomonBottomBarItem(
          //   icon: Icon(Icons.supervisor_account),
          //   title: Text("Bantuan"),
          //   selectedColor: Colors.teal,
          // ),
        ],
      ),
    );
  }
}
