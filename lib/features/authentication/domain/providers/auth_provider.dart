




import 'package:clean_architecture_flutter/features/authentication/data/datasources/auth_data_source.dart';
import 'package:clean_architecture_flutter/features/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:clean_architecture_flutter/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:clean_architecture_flutter/features/authentication/domain/repositories/auth_repository.dart';
import 'package:clean_architecture_flutter/shared/data/domain/provider/dio_network_service_provider.dart';
import 'package:clean_architecture_flutter/shared/data/domain/provider/storage_service_provider.dart';
import 'package:clean_architecture_flutter/shared/data/models/user.dart';
import 'package:clean_architecture_flutter/shared/data/remote/network_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authDataSourceProvider = 
      Provider.family<AuthRemoteDataSource,NetworkService>(
 (ref,networkService){
      final storageService = ref.watch(storageServiceProvider); // ดึง StorageService ผ่าน provider
          return AuthRemoteDataSource(networkService, storageService);

 }
);



final authRepositoryProvider =  Provider<AuthRepository>(
  (ref){
    final NetworkService networkService  = ref.watch(networkServiceProvider);
    final AuthDataSource dataSource = ref.watch(authDataSourceProvider(networkService));
    return AuthRepositoryImpl(dataSource);
  }
);

final userProvider = FutureProvider<User>((ref) async {
  final authRepository = ref.watch(authRepositoryProvider);
  return await authRepository.verify();  // ดึงข้อมูลผู้ใช้จาก API
});
