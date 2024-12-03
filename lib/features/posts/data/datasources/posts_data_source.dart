import 'package:clean_architecture_flutter/shared/data/models/posts.dart';

abstract class PostsDatasource {
  Future<List<Posts>> fetchPosts();

  //
  Future<List<Posts>> fetchPostsbyTag(String tag);
  Future<List<Posts>> searchPost(String keyword);
}
