import 'package:demo_app/widgets/textstyle.dart';
import 'package:flutter/material.dart';

class Infosection extends StatelessWidget {
  final String title;
  final String content;
  const Infosection({super.key,
   required this.title,
    required this.content});

  @override
  Widget build(BuildContext context) {
    final isdark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isdark?Colors.black.withOpacity(0.2):Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2)
          ),
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.withColor(
              AppTextStyles.h3, 
              Theme.of(context).textTheme.bodyLarge!.color!),
          ),
          const SizedBox(height: 12,),
          Text(
            content,
            style: AppTextStyles.withColor(
              AppTextStyles.bodymid, 
              isdark?Colors.grey[300]!:Colors.grey[700]!),
          )
        ],
      ),
    );
  }
}
