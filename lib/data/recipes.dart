import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class Recipes {
  static final Dio _dio = Dio();
  // static final List<Map<String, dynamic>> listRecipes = [
  //   {
  //     'id': '1',
  //     'nama': 'Nasi Goreng',
  //     'deskripsi':
  //         'Nasi goreng sehat menggabungkan keseimbangan nutrisi dengan cita rasa yang khas, menjadikannya pilihan makanan yang cocok untuk diet seimbang dan gaya hidup aktif.',
  //     'levelKesulitan': 'Mudah',
  //     'durasiMasak': '30',
  //     'bahan': ['nasi', 'bawang merah', 'bawang putih', 'telur', 'kecap'],
  //     'alat': ['wajan', 'sendok', 'kompor'],
  //     'stepMasak': [
  //       'Goreng bawang merah dan bawang putih hingga harum.',
  //       'Masukkan telur dan aduk hingga matang.',
  //       'Tambahkan nasi dan kecap, aduk rata.',
  //       'Masak hingga nasi terasa kering dan harum.',
  //     ],
  //     'namaFoto': 'nasi-goreng.jpg',
  //   },
  //   {
  //     'id': '2',
  //     'nama': 'Pisang Goreng',
  //     'deskripsi':
  //         'Sate ayam adalah hidangan Asia Tenggara yang terdiri dari potongan daging ayam yang ditusuk dengan tusuk sate bambu dan dipanggang atau dibakar.',
  //     'levelKesulitan': 'Sulit',
  //     'durasiMasak': '45',
  //     'bahan': [
  //       'ayam',
  //       'bawang merah',
  //       'bawang putih',
  //       'kacang tanah',
  //       'kecap manis'
  //     ],
  //     'alat': ['tusuk sate', 'wajan', 'kompor'],
  //     'stepMasak': [
  //       'Haluskan bawang merah, bawang putih, dan kacang tanah.',
  //       'Potong ayam menjadi potongan kecil.',
  //       'Tusukkan ayam ke tusuk sate.',
  //       'Bakar sate hingga matang sambil diolesi dengan kecap manis.',
  //     ],
  //     'namaFoto': 'pisang-goreng.jpg',
  //   },
  //   {
  //     'id': '3',
  //     'nama': 'Salad Buah Segar',
  //     'deskripsi':
  //         'Salad buah segar adalah campuran berbagai buah-buahan yang segar dan kaya akan vitamin, cocok untuk dinikmati sebagai hidangan penutup sehat.',
  //     'levelKesulitan': 'Mudah',
  //     'durasiMasak': '15',
  //     'bahan': ['apel', 'pir', 'melon', 'anggur', 'stroberi'],
  //     'alat': ['pisau', 'mangkuk besar', 'sendok'],
  //     'stepMasak': [
  //       'Cuci bersih semua buah-buahan.',
  //       'Potong-potong buah-buahan sesuai selera.',
  //       'Campurkan semua buah dalam mangkuk besar.',
  //       'Sajikan salad buah segar dalam mangkuk atau piring saji.',
  //     ],
  //     'namaFoto': 'salad-buah.jpg',
  //   },
  // ];
  static List<Map<String, dynamic>> listRecipes = [];
  static final Map<String, dynamic> listRecipeChoosed = {};

  static Future<void> initializeRecipes() async {
    try {
      listRecipes = await getData();
    } catch (e) {
      print('Error initializing recipes: $e');
    }
  }

  String capitalize(String s) {
    if (s.isEmpty) return s;
    return s.substring(0, 1).toUpperCase() + s.substring(1);
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    try {
      Response response =
          await _dio.get('https://pkm-foodrecipes.com/resep/data-mobile');

      List<dynamic> responseData = response.data['data'];

      List<Map<String, dynamic>> recipes = responseData.map((data) {
        var bahanList = data["bahan"];
        var alatList = data['alat'];
        var stepMasakList = data["stepMasak"];

        return {
          'id': data['id'].toString(),
          'nama': data['nama'],
          'deskripsi': data['deskripsi'],
          'levelKesulitan': data['levelKesulitan'],
          'durasiMasak': data['durasiMasak'].toString(),
          'bahan': bahanList,
          'alat': alatList,
          'stepMasak': stepMasakList,
          'namaFoto': data['namaFoto'],
        };
      }).toList();

      return recipes;
    } catch (e) {
      print('Error fetching data: $e');
      return [];
    }
  }
}
