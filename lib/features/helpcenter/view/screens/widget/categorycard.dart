import 'package:demo_app/widgets/textstyle.dart';
import 'package:flutter/material.dart';

class Categorycard extends StatelessWidget {
  final String title;
  final IconData icon;
  const Categorycard({super.key,
   required this.title,
    required this.icon}
    );

  @override
  Widget build(BuildContext context) {
    final isdark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: isdark?
            Colors.black.withOpacity(0.2):Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2)
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          
        },
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Theme.of(context).primaryColor,
              size: 32,
            ),
            const SizedBox(height: 8,),
            Text(
              title,
              style: AppTextStyles.withColor(
                AppTextStyles.bodymid, 
                Theme.of(context).textTheme.bodyLarge!.color!),
            ),
          ],
        ),
      ),
    );
  }
}
