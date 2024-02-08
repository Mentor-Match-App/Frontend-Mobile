// file: user_service.dart

import 'package:dio/dio.dart';
import 'package:mentormatch_apps/mentor/model/mentor_model.dart';

class MentorService {
  final Dio _dio = Dio();
  final String baseUrl = "https://hwx70h6x-8000.asse.devtunnels.ms/mentees";

  Future<List<MentorModel>> getUsers() async {
    try {
      Response response = await _dio.get(baseUrl);
      // Mengakses data menggunakan kunci yang sesuai
      var data =
          response.data['mentees']; // Asumsikan 'users' adalah kunci untuk array
      if (data is List) {
        List<MentorModel> users = data.map((json) => MentorModel.fromMap(json)).toList();
        return users;
      } else {
        throw Exception('Data is not a list');
      }
    } catch (e) {
      print(
          'Error fetching users: ${e.toString()}'); // Tampilkan error di konsol

      throw Exception('Error fetching users: $e');
    }
  }
}
