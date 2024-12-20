import 'package:clean_architecture_flutter/features/onboarding/data/datasources/onboarding_datasource.dart';
import 'package:clean_architecture_flutter/shared/data/local/storage_service.dart';

class OnboardingLocalDataSource extends OnboardingDatasource {
  final StorageService storageService;

  OnboardingLocalDataSource({required this.storageService});

  @override
  Future<bool> getOnboardingStatus() async {
    try {
      // ดึงค่าจาก Storage และแปลงค่าให้เป็น bool หากไม่ได้ค่า
      final result = await storageService.get('onboarding_completed');
      return result is bool ? result : false; // ถ้าค่าไม่ใช่ bool ให้ใช้ค่า false เป็นค่าเริ่มต้น
    } catch (e) {
      // ถ้ามีข้อผิดพลาดในการดึงข้อมูล ให้ log ข้อผิดพลาดและส่งคืน false
      print("Error getting onboarding status: $e");
      throw Exception();

    }
  }

  @override
  Future<void> setOnboardingStatus(bool status) async {
    try {
      // ตั้งค่าความสำเร็จหรือสถานะการทำ Onboarding ลงใน storage
      await storageService.set('onboarding_completed', status);
    } catch (e) {
      // ถ้ามีข้อผิดพลาดในการบันทึกข้อมูลให้ log ข้อผิดพลาด
      print("Error setting onboarding status: $e");
    }
  }
}
