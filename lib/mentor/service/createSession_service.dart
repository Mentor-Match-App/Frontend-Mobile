import 'package:dio/dio.dart';
import 'package:mentormatch_apps/mentor/model/create_session_model.dart';

class CreateSessionService{
  Dio _dio = Dio();
  final String _baseUrl = 'https://hwx70h6x-8000.asse.devtunnels.ms';

  CreateSessionsService(){
    _dio.options.headers = {
      'Content-Type': 'application/json',
      // Tambahkan header lain jika diperlukan, seperti Authorization
    };
  }

  Future<bool> createSession(CreateSessionModels sessionModel, String mentorId) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/mentor/$mentorId/session',
        data: sessionModel.toJson(),
      );

      if (response.statusCode == 200) {
        print('session created successfully: ${response.data}');
        return true;
      } else {
        print('Failed to create session: ${response.statusCode}');
        return false;
      }
    } on DioError catch (e) {
      print('Error creating session: ${e.message}');
      if (e.response != null) {
        print('Error response data: ${e.response!.data}');
      }
      return false;
    }
  }
}