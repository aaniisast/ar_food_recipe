import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ar_food_recipe/data/kelas.dart';
import 'package:ar_food_recipe/shared/theme.dart';

class KelasPage extends StatefulWidget {
  @override
  State<KelasPage> createState() => _KelasPageState();
}

class _KelasPageState extends State<KelasPage> {
  int _selectedCategory = 0; // Menyimpan kategori yang dipilih
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRecipes();
  }

  Future<void> _loadRecipes() async {
    if (Kelas.listRecipes.isEmpty) {
      try {
        await Kelas.initializeRecipes();
        debugPrint(Kelas.listRecipes.toString());
      } catch (e) {
        print('Error initializing recipes: $e');
      } finally {
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
        title: Text('Kelas'),
        centerTitle: true,
      ),
      body: _isLoading
          ? _buildLoading()
          : Column(
              children: [
                // buildNavigationRow(),
                Expanded(
                  child: ListView.builder(
                    itemCount: Kelas.listRecipes.length,
                    itemBuilder: (context, index) {
                      return buildCard(Kelas.listRecipes[index]);
                    },
                  ),
                ),
              ],
            ),
    );
  }

  Widget buildNavigationRow() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 35, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildNavigationToggle(0, 'Tangani'),
          buildNavigationToggle(1, 'Antisipasi'),
        ],
      ),
    );
  }

  Widget buildNavigationToggle(int index, String text) {
    bool isSelected = _selectedCategory == index;

    return InkWell(
      onTap: () {
        setState(() {
          _selectedCategory = index;
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

  Widget buildCard(Map<String, dynamic> kelas) {
    String id = kelas['id'].toString();
    String title = kelas['title'].toString();
    String namaFoto = kelas['namaFoto'].toString();
    String description = kelas['deskripsi'].toString();
    String kategori = kelas['kategori'].toString();

    // bool isCategoryMatched = (_selectedCategory == 0 && kategori.contains('tangani')) ||
    //     (_selectedCategory == 1 && kategori.contains('antisipasi'));

    // if (!isCategoryMatched) {
    //   return SizedBox.shrink();
    // }

    return GestureDetector(
      onTap: () async {
        var kelasChoosed = await getKelasById(id);
        setKelasChoosed(kelasChoosed);
        Get.toNamed('/detail-kelas');
      },
      child: Container(
        height: 150,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: orangeColor, width: 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      title,
                      style: blackTextStyle.copyWith(fontSize: 16),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      description,
                      style: greyTextStyle.copyWith(fontSize: 11),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://pkm-foodrecipes.com/kelas/private/$namaFoto',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Future<Map<String, dynamic>> getKelasById(String id) async {
    if (Kelas.listRecipes.isEmpty) {
      await Kelas.initializeRecipes();
    }
    var kelas = Kelas.listRecipes
        .firstWhere((kelas) => kelas['id'] == id, orElse: () => {});
    return kelas;
  }

  void setKelasChoosed(Map<String, dynamic> kelasChoosed) {
    Kelas.listKelasChoosed.clear();
    Kelas.listKelasChoosed.addAll(kelasChoosed);
  }
}
