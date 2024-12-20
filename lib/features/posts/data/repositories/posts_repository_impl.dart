import 'package:clean_architecture_flutter/features/posts/data/datasources/posts/posts_data_source.dart';
import 'package:clean_architecture_flutter/features/posts/domain/repositories/posts_repository.dart';
import 'package:clean_architecture_flutter/shared/data/models/posts.dart';

class PostsRepositoryImpl implements PostsRepository {
  final PostsDatasource postsDatasource;

  PostsRepositoryImpl(this.postsDatasource);

  @override
  Future<List<Posts>> fetchPosts() async {
    return await postsDatasource.fetchPosts();
  }

  @override
  Future<List<Posts>> fetchPostsbyTag(String tag) async {
    return await postsDatasource.fetchPostsbyTag(tag);
  }
}
