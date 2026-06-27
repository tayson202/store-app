import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:demo_app/features/reels/presentation/controllers/reel_feed_controller.dart';

class ReelCategoryChips extends StatelessWidget {
  const ReelCategoryChips({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ReelFeedController>();
    return Obx(() => SizedBox(
          height: 40,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: controller.categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final cat = controller.categories[index];
              final isSelected = controller.selectedCategory.value == cat;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                child: GestureDetector(
                  onTap: () => controller.onCategoryChanged(cat),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.white
                          : Colors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected
                            ? Colors.white
                            : Colors.white.withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      cat,
                      style: TextStyle(
                        color: isSelected ? Colors.black : Colors.white,
                        fontSize: 13,
                        fontWeight:
                            isSelected ? FontWeight.w700 : FontWeight.w500,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ));
  }
}
