import 'package:clean_architecture_flutter/shared/data/models/user.dart';
import 'package:flutter/material.dart';

class UserDrawer extends StatelessWidget {
  final User user;

  UserDrawer({required this.user});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // ข้อมูลผู้ใช้ที่แสดงบน Drawer
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(user.image),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${user.firstName}  ${user.lastName}',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Text(
                      user.email,
                      style: TextStyle(color: Colors.white70),
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
              // การออกจากระบบ
            },
          ),
        ],
      ),
    );
  }
}
