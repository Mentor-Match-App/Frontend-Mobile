import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentor/model/create_class_models.dart';
import 'package:mentormatch_apps/mentor/service/createClass_service.dart';
import 'package:mentormatch_apps/preferences/%20preferences_helper.dart';

class CreateClassProvider with ChangeNotifier {
  List<TextEditingController> controllers = [];
  final CreateClassService _createClassService = CreateClassService();

  Future<bool> submitClass({
    required String address,
    required List<String> targetLearning,
    required String schedule,
    required String location,
    required DateTime endDate,
    required DateTime startDate,
    required int capacitymentee,
    required String educationLevel,
    required String category,
    required String name,
    required String description,
    required List<String> terms,
    required int price,
    required int durationInDays,
  }) async {
    // Ambil mentorId dari shared preferences atau sumber lain
    String? mentorId = await UserPreferences
        .getUserId(); // Sesuaikan dengan implementasi sebenarnya
    if (mentorId == null) {
      print('Error: No mentorId found');
      return false;
    }

    // Membuat instance dari ClassModel dengan data yang diberikan
    var classModel = CreateClassModels(
      address: address,
      targetLearning: targetLearning,
      schedule: schedule,
      location: location,
      endDate: endDate,
      startDate: startDate,
      maxParticipants: capacitymentee,
      educationLevel: educationLevel,
      category: category,
      name: name,
      description: description,
      terms: terms,
      price: price,
      durationInDays: durationInDays,
    );

    // Mengirim data ke server menggunakan CreateClassService
    bool success = await _createClassService.createClass(classModel, mentorId);

    // Notifikasi listener jika diperlukan, misalnya untuk update UI
    notifyListeners();

    return success;
  }

  void addTextField() {
    print("Adding a new text field");
    controllers.add(TextEditingController());
    notifyListeners(); // Beritahu widget yang mendengarkan tentang perubahan
  }

  void deleteTextField(int index) {
    // Pastikan untuk dispose controller sebelum menghapusnya
    controllers[index].dispose();
    controllers.removeAt(index);
    notifyListeners(); // Beritahu widget yang mendengarkan tentang perubahan
  }
}
