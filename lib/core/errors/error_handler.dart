// lib/core/errors/error_handler.dart

import 'package:clean_architecture_flutter/core/errors/error_screen.dart';
import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

class ErrorHandler {
  static Widget handleError(dynamic error) {
    // ตัวอย่างการจัดการข้อผิดพลาดทั่วไป
    return ErrorScreen(error:error);  // ส่ง error ไปที่ ErrorScreen
  }
}
