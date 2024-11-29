import 'package:clean_architecture_flutter/shared/data/models/postsModel.dart';

abstract class PostsDatasource {
  Future<List<Posts>> fetchPosts();
}
