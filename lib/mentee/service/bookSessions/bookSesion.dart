import 'package:dio/dio.dart';

Future<void> bookSession(String sessionId, String userId) async {
  const String baseUrl = "https://hwx70h6x-8000.asse.devtunnels.ms"; // Gunakan URL server aktual Anda
  var dio = Dio();

  try {
    final response = await dio.post(
      '$baseUrl/session/$sessionId/book',
      data: {'userId': userId},
    );

    // Cek status code untuk memastikan permintaan berhasil
    if (response.statusCode == 200 && response.data != null) {
      // Permintaan berhasil, tidak perlu cek uniqueCode
      print('Success booking session: ${response.data}');
    } else {
      // Permintaan tidak berhasil, handle sesuai dengan status code
      print('Error booking session: Unexpected status code ${response.statusCode}');
      
    }
  // ignore: deprecated_member_use
  } on DioError catch (dioError) {
    // Penanganan error khusus dari Dio
    print('DioError booking session: $dioError');

  } catch (e) {
    // Penanganan error umum
    print('General error booking session: $e');

  }
}
