import 'package:dio/dio.dart';
import 'package:mentormatch_apps/mentee/model/community_model.dart';

class CommunityService {
  final Dio _dio = Dio();

  // Ganti baseURL dengan URL yang sesuai dengan endpoint API Anda
  final String baseUrl = "https://hwx70h6x-8000.asse.devtunnels.ms";

  Future<CommunityModels> fetchCommunities() async {
    try {
      final response = await _dio.get("$baseUrl/communities");
      return CommunityModels.fromMap(response.data);
    } catch (error) {
      throw Exception("Failed to fetch Communities: $error");
    }
  }
}
