import 'package:clean_architecture_flutter/features/posts/presentation/states/posts_state.dart';
import 'package:clean_architecture_flutter/shared/widget/app_errors.dart';
import 'package:clean_architecture_flutter/shared/widget/app_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostsScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ดึงสถานะของโพสต์
    final postsState = ref.watch(postsNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: postsState.when(
        data: (posts) {
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              return ListTile(
                title: Text(post.title),
                subtitle: Text(post.body),
              );
            },
          );
        },
        loading: () => const AppLoading(),
        error: (error, stackTrace) => AppErrorsDisplay(error),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(postsNotifierProvider.notifier).fetchPosts(),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
