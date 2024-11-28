// domain/usecases/posts_fetch.dart


import 'package:clean_architecture_flutter/features/posts/domain/repositories/posts_repository.dart';
import 'package:clean_architecture_flutter/shared/data/models/posts.dart';

class PostsFetch {
  final PostsRepository repository;

  PostsFetch(this.repository);

  Future<List<Posts>> fetchPosts() async {
    return await repository.fetchPosts();
  }
}

