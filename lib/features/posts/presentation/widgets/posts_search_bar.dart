import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostsSearchBar extends ConsumerWidget {
  final TextEditingController textController;
  final Function(String) onSearchChanged;

  const PostsSearchBar({
    super.key, 
    required this.textController, 
    required this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    // กำหนดให้ textController เก็บ query ที่เก็บใน Riverpod

    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: TextField(
                controller: textController,
                autofocus: true,
                
                decoration: const InputDecoration(
                  hintText: 'Search...',
                
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  onSearchChanged(value);
                },
                
              ),
    );
  }
}

