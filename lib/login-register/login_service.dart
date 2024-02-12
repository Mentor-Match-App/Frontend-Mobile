import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Dio dio = Dio();
  final String baseUrl =
      "https://hwx70h6x-8000.asse.devtunnels.ms"; // Ganti dengan URL server Anda

  Future<void> loginUser(String idToken) async {
    try {
      final response = await dio.post(
        '$baseUrl/login',
        data: {
          'token':
              idToken, // Pastikan ini sesuai dengan cara server Anda menerima token
        },
      );

      if (response.statusCode == 200) {
        print("Login berhasil: ${response.data}");

        // Simpan user ID dan token ke SharedPreferences
        final userId = response.data['user']['id'];
        final token = response.data['token'];

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('userId', userId);
        await prefs.setString('token', token);
      } else {
        print("Error saat login: ${response.statusCode}");
      }
    } on DioError catch (e) {
      print("Dio error: ${e.response?.data ?? e.message}");
    } catch (e) {
      print("Error umum: $e");
    }
  }

  // Function ini digunakan untuk mengambil data user ID dan token dari SharedPreferences
  
  static Future<Map<String, String?>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    final token = prefs.getString('token');
    return {
      'userId': userId,
      'token': token,
    };
  }
}
