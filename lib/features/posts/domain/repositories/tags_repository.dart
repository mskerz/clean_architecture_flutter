import 'package:clean_architecture_flutter/shared/data/models/tags.dart';

abstract class TagsRepository {
    Future<List<Tags>> getPostTags();

}