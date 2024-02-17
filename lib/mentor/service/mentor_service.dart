import 'package:dio/dio.dart';
import 'package:mentormatch_apps/mentor/model/mentor_model.dart'; // Pastikan path ini sesuai

class MentorService {
  final Dio _dio = Dio();

  // URL yang sudah disesuaikan dengan endpoint baru
  final String baseUrl = "https://hwx70h6x-8000.asse.devtunnels.ms/class/filter-mentors";

  Future<MentorClassModel> fetchFilteredMentors() async {
    try {
      // Melakukan request GET ke endpoint filter-mentors
      final response = await _dio.get(baseUrl);
      // Menggunakan MentorClassModel untuk parsing data JSON yang diterima
      return MentorClassModel.fromMap(response.data);
    } catch (error) {
      // Menangani kesalahan yang mungkin terjadi selama request atau parsing
      throw Exception("Failed to fetch filtered mentors: $error");
    }
  }
}
