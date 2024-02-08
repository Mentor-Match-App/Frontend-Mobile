import 'package:dio/dio.dart';
import 'package:mentormatch_apps/mentor/model/mentor_model.dart';

class MentorService {
  final Dio _dio = Dio();

  // Ganti baseURL dengan URL yang sesuai dengan endpoint API Anda
  final String baseUrl = "https://hwx70h6x-8000.asse.devtunnels.ms";

  Future<MentorModel> fetchMentors() async {
    try {
      final response = await _dio.get("$baseUrl/mentors");
      return MentorModel.fromMap(response.data);
    } catch (error) {
      throw Exception("Failed to fetch mentors: $error");
    }
  }
}
