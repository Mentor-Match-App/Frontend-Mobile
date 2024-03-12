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

  Future<bool> createClass(CreateClassModels classModel, String mentorId) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/mentor/$mentorId/class',
        data: classModel.toJson(),
      );

      if (response.statusCode == 200) {
        print('Class created successfully: ${response.data}');
        return true;
      } else {
        print('Failed to create class: ${response.statusCode}');
        return false;
      }
    } on DioError catch (e) {
      print('Error creating class: ${e.message}');
      if (e.response != null) {
        print('Error response data: ${e.response!.data}');
      }
      return false;
    }
  }
}


