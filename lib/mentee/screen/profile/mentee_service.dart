import 'package:dio/dio.dart';
import 'package:mentormatch_apps/mentee/model/mentee.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenteeService {
  Dio dio = Dio(); // Create Dio instance
  final String baseUrl = "https://hwx70h6x-8000.asse.devtunnels.ms";

  Future<Mentee> fetchMentee() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');
    try {
      final response = await dio.get("$baseUrl/users/$userId");
      print('API response: ${response.data}');
      return Mentee.fromMap(response.data);
    } catch (error) {
      throw Exception("Failed to fetch Mentee: $error");
    }
  }
}
