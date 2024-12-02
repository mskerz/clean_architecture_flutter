// lib/core/errors/error_screen.dart

import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final dynamic error;

  const ErrorScreen({Key? key,required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Error')),
      body: Center(
        child: Text(
          'An error occurred: $error',
          style: TextStyle(fontSize: 18,color: Color.fromARGB(2, 255, 66, 66)),
        ),
      ),
    );
  }
}
