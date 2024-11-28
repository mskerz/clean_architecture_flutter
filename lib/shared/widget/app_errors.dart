import 'package:flutter/widgets.dart';

class AppErrorsDisplay extends StatelessWidget {
  final Object error;
  const AppErrorsDisplay(this.error,{super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Error: $error'));
  }
}