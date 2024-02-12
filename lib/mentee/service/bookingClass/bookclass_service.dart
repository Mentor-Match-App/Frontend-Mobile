import 'package:dio/dio.dart';

Future<bool> bookClass(String classId, String userId) async {
  var dio = Dio();
  // Ganti dengan URL server Anda
  
  const String baseUrl = "https://hwx70h6x-8000.asse.devtunnels.ms"; 
  try {
    final response = await dio.post(
      '$baseUrl/class/$classId/book', // URL endpoint untuk booking
      data: {
        'userId': userId, // Data yang dikirimkan
      },
    );
    // Periksa status response, asumsikan 200 menandakan sukses
    return response.statusCode == 200;
  } catch (e) {
    print('Error booking class: $e');
    // Jika terjadi exception, anggap proses booking gagal
    return false;
  }
}

