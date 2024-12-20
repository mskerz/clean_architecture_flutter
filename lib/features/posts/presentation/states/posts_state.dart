import 'package:clean_architecture_flutter/features/posts/domain/providers/posts_provider.dart';
import 'package:clean_architecture_flutter/features/posts/domain/repositories/posts_repository.dart';
import 'package:clean_architecture_flutter/shared/data/models/posts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostsNotifier extends StateNotifier<AsyncValue<List<Posts>>> {
  final PostsRepository postsRepository;
   List<Posts> _allPosts = []; // เก็บโพสต์ทั้งหมด

PostsNotifier(this.postsRepository) : super(const AsyncValue.loading()) {
    // โหลดโพสต์ทันทีเมื่อ notifier ถูกสร้าง
    fetchPosts();
  }


  Future<void> fetchPosts() async {
    try {
      final posts = await postsRepository.fetchPosts();            
      _allPosts = posts; // เก็บโพสต์ทั้งหมดไว้ใน _allPosts
      state = AsyncValue.data(posts);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
  
  
  Future <void> filterPostsByTags(String tag_name) async{
    try {
       final posts = await postsRepository.fetchPostsbyTag(tag_name);
       state = AsyncValue.data(posts);
    } catch (e) {
      throw Exception('Failed to Load Fetch Posts by Tag: $e ');
    }
  }

    // ฟังก์ชันในการกรองโพสต์ตามคำค้นหา
  void filterPosts(String query) {
    if (query.isEmpty) {
      state = AsyncValue.data(_allPosts); // หากคำค้นหาว่าง ให้แสดงโพสต์ทั้งหมด
    } else {
      final filteredPosts = _allPosts.where((post) {
        return post.title.toLowerCase().contains(query.toLowerCase()) || 
               post.body.toLowerCase().contains(query.toLowerCase());
      }).toList();
      state = AsyncValue.data(filteredPosts); // อัพเดต state ด้วยโพสต์ที่กรองแล้ว
    }
  }
}
 


final postsNotifierProvider = StateNotifierProvider<PostsNotifier, AsyncValue<List<Posts>>>(
  (ref) {
    final postsRepository = ref.watch(postsRepositoryProvider);
    return PostsNotifier(postsRepository);
  },
);
