import 'package:clean_architecture_flutter/core/constant/onboarding_constant.dart';
import 'package:clean_architecture_flutter/features/onboarding/domain/providers/onboarding_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'; // Import smooth page indicator

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ใช้ PageController สำหรับการสไลด์หน้า
    final PageController pageController = PageController();

    // ตัวแปรที่จะเก็บสถานะการผ่าน Onboarding
    final onboardingStatus = ref.watch(onboardingRepositoryProvider);
    const imagePath = OnboardingConstants.onboarding_imagePath;

    return Scaffold(
      body: Column(
        children: [
          // PageView สำหรับสไลด์
          Expanded(
            child: PageView(
              controller: pageController,
              children: [
                // หน้าแรกของ Onboarding
                OnboardingPage(
                  imagePath: imagePath[0],
                  title: 'Welcome to our app!',
                  description: 'Here’s a quick intro to how to use it.',
                ),
                // หน้าที่สองของ Onboarding
                OnboardingPage(
                  imagePath: imagePath[1],
                  title: 'Explore the features',
                  description: 'Let’s dive into the app features.',
                ),
                // หน้าที่สามของ Onboarding
                OnboardingPage(
                  imagePath: imagePath[2],
                  title: 'Get started!',
                  description: 'Ready to get started with the app.',
                ),
              ],
              onPageChanged: (index) {
                if (index == 2) {
                  // เมื่อไปถึงหน้าสุดท้าย ให้ทำการบันทึกสถานะว่าได้ทำ Onboarding เสร็จแล้ว
                  onboardingStatus.setOnboardingStatus(true);
                }
              },
            ),
          ),
          // Dot Indicators (แสดงจุดตามจำนวนหน้าที่มี)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween, // จัดระยะห่างให้สมดุล
              children: [
                // Spacer ซ้ายเพื่อความสมดุล
                TextButton(
                  onPressed: () async {
                    context.goNamed('posts');
                    await onboardingStatus.setOnboardingStatus(true);
                  },
                  child: const Text(
                    'Skip',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                // SmoothPageIndicator อยู่ตรงกลาง
                SmoothPageIndicator(
                  controller:
                      pageController, // Controller สำหรับการควบคุมการเลื่อน
                  count: 3, // จำนวนหน้า (หรือจุด)
                  effect: WormEffect(
                    dotWidth: 10.0,
                    dotHeight: 10.0,
                    dotColor: Colors.grey, // สีของ dot
                    activeDotColor: Theme.of(context).primaryColor, // สี active
                  ),
                ),
                // Spacer ระหว่าง Indicator กับปุ่ม Skip
                ElevatedButton(
                  onPressed: (() {
                    if (pageController.page! < 2) {
                      pageController.nextPage(
                          duration: const Duration(milliseconds: 150),
                          curve: Curves.easeInOut);
                    } else {
                      // เมื่อไปถึงหน้าสุดท้าย ให้ทำการบันทึกสถานะว่าได้ทำ Onboarding เสร็จแล้ว
                      onboardingStatus.setOnboardingStatus(true);
                      context.goNamed('posts');
                    }
                  }),
                  child: Text("Next"),
                )
                // ปุ่ม Skip อยู่ด้านขวา
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  const OnboardingPage({
    required this.imagePath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.network(imagePath), // แก้ไขเป็น Image.network เพราะเป็น URL
        SizedBox(height: 20),
        Text(title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Text(description, textAlign: TextAlign.center),
      ],
    );
  }
}
