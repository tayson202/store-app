import 'package:demo_app/widgets/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class Questioncard extends StatelessWidget {
  final String title;
  final IconData icon;
  const Questioncard({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    final isdark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
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
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).primaryColor),
        title: Text(
          title,
          style: AppTextStyles.withColor(
            AppTextStyles.bodymid,
            Theme.of(context).textTheme.bodyLarge!.color!,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: isdark ? Colors.grey[400] : Colors.grey[600],
          size: 16,
        ),
        onTap: () => showanswerbottomsheet(context, title, isdark),
      ),
    );
  }

  void showanswerbottomsheet(
    BuildContext context,
    String question,
    bool isdark,
  ) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    question,
                    style: AppTextStyles.withColor(
                      AppTextStyles.h3,
                      Theme.of(context).textTheme.bodyLarge!.color!,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => Get.back(),
                  icon: Icon(
                    Icons.close,
                    color: isdark ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              getanswer(question),
              style: AppTextStyles.withColor(
                AppTextStyles.bodymid,
                isdark ? Colors.grey[400]! : Colors.grey[600]!,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: 
              ()=>Get.back(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)
                )
              ), child: Text(
                'got it',
                style: AppTextStyles.withColor(
                      AppTextStyles.buttonmid,
                      Colors.white,
                    ),
              ),
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  String getanswer(String question) {
    final answers = {
      'how to track your order?':'to track your order:\n\n'
      '1.go to "my orders"in your account\n'
      '2.select the order you want to track\n'
      '3.click on "track order"\n'
      '4.you will see real time updates about your package location\n\n'
      'you can also click on the tracking number in your order confirmation email to track your package directly\n\n'
      'how to return an item?''to return an item:\n\n'
      '1.go to "my orders"in your account\n'
      '2.select the order with the item you want to return\n'
      '3.click on "return item"\n'
      '4.select the reason for return\n'
      '5.print the return label\n'
      '6.pack the item securely"\n'
      '7.drop off the package at the nearest shipping location\n\n'
      'returns must be initiated within 30days of delivery .once we receive the item,your refund will be processed within 5-10days'
    };
    return answers[question]?? 'information not available.please contact support for assistance';
  }
}
