import 'package:clean_architecture_flutter/features/posts/domain/providers/posts_provider.dart';
import 'package:clean_architecture_flutter/features/posts/domain/repositories/posts_repository.dart';
import 'package:clean_architecture_flutter/shared/data/models/posts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostsNotifier extends StateNotifier<AsyncValue<List<Posts>>> {
  final PostsRepository postsRepository;

  PostsNotifier(this.postsRepository) : super(const AsyncValue.loading());

  Future<void> fetchPosts() async {
    try {
      final posts = await postsRepository.fetchPosts();
      state = AsyncValue.data(posts);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}

final postsNotifierProvider = StateNotifierProvider<PostsNotifier, AsyncValue<List<Posts>>>(
  (ref) {
    final postsRepository = ref.watch(postsRepositoryProvider);
    return PostsNotifier(postsRepository);
  },
);
