


import 'package:clean_architecture_flutter/features/onboarding/data/datasources/onboarding_datasource.dart';
import 'package:clean_architecture_flutter/features/onboarding/data/datasources/onboarding_local_datasource.dart';
import 'package:clean_architecture_flutter/features/onboarding/data/repositories/onboarding_repository_impl.dart';
import 'package:clean_architecture_flutter/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:clean_architecture_flutter/shared/data/domain/provider/storage_service_provider.dart';
import 'package:clean_architecture_flutter/shared/data/local/storage_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final onboardingDataSourceProvider = Provider.family<OnboardingLocalDataSource, StorageService>(
  (ref, storageService) {
    return OnboardingLocalDataSource(storageService: storageService);
  },
);


final onboardingRepositoryProvider = Provider<OnboardingRepository>(
  (ref){
      final StorageService storageService = ref.watch(storageServiceProvider);
      final OnboardingDatasource dataSource =  ref.watch(onboardingDataSourceProvider(storageService));
      return OnboardingRepositoryImpl(onboardingDatasource: dataSource);
  }
);