import 'package:dio/dio.dart';
import 'package:mentormatch_apps/mentor/model/create_class_models.dart';

class CreateClassService {
  Dio _dio = Dio();
  final String _baseUrl = 'https://hwx70h6x-8000.asse.devtunnels.ms';

  CreateClassService() {
    _dio.options.headers = {
      'Content-Type': 'application/json',
      // Tambahkan header lain jika diperlukan, seperti Authorization
    };
  }

  String get errorMessage => errorMessage;

  Future<dynamic> createClass(CreateClassModels classModel, String mentorId) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/mentor/$mentorId/class',
        data: classModel.toJson(),
      );

      if (response.statusCode == 200) {
        // Feedback berhasil dikirim
        return true;
      } else {
        // Gagal mengirim feedback, baca dan kembalikan pesan error dari backend
        return response.data['message'] ??
            'Terjadi kesalahan yang tidak diketahui.';
      }
    } on DioError catch (e) {
      if (e.response != null) {
        // Gagal karena respons dari server, baca dan kembalikan pesan error dari backend
        return e.response!.data['message'] ??
            'Terjadi kesalahan yang tidak diketahui.';
      } else {
        // Gagal karena alasan lain, seperti kesalahan jaringan atau konfigurasi
        return 'Gagal mengirim feedback: ${e.message}';
      }
    } catch (e) {
      // Tangkap exception lain dan kembalikan sebagai pesan error
      return 'Gagal mengirim feedback: ${e}';
    }
  }
}
