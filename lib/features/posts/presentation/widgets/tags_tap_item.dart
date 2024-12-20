import 'package:clean_architecture_flutter/features/posts/presentation/states/posts_state.dart';
import 'package:clean_architecture_flutter/shared/data/models/tags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TagsTapItem extends ConsumerWidget {
  final Tags tag_item;
  const TagsTapItem({super.key, required this.tag_item});

  @override
  Widget build(BuildContext context, ref) {
    return GestureDetector(
      onTap: () {
        // การจัดการเมื่อเลือก tag
        ref.read(postsNotifierProvider.notifier).filterPostsByTags(tag_item.tag);
        print('Selected tag: ${tag_item.name}');
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
        margin: const EdgeInsets.only(right: 8.0),
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4.0,
              offset: Offset(2, 4),
            ),
          ],
        ),
        child: Text(
          tag_item.name,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'Prompt',
            fontSize: 16,
            fontWeight: FontWeight.normal,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }
}
