import 'package:clean_architecture_flutter/features/authentication/presentation/state/auth_state_notifier.dart';
import 'package:clean_architecture_flutter/shared/data/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class UserDrawer extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // รับค่าผู้ใช้จาก AuthStateNotifier
    // ดึงค่าผู้ใช้จาก AuthStateNotifier
    final authState = ref.watch(authStateNotifierProvider);
    final authNotifier = ref.read(authStateNotifierProvider.notifier);

    // ใช้ค่า user จาก authState หากผู้ใช้ล็อกอินแล้ว
    late final user = authState.user ??
        User(
          id: 1,
          firstName: "John",
          lastName: "Doe",
          age: 16,
          gender: "Male",
          email: "abc123@xyz.com",
          phone: "-",
          username: "fn",
          password: '12345',
          birthDate: '',
          image:
              'https://img.freepik.com/premium-vector/one-person-pictogram_764382-15536.jpg',
          bloodGroup: 'A',
          eyeColor: 'blue',
          ip: 'ip',
          address: Address(
              address: "address",
              city: "city",
              state: "state",
              stateCode: "stateCode",
              postalCode: "20000",
              country: "Thailand"),
          university: 'ABC university',
          role: "user",
        );

    return Drawer(
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        children: [
          // ข้อมูลผู้ใช้ที่แสดงบน Drawer
          DrawerHeader(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(user.image),
                    ),
                    Text(
                      '${user.firstName}  ${user.lastName}',
                      style: TextStyle(color: Colors.deepPurple, fontSize: 18),
                    ),
                    Text(
                      user.email,
                      style: TextStyle(color: Colors.deepPurple),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // เมนูต่างๆ ใน Drawer
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              // การนำทางไปหน้าหลัก
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              // การนำทางไปหน้าการตั้งค่า
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              try {
                 // ทำการ logout
                authNotifier.logout();

                // เมื่อ logout เสร็จสมบูรณ์แล้ว
                context.goNamed('login'); // นำทางไปหน้าล็อกอิน
              } catch (e) {
                // ถ้ามีข้อผิดพลาดในระหว่าง logout
                print("Logout failed: $e");
                // อาจจะแสดง snackbar หรือข้อความแสดงข้อผิดพลาด
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Logout failed: $e')),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
