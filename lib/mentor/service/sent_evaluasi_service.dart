import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SendEvaluasiService {
  Dio _dio = Dio();
  String _baseUrl =
      "https://hwx70h6x-8000.asse.devtunnels.ms"; // Sesuaikan dengan URL server Anda

  Future<String> sendEvaluationLink(
      String classId, String topic, String link) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs
        .getString('token'); // Asumsikan token disimpan dengan kunci 'token'

    if (token == null) {
      print("Token tidak ditemukan");
      return "Token tidak ditemukan. Silakan login kembali.";
    }

    String url = "$_baseUrl/class/$classId/evaluation";
    try {
      final response = await _dio.post(
        url,
        data: {
          "topic": topic,
          "link": link,
        },
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token", // Sertakan token di sini
          },
        ),
      );

      if (response.statusCode == 200) {
        // Langsung mengakses response.data karena Dio secara otomatis menguraikan JSON
        return response.data['message'] ?? 'Evaluasi berhasil dikirim.';
      } else {
        print(
            "Gagal mengirim data evaluasi, status code: ${response.statusCode}.");
        // Langsung mengakses response.data karena Dio secara otomatis menguraikan JSON
        return response.data['message'] ??
            'Terjadi kesalahan saat mengirim evaluasi.';
      }
    } on DioError catch (e) {
      if (e.response != null) {
        // Langsung mengakses e.response.data karena Dio secara otomatis menguraikan JSON
        return e.response!.data['message'] ??
            'Terjadi kesalahan yang tidak diketahui.';
      } else {
        return "Terjadi kesalahan saat mengirim data evaluasi: $e";
      }
    }
  }
}
