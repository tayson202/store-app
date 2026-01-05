import 'package:demo_app/widgets/textstyle.dart';
import 'package:flutter/material.dart';

class Salebanner extends StatelessWidget {
  const Salebanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'get your',
                  style: AppTextStyles.withColor(
                    AppTextStyles.h3,
                    Colors.white,
                  ),
                ),
                Text(
                  'special sale',
                  style: AppTextStyles.withColor(
                    AppTextStyles.withweight(AppTextStyles.h2, FontWeight.bold),
                    Colors.white,
                  ),
                ),
                Text(
                  'up to 60%',
                  style: AppTextStyles.withColor(
                    AppTextStyles.h3,
                    Colors.white,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            child: Text('shop now', style: AppTextStyles.buttonmid),
          ),
        ],
      ),
    );
  }
}
