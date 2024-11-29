// features/posts/data/datasources/posts_remote_data_source.dart
import 'package:clean_architecture_flutter/features/posts/data/datasources/posts_data_source.dart';
import 'package:clean_architecture_flutter/shared/data/models/postsModel.dart';
import 'package:clean_architecture_flutter/shared/data/remote/network_service.dart';


class PostsRemoteDataSource  extends PostsDatasource {
  final NetworkService networkService;

  // Constructor with NetworkService injected
  PostsRemoteDataSource(this.networkService);

  // Fetch Posts from the remote API
  @override
  Future<List<Posts>> fetchPosts() async {
    try {
      // Make GET request to fetch posts data
      final response = await networkService.get('/posts');

      // Ensure that the response contains the 'posts' key and map it to a List of Posts
      if (response != null && response['posts'] != null) {
        return (response['posts'] as List).map((post) => Posts.fromJson(post)).toList();
      } else {
        throw Exception('No posts found in the response');
      }
    } catch (e) {
      throw Exception('Failed to fetch posts: $e');
    }
  }

  
}
