import 'package:clean_architecture_flutter/routes/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Clean Architecture',
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
      theme: ThemeData(
        // กำหนดสีหลักเป็นม่วง
        primarySwatch:   Colors.blue, 
        // กำหนดสีพื้นหลังเป็นขาว
        scaffoldBackgroundColor: Colors.white, 
        // กำหนดสีตัวอักษรทั่วไป
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black),
          bodyMedium: TextStyle(color: Colors.black),
        ),
        // กำหนดสีปุ่ม
        buttonTheme: ButtonThemeData(
          textTheme: ButtonTextTheme.primary, // ปรับสีข้อความในปุ่ม
        ),
        // กำหนดสี AppBar
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(color: Colors.black),
        ),
        
      ),
    );
  }
}
