import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ar_food_recipe/data/recipes.dart';
import 'package:ar_food_recipe/shared/theme.dart';
import 'package:ar_food_recipe/ui/widgets/bottomNavigation.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  bool _isLoading = true; // Track loading state

  @override
  void initState() {
    super.initState();
    if (Recipes.listRecipes.isEmpty) {
      _loadRecipes(); // Load recipes only if list is empty
    } else {
      setState(() {
        _isLoading = false; // Set loading to false if recipes already loaded
      });
    }
  }

  Future<void> _loadRecipes() async {
    try {
      await Recipes.initializeRecipes();
      debugPrint(Recipes.listRecipes.toString());
    } catch (e) {
      print('Error initializing recipes: $e');
    } finally {
      setState(() {
        _isLoading = false; // Recipes loaded, set loading to false
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading ? _buildLoading() : _buildContent();
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(), // Circular progress indicator
    );
  }

  Widget _buildContent() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: whiteColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 13, right: 13, top: 36),
            width: double.infinity,
            height: 280,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/img/bg_home_page.png'),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Hi,',
                      style: whiteTextStyle.copyWith(fontSize: 16),
                    ),
                    Text(
                      'Tamu',
                      style: whiteTextStyle.copyWith(
                          fontSize: 16, fontWeight: bold),
                    ),
                  ],
                ),
                Text(
                  'Pengguna baru Food Recipe app',
                  style: whiteTextStyle.copyWith(fontSize: 10),
                ),
                SizedBox(height: 35),
                Container(
                  constraints: BoxConstraints(maxWidth: 239),
                  child: RichText(
                    text: TextSpan(
                      style: whiteTextStyle.copyWith(fontSize: 20),
                      children: [
                        TextSpan(
                          text:
                              'Temukan resep\nsehat yang anda butuhkan untuk tumbuh kembang si ',
                        ),
                        TextSpan(
                          text: 'balita',
                          style: TextStyle(fontWeight: bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(height: 20),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Resep Andalan',
                        style: blackTextStyle.copyWith(
                            fontSize: 20, fontWeight: bold),
                      ),
                      InkWell(
                        onTap: () {
                          Get.toNamed('/all-menu');
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: greenColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Semua →',
                            style: whiteTextStyle.copyWith(
                                fontSize: 13, fontWeight: bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                Container(
                  width: double.infinity,
                  height: 320,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: buildListResepContent(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildListResepContent() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: Recipes.listRecipes.length,
      itemBuilder: (context, index) {
        return buildResepCard(Recipes.listRecipes[index]);
      },
    );
  }

  Widget buildResepCard(Map<String, dynamic> recipe) {
    String id = recipe['id'].toString();
    String nama = recipe['nama'].toString();
    String namaFoto = recipe['namaFoto'].toString();
    String durasiMasak = recipe['durasiMasak'].toString();
    return GestureDetector(
      onTap: () async {
        Map<String, dynamic> getRecipe = await getRecipeById(id);
        setListRecipeChoosed(getRecipe);
        Get.toNamed('/detail-menu');
      },
      child: Container(
        margin: EdgeInsets.only(right: 20),
        width: 230,
        height: 320,
        padding: EdgeInsets.all(30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: blackColor,
          image: DecorationImage(
            image: NetworkImage(
              'https://pkm-foodrecipes.com/recipes/private/$namaFoto',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              nama,
              style: whiteTextStyle.copyWith(
                fontSize: 18,
                fontWeight: bold,
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.timelapse,
                      color: whiteColor,
                      size: 12,
                    ),
                    SizedBox(width: 5),
                    Text(
                      durasiMasak + ' menit',
                      style: whiteTextStyle.copyWith(fontSize: 12),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildNavigationToggle(int index, String text) {
    bool isSelected = selectedIndex == index;

    return InkWell(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Text(
        text,
        style: blackTextStyle.copyWith(
          fontSize: 14,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Future<Map<String, dynamic>> getRecipeById(String id) async {
    if (Recipes.listRecipes.isEmpty) {
      await Recipes.initializeRecipes();
    }
    var recipe = Recipes.listRecipes
        .firstWhere((res) => res['id'] == id, orElse: () => {});
    return recipe;
  }

  void setListRecipeChoosed(Map<String, dynamic> recipeChoosed) {
    Recipes.listRecipeChoosed.clear();
    Recipes.listRecipeChoosed.addAll(recipeChoosed);
  }
}
