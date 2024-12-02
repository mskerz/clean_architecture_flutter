import 'package:clean_architecture_flutter/features/authentication/presentation/state/auth_state_notifier.dart';
import 'package:clean_architecture_flutter/features/posts/presentation/states/posts_state.dart';
import 'package:clean_architecture_flutter/features/posts/presentation/widgets/posts_list_item.dart';
import 'package:clean_architecture_flutter/shared/widget/app_errors.dart';
import 'package:clean_architecture_flutter/shared/widget/app_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostsScreen extends ConsumerWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ดึงสถานะของโพสต์
    final postsState = ref.watch(postsNotifierProvider);
    final authState = ref.watch(authStateNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
        automaticallyImplyLeading: false,
        
      ),
      body: postsState.when(
        data: (posts) {
          return ListView(
            children: posts.map((post) {
              return PostItem(post);
            }).toList(),
          );
        },
        loading: () => const AppLoading(),
        error: (error, stackTrace) => AppErrorsDisplay(error),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(postsNotifierProvider.notifier).fetchPosts();
          print("refresh posts");
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
