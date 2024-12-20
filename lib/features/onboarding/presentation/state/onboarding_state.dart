

import 'package:clean_architecture_flutter/features/onboarding/domain/providers/onboarding_provider.dart';
import 'package:clean_architecture_flutter/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingState {
  final bool isOnboardingCompleted;

  OnboardingState({required this.isOnboardingCompleted});
}


class OnboardingNotifier extends StateNotifier<OnboardingState> {
  final OnboardingRepository onboardingRepository;

  OnboardingNotifier(this.onboardingRepository)
      : super(OnboardingState(isOnboardingCompleted: false));

  Future<void> getOnboardingStatus() async {
    try {
      final status = await onboardingRepository.getOnboardingStatus();
      state = OnboardingState(isOnboardingCompleted: status);
    } catch (e) {
      // Handle error (e.g. logging)
      print('Error getting onboarding status: $e');
    }
  }

  Future<void> setOnboardingStatus(bool status) async {
    try {
      await onboardingRepository.setOnboardingStatus(status);
      state = OnboardingState(isOnboardingCompleted: status);
    } catch (e) {
      // Handle error (e.g. logging)
      print('Error setting onboarding status: $e');
    }
  }
}



final onboardingNotifierProvider = StateNotifierProvider<OnboardingNotifier, OnboardingState>(
  (ref) {
    final onboardingRepository = ref.watch(onboardingRepositoryProvider);
    return OnboardingNotifier(onboardingRepository);
  },
);
