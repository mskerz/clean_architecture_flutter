// onboarding_datasource.dart
abstract class OnboardingDatasource {
  // Method สำหรับการดึงสถานะการแสดงผล Onboarding
  Future<bool> getOnboardingStatus();

  // Method สำหรับการตั้งค่าสถานะว่าเสร็จสิ้น Onboarding หรือไม่
  Future<void> setOnboardingStatus(bool status);
}
