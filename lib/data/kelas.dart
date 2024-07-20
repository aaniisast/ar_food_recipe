import 'package:dio/dio.dart';

class Kelas {
  static final Dio _dio = Dio();
  // static final List<Map<String, dynamic>> kelasList = [
  //   {
  //     'id': '1',
  //     'title': 'Apa itu Stunting?',
  //     'intro': 'Pengantar singkat mengenai kondisi stunting.',
  //     'deskripsi':
  //         'Stunting adalah kondisi gagal tumbuh pada anak akibat ...',
  //     'namaFoto': 'stunting.jpg',
  //     'kategori': 'tangani',
  //   },
  //   {
  //     'id': '2',
  //     'title': 'Manfaat Sayuran untuk Kesehatan',
  //     'intro': 'Mengenal manfaat yang dimiliki sayuran untuk kesehatan tubuh.',
  //     'deskripsi': 'Sayuran mengandung banyak vitamin dan mineral ...',
  //     'namaFoto': 'sayuran.jpg',
  //     'kategori': 'antisipasi',
  //   },
  // ];
  static List<Map<String, dynamic>> listRecipes = [];
  static final Map<String, dynamic> listKelasChoosed = {};
  static Future<void> initializeRecipes() async {
    try {
      listRecipes = await getData();
    } catch (e) {
      print('Error initializing recipes: $e');
    }
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    try {
      Response response =
          await _dio.get('https://pkm-foodrecipes.com/kelas/data-mobile');

      List<dynamic> responseData = response.data['data'];
      

      List<Map<String, dynamic>> kelas = responseData.map((data) {
        return {
          'id': data['id'].toString(),
          'title': data['title'],
          'intro': data['intro'],
          'deskripsi': data['deskripsi'],
          'namaFoto': data['namaFoto'],
          'kategori': data['kategori'],
        };
      }).toList();

      return kelas;
    } catch (e) {
      print('Error fetching data: $e');
      return [];
    }
  }
}
