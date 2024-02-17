import 'package:dio/dio.dart';
import 'package:mentormatch_apps/mentee/service/bookingClass/bookclass_model.dart';

Future<BookingResultSession> bookClass(String classId, String userId) async {
  const String baseUrl = "https://hwx70h6x-8000.asse.devtunnels.ms"; // Use your actual server URL
  var dio = Dio();

  try {
    final response = await dio.post(
      '$baseUrl/class/$classId/book',
      data: {'userId': userId},
    );

    if (response.statusCode == 200 && response.data != null) {
      int? uniqueCode;
      if (response.data['booking']['uniqueCode'] != null) {
        uniqueCode = int.tryParse(response.data['booking']['uniqueCode'].toString());
      }
      print('Unique code: $uniqueCode');
      return BookingResultSession(isSuccess: true, uniqueCode: uniqueCode);
    } else {
      print('Error booking class: ${response.data}');
      return BookingResultSession(isSuccess: false);
    
    }
  } catch (e) {
    print('Error booking class: $e');
    return BookingResultSession(isSuccess: false);
  }
}
