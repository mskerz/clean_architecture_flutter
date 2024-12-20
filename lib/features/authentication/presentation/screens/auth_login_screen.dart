// login_screen.dart
import 'package:clean_architecture_flutter/features/authentication/presentation/state/auth_state.dart';
import 'package:clean_architecture_flutter/features/authentication/presentation/state/auth_state_notifier.dart';
import 'package:clean_architecture_flutter/shared/widget/app_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateNotifierProvider);
    ref.listen<AuthState>(authStateNotifierProvider, (previous, next) {
      if (next.isLoggedIn) {
        // เมื่อ isLoggedIn = true ให้ไปหน้า PostScreen
        context.goNamed('posts');
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (_) => PostsScreen()),
        // );
      } else if (next.errorMessage.isNotEmpty) {
        // แสดงข้อความแจ้งเตือนหากเกิดข้อผิดพลาด
        ScaffoldMessenger.of(context).showSnackBar( 
          const SnackBar(backgroundColor: Colors.white,
              content: Text(
            "ชื่อผู้ใช้ หรือ รหัสผ่าน ไม่ถูกต้อง! กรุณาลองอีกครั้ง",
            style: TextStyle(color: Colors.redAccent),
          )),
        );
      }
    });
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: "Username"),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password"),
            ),
            SizedBox(height: 20),
            // Text(
            //     'Is Logged In: ${authState.isLoggedIn}'), // แสดงสถานะ isLoggedIn

            if (authState.isLoading)
              const AppLoading() // Show loading indicator
            else
              ElevatedButton(
                onPressed: () {
                  final username = usernameController.text;
                  final password = passwordController.text;

                  if (username.isEmpty || password.isEmpty) {
                    // แสดงข้อความแจ้งเตือนหากเกิดข้อผิดพลาด
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        
                        backgroundColor: Colors.white70,
                          content: Text(
                        "คุณยังไม่ได้ใส่ ชื่อผู้ใช้ หรือ รหัสผ่าน !",
                        style: TextStyle(color: Colors.redAccent),
                      )),
                    );
                  }else{
                      ref.read(authStateNotifierProvider.notifier).login(username, password);
                  }
                  
                },
                child: Text("Login"),
              ),
          ],
        ),
      ),
    );
  }
}
