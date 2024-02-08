import 'package:dio/dio.dart';
import 'package:mentormatch_apps/mentor/model/category_kuliah_model.dart';

class KuliahService {
  final Dio _dio = Dio();

  KuliahService() {
    // Menambahkan token ke header default untuk semua permintaan
    _dio.options.headers['Authorization'] = 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6IkplcmVteWxld2lAZ21haWwuY29tIiwiaWF0IjoxNzA3MDQ5MzQxfQ.mEg7JJACQbYgaDxYpQaGDZfi92Ks_NmeQ-ZPvpOt3ks';
  }

  Future<Kuliah> getKuliahData() async {
    try {
      final response = await _dio.get('https://hwx70h6x-8000.asse.devtunnels.ms/filter-mentors?educationLevel=Kuliah');
      if (response.statusCode == 200) {
        return Kuliah.fromMap(response.data);
      } else {
        throw Exception('Failed to load kuliah data');
      }
    } catch (error) {
      print('Error fetching kuliah data: $error');
      throw error;
    }
  }
}
