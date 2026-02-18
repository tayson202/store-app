import 'package:demo_app/widgets/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

class Profileimage extends StatelessWidget {
  const Profileimage({super.key});

  @override
  Widget build(BuildContext context) {
    final isdark = Theme.of(context).brightness == Brightness.dark;
    return Center(
      child: Stack(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).primaryColor,
                width: 2,
              ),
              image: const DecorationImage(
                image: AssetImage(
                  'asset/307ce493-b254-4b2d-8ba4-d12c080d6651.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: () => showimagepickerbottomsheets(context, isdark),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: isdark
                          ? Colors.black.withOpacity(0.2)
                          : Colors.grey.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showimagepickerbottomsheets(BuildContext context, bool isdark) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: isdark ? Colors.grey[700]! : Colors.grey[300]!,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'change profile picture',
              style: AppTextStyles.withColor(
                AppTextStyles.h3,
                Theme.of(context).textTheme.bodyLarge!.color!,
              ),
            ),
            const SizedBox(height: 24),
            buildoptiontile(
              context,
              'take photo',
              Icons.camera_alt_outlined,
              () => Get.back(),
              isdark,
            ),
            const SizedBox(height: 24),
            buildoptiontile(
              context,
              'choose from gallery ',
              Icons.photo_library_outlined,
              () => Get.back(),
              isdark,
            ),
             const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget buildoptiontile(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback ontap,
    bool isdark,
  ) {
    return InkWell(
      onTap: ontap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: isdark?Colors.black.withOpacity(0.2):
              Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2)
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: Theme.of(context).primaryColor,
              size: 24,
            ),
            const SizedBox(width: 16,),
            Text(
              title,
              style: AppTextStyles.withColor(
                AppTextStyles.bodymid, 
                Theme.of(context).textTheme.bodyLarge!.color!),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: isdark?Colors.grey[400]:Colors.grey[600],
            )
          ],
        ),
      ),
    );
  }
}
