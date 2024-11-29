import 'package:clean_architecture_flutter/shared/data/models/postsModel.dart';
import 'package:clean_architecture_flutter/shared/widget/custom_cart.dart';
import 'package:flutter/material.dart';

class PostItem extends StatelessWidget {
  final Posts post;
  const PostItem(this.post,{super.key});

  @override
  Widget build(BuildContext context) {
    return DisplayCard( // ใช้ CustomCard แทน ListTile
                title: post.title,
                subtitle: post.body,
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Tags: แสดง tags ที่มีในโพสต์
                    Text('Tags: ${post.tags.join(', ')}'),
                    SizedBox(height: 8),
                    // Reactions: แสดง reactions ในโพสต์
                    Text('Like: ${post.reactions.likes} Dislike: ${post.reactions.dislikes}'),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      // ใส่ฟังก์ชันที่ต้องการทำเมื่อกดปุ่มนี้
                      print("Action for post ${post.id}");
                    },
                    child: const Text("View Details"),
                  ),
                ],
              );
  }
}