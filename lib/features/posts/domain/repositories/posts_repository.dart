// features/posts/domain/repositories/posts_repository.dart
import 'package:clean_architecture_flutter/shared/data/models/postsModel.dart';

abstract class PostsRepository {
  Future<List<Posts>> fetchPosts();
}
