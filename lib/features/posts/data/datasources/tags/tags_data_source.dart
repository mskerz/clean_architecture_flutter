import 'package:clean_architecture_flutter/shared/data/models/tags.dart';

abstract class TagsDataSource {
  Future<List<Tags>> getPostTags();
}