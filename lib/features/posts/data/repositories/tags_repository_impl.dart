import 'package:clean_architecture_flutter/features/posts/data/datasources/tags/tags_data_source.dart';
import 'package:clean_architecture_flutter/features/posts/domain/repositories/tags_repository.dart';
import 'package:clean_architecture_flutter/shared/data/models/tags.dart';

class TagsRepositoryImpl implements TagsRepository{
  final TagsDataSource tagsDataSource;

  TagsRepositoryImpl(this.tagsDataSource);
  @override
  Future<List<Tags>> getPostTags() async {
    // TODO: implement getPostTags
    return await tagsDataSource.getPostTags();
  }

}