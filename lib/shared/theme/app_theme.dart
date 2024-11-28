import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// สร้าง ThemeProvider ที่จะจัดการกับ ThemeData
class ThemeNotifier extends StateNotifier<ThemeData> {
  ThemeNotifier() : super(_lightTheme); // ค่าเริ่มต้นเป็น light theme

  static final ThemeData _lightTheme = ThemeData.light();
  static final ThemeData _darkTheme = ThemeData.dark();

  /// ฟังก์ชันสำหรับเปลี่ยนเป็น Light Theme
  void switchToLight() {
    state = _lightTheme;
  }

  /// ฟังก์ชันสำหรับเปลี่ยนเป็น Dark Theme
  void switchToDark() {
    state = _darkTheme;
  }

  /// ฟังก์ชันสำหรับ toggle ระหว่าง Light และ Dark Theme
  void toggleTheme() {
    state = state.brightness == Brightness.light ? _darkTheme : _lightTheme;
  }
}

/// สร้าง Provider สำหรับ ThemeNotifier
final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeData>((ref) {
  return ThemeNotifier();
});
