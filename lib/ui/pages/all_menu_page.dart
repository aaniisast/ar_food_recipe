import 'package:ar_food_recipe/data/recipes.dart';
import 'package:ar_food_recipe/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui';

class AllMenuPage extends StatefulWidget {
  const AllMenuPage({super.key});

  @override
  State<AllMenuPage> createState() => _AllMenuPageState();
}

class _AllMenuPageState extends State<AllMenuPage> {
  List<Map<String, dynamic>> items = Recipes.listRecipes;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDataIfNeeded();
  }

  Future<void> _loadDataIfNeeded() async {
    if (Recipes.listRecipes.isEmpty) {
      try {
        await Recipes.initializeRecipes();
        setState(() {
          _isLoading = false;
          items = Recipes.listRecipes;
        });
      } catch (e) {
        print('Error loading recipes: $e');
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Semua Menu',
          style: blackTextStyle.copyWith(fontSize: 16, fontWeight: bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: (items.length / 2).ceil(),
              itemBuilder: (context, rowIndex) {
                int startIndex = rowIndex * 2;
                int count = startIndex + 2 <= items.length
                    ? 2
                    : items.length - startIndex;

                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                    ),
                    itemCount: count,
                    itemBuilder: (context, index) {
                      final recipe = items[startIndex + index];
                      final id = recipe['id'];
                      final nama = recipe['nama'];
                      final namaFoto = recipe['namaFoto'];
                      final durasiMasak = recipe['durasiMasak'];

                      return GestureDetector(
                        onTap: () async {
                          Map<String, dynamic> getRecipe = getRecipeById(id);
                          setListRecipeChoosed(getRecipe);
                          Get.toNamed('/detail-menu');
                        },
                        child: Container(
                          padding: EdgeInsets.only(top: 60),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: blackColor,
                            image: DecorationImage(
                              image: NetworkImage(
                                'https://pkm-foodrecipes.com/recipes/private/$namaFoto',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(bottomRight: Radius.circular(30), bottomLeft: Radius.circular(30)),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: 2,
                                sigmaY: 2,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                      blackColor.withOpacity(
                                          0.01),
                                      blackColor.withOpacity(
                                          0),
                                    ],
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text(
                                        nama,
                                        style: whiteTextStyle.copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    // SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, bottom: 12, left: 10, right: 10),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.timelapse,
                                            color: Colors.white,
                                            size: 12,
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            durasiMasak + ' menit',
                                            style: whiteTextStyle.copyWith(
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }

  Map<String, dynamic> getRecipeById(String id) {
    var recipe = Recipes.listRecipes
        .firstWhere((res) => res['id'] == id, orElse: () => {});
    return recipe;
  }

  void setListRecipeChoosed(listRecipeChoosed) {
    Recipes.listRecipeChoosed.clear();
    Recipes.listRecipeChoosed.addAll(listRecipeChoosed);
  }
}
