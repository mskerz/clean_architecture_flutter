import 'package:clean_architecture_flutter/features/onboarding/data/datasources/onboarding_datasource.dart';
import 'package:clean_architecture_flutter/features/onboarding/domain/repositories/onboarding_repository.dart';

class OnboardingRepositoryImpl extends OnboardingRepository {
  
  final OnboardingDatasource onboardingDatasource;

  OnboardingRepositoryImpl({required this.onboardingDatasource});

  @override
  Future<bool> getOnboardingStatus() async {
    try {
      // ดึงข้อมูลสถานะการ onboarding จาก datasource
      return await onboardingDatasource.getOnboardingStatus();
    } catch (e) {
      // หากเกิดข้อผิดพลาดให้ throw หรือ handle ตามที่ต้องการ
      throw Exception("Failed to get onboarding status: $e");
    }
  }

  @override
  Future<void> setOnboardingStatus(bool status) async {
    try {
      // ตั้งค่าสถานะการ onboarding ใน datasource
      await onboardingDatasource.setOnboardingStatus(status);
    } catch (e) {
      // หากเกิดข้อผิดพลาดให้ throw หรือ handle ตามที่ต้องการ
      throw Exception("Failed to set onboarding status: $e");
    }
  }
}
