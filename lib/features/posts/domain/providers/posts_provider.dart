
import 'package:clean_architecture_flutter/features/posts/data/datasources/posts_remote_data_source.dart';
import 'package:clean_architecture_flutter/features/posts/data/repositories/posts_repository_impl.dart';
import 'package:clean_architecture_flutter/features/posts/domain/repositories/posts_repository.dart';
import 'package:clean_architecture_flutter/shared/data/domain/provider/dio_network_service_provider.dart';
import 'package:clean_architecture_flutter/shared/data/remote/network_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postsDataSourceProvider =
    Provider.family<PostsDatasource, NetworkService>(
  (_, networkService) => PostsRemoteDataSource(networkService ),
);

final postsRepositoryProvider = Provider<PostsRepository>((ref) {
  final networkService = ref.watch(networkServiceProvider);
  final datasource = ref.watch(postsDataSourceProvider(networkService));
  final repository = PostsRepositoryImpl(datasource);

  return repository;
});