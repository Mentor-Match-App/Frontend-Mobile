import 'package:dio/dio.dart';
import 'package:mentormatch_apps/mentor/model/category_SD_model.dart';

class SDServices {
  final Dio _dio = Dio();

  // SDServices() {
  //   // Menambahkan token ke header default untuk semua permintaan
  //   _dio.options.headers['Authorization'] = 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6IkplcmVteWxld2lAZ21haWwuY29tIiwiaWF0IjoxNzA3MDQ5MzQxfQ.mEg7JJACQbYgaDxYpQaGDZfi92Ks_NmeQ-ZPvpOt3ks';
  // }

  Future<SD> getSDData() async {
    try {
      final response = await _dio.get('https://hwx70h6x-8000.asse.devtunnels.ms/class/filter-mentors?educationLevel=SD&category');
      if (response.statusCode == 200) {
        return SD.fromMap(response.data);
      } else {
        throw Exception('Failed to load SD data');
      }
    } catch (error) {
      print('Error fetching SD data: $error');
      throw error;
    }
  }
}
