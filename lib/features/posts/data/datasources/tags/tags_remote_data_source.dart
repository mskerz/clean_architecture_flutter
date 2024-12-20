import 'package:clean_architecture_flutter/features/posts/data/datasources/tags/tags_data_source.dart';
import 'package:clean_architecture_flutter/shared/data/models/tags.dart';
import 'package:clean_architecture_flutter/shared/data/remote/network_service.dart';

class TagsRemoteDataSource  extends TagsDataSource {
  final NetworkService networkService;

  TagsRemoteDataSource({required this.networkService});
  @override
  Future<List<Tags>> getPostTags() async {
    
    try{
      final response = await networkService.get('/posts/tags');
      if(response != null) {
        return( response as List ).map((tag)=>Tags.fromJson(tag)).toList();
      }else {
        throw Exception('Error fetching tags');
      }



    }catch (e) {
      throw Exception(e.toString());
    }
  }


}
