import 'package:clean_architecture_flutter/features/posts/data/datasources/tags/tags_remote_data_source.dart';
import 'package:clean_architecture_flutter/features/posts/data/repositories/tags_repository_impl.dart';
import 'package:clean_architecture_flutter/features/posts/domain/repositories/tags_repository.dart';
import 'package:clean_architecture_flutter/shared/data/domain/provider/dio_network_service_provider.dart';
import 'package:clean_architecture_flutter/shared/data/remote/network_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tagsDataSourceProvider =
    Provider.family<TagsRemoteDataSource, NetworkService>(
  (_, networkService) => TagsRemoteDataSource(networkService: networkService ),
);
final tagsRepositoryProvider = Provider<TagsRepository>((ref) {
    final networkService = ref.watch(networkServiceProvider);
    final datasource = ref.watch(tagsDataSourceProvider(networkService));
    final repository = TagsRepositoryImpl(datasource);
    return repository;
});