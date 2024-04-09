import 'package:dio/dio.dart';
import 'package:mentormatch_apps/mentor/model/session_model.dart';
import 'package:mentormatch_apps/style/baseURl.dart';

class SessionServices {
  final Dio _dio = Dio();

  // SessionServices() {
  //   // Menambahkan token ke header default untuk semua permintaan
  //   _dio.options.headers['Authorization'] = 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6IkplcmVteWxld2lAZ21haWwuY29tIiwiaWF0IjoxNzA3MDQ5MzQxfQ.mEg7JJACQbYgaDxYpQaGDZfi92Ks_NmeQ-ZPvpOt3ks';
  // }

  Future<Session> getSessionData() async {
    try {
      final response = await _dio.get('$baseUrl/session/filter-mentors?category');
      if (response.statusCode == 200) {
        return Session.fromMap(response.data);
      } else {
        throw Exception('Failed to load Session data');
      }
    } catch (error) {
      print('Error fetching Session data: $error');
      throw error;
    }
  }
}
