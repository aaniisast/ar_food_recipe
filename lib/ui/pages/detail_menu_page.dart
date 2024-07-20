import 'dart:convert';

import 'package:ar_food_recipe/shared/theme.dart';
import 'package:ar_food_recipe/ui/widgets/descriptionWidget.dart';
import 'package:flutter/material.dart';
import 'package:ar_food_recipe/data/recipes.dart';
import 'package:get/get.dart';

class DetailMenuPage extends StatefulWidget {
  const DetailMenuPage({super.key});

  @override
  State<DetailMenuPage> createState() => _DetailMenuPageState();
}

class _DetailMenuPageState extends State<DetailMenuPage> {
  String nama = Recipes.listRecipeChoosed['nama'].toString();
  String namaFoto = Recipes.listRecipeChoosed['namaFoto'].toString();
  String durasiMasak = Recipes.listRecipeChoosed['durasiMasak'].toString();
  String levelKesulitan =
      Recipes.listRecipeChoosed['levelKesulitan'].toString();
  String deskripsi = Recipes.listRecipeChoosed['deskripsi'].toString();
  var alat = jsonDecode(Recipes.listRecipeChoosed['alat']);
  var bahanList = jsonDecode(Recipes.listRecipeChoosed['bahan']);
  var stepMasak = jsonDecode(Recipes.listRecipeChoosed['stepMasak']);
  @override
  Widget build(BuildContext context) {
    ;
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
                          'https://pkm-foodrecipes.com/recipes/private/$namaFoto',
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
                      nama,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.timelapse,
                          color: Colors.orange,
                          size: 12,
                        ),
                        SizedBox(width: 5),
                        Text(
                          '$durasiMasak menit',
                          style: TextStyle(fontSize: 12),
                        ),
                        SizedBox(width: 5),
                        Icon(
                          Icons.data_exploration_rounded,
                          color: Colors.green,
                          size: 12,
                        ),
                        SizedBox(width: 5),
                        Text(
                          levelKesulitan,
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    DescriptionWidget(description: deskripsi),
                    SizedBox(height: 16),
                    Text(
                      'Bahan-bahan',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: bahanList.length,
                      itemBuilder: (context, index) {
                        return Text("- ${bahanList[index]}",
                            style: TextStyle(fontSize: 14));
                      },
                    ),
                    Divider(),
                    SizedBox(height: 16),
                    Text(
                      'Alat',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: alat.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 4.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('- ', style: TextStyle(fontSize: 14)),
                              Expanded(
                                child: Text(
                                  alat[index],
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    Divider(),
                    Text(
                      'Langkah-langkah',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: stepMasak.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 4.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('- ', style: TextStyle(fontSize: 14)),
                              Expanded(
                                child: Text(
                                  stepMasak[index],
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
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
