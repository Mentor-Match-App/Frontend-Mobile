import 'package:dio/dio.dart';
import 'package:mentormatch_apps/mentee/model/mentee_person.dart';
import 'package:mentormatch_apps/style/base_url.dart';


class MenteeService {
  final Dio _dio = Dio();

  // Gunakan URL yang Anda berikan sebagai baseURL
  

  Future<MenteeModel> fetchMentees() async {
    try {
      final response = await _dio.get("$baseUrl/mentees");
      return MenteeModel.fromMap(response.data);
    } catch (error) {
      throw Exception("Failed to fetch mentees: $error");
    }
  }
}
