import 'package:ar_food_recipe/data/kelas.dart';
import 'package:ar_food_recipe/shared/theme.dart';
import 'package:ar_food_recipe/ui/widgets/descriptionWidget.dart';
import 'package:flutter/material.dart';
import 'package:ar_food_recipe/data/recipes.dart';
import 'package:get/get.dart';

class DetailKelasPage extends StatefulWidget {
  const DetailKelasPage({super.key});

  @override
  State<DetailKelasPage> createState() => _DetailKelasPageState();
}

class _DetailKelasPageState extends State<DetailKelasPage> {
  String title = Kelas.listKelasChoosed['title'].toString();
  String namaFoto = Kelas.listKelasChoosed['namaFoto'].toString();
  String kategori = Kelas.listKelasChoosed['kategori'].toString();
  String intro = Kelas.listKelasChoosed['intro'].toString();
  String deskripsi = Kelas.listKelasChoosed['deskripsi'].toString();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 240,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          'https://pkm-foodrecipes.com/kelas/private/$namaFoto',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 35,
                    left: 15,
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Icon(Icons.arrow_back),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.health_and_safety_outlined,
                          color: greenColor,
                          size: 12,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Kategori $kategori',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Text(
                      intro,
                      style: blackTextStyle.copyWith(
                        fontSize: 12,
                      ),
                    ),
                    Divider(),
                    SizedBox(height: 24),
                    Text(
                      'Deskripsi',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      deskripsi,
                      style: blackTextStyle.copyWith(
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 150),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
