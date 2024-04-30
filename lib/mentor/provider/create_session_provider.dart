import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentor/model/create_session_model.dart';
import 'package:mentormatch_apps/mentor/service/create_session_service.dart';
import 'package:mentormatch_apps/preferences/%20preferences_helper.dart';

class CreateSessionProvider with ChangeNotifier {
  final CreateSessionService _createSessionService = CreateSessionService();

  Future<bool> submitSession({
    required String category,
    required DateTime date, // Asumsikan ini adalah tanggal tanpa waktu spesifik
    required DateTime
        startTime, // Asumsikan ini adalah String dalam format "HH:mm"
    required DateTime endTime, // Sama seperti startTime
    required int maxParticipants,
    required String description,
    required String title,
  }) async {
    String? mentorId = await UserPreferences.getUserId();
    if (mentorId == null) {
      print('Error: No mentorId found');
      return false;
    }

    var sessionModel = CreateSessionModels(
      category: category,
      dateTime: date, // date sudah dalam format DateTime
      startTime: startTime, // Sekarang sebagai String
      endTime: endTime, // Sekarang sebagai String
      maxParticipants: maxParticipants,
      description: description,
      title: title,
    );

    bool success =
        await _createSessionService.createSession(sessionModel, mentorId);
    notifyListeners();
    return success;
  }
}
