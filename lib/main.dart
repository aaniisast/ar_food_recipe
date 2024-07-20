import 'package:ar_food_recipe/ui/pages/all_menu_page.dart';
import 'package:ar_food_recipe/ui/pages/detail_kelas_page.dart';
import 'package:ar_food_recipe/ui/pages/detail_menu_page.dart';
import 'package:ar_food_recipe/ui/widgets/bottomNavigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/home',
      getPages: [
        GetPage(name: '/home', page: () => const BottomNavigation()),
        GetPage(name: '/detail-menu', page: () => const DetailMenuPage()),
        GetPage(name: '/detail-kelas', page: () => const DetailKelasPage()),
        GetPage(name: '/all-menu', page: () => const AllMenuPage()),
      ],
    );
  }
}
