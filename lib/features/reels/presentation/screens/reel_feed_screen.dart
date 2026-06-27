import 'package:demo_app/features/reels/presentation/controllers/reel_feed_controller.dart';
import 'package:demo_app/features/reels/presentation/screens/reel_search_screen.dart';
import 'package:demo_app/features/reels/presentation/widgets/reel_category_chips.dart';
import 'package:demo_app/features/reels/presentation/widgets/reel_page_item.dart';
import 'package:demo_app/features/reels/presentation/widgets/reel_shimmer_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReelFeedScreen extends StatelessWidget {
  const ReelFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ReelFeedController>();

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 1. Vertical PageView
          Obx(() {
            if (controller.isLoading.value) {
              return const ReelShimmerLoader();
            }

            if (controller.reels.isEmpty) {
              return _buildEmptyState(context);
            }

            return PageView.builder(
              scrollDirection: Axis.vertical,
              controller: controller.pageController,
              itemCount: controller.reels.length,
              onPageChanged: controller.onPageChanged,
              itemBuilder: (context, index) {
                return ReelPageItem(
                  reel: controller.reels[index],
                  index: index,
                );
              },
            );
          }),

          // 2. Premium Translucent Top Bar (Category Chips + Search Button)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              bottom: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Showcase',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.5,
                            shadows: [
                              Shadow(color: Colors.black54, blurRadius: 8),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.search_rounded,
                            color: Colors.white,
                            size: 28,
                          ),
                          onPressed: () => Get.to(() => const ReelSearchScreen()),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  const ReelCategoryChips(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final controller = Get.find<ReelFeedController>();
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.video_library_outlined,
              size: 72,
              color: Colors.white30,
            ),
            const SizedBox(height: 16),
            const Text(
              'No product showcases found',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Try changing your category filter or check back later!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white54,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => controller.onCategoryChanged('All'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Reset Filter'),
            ),
          ],
        ),
      ),
    );
  }
}
