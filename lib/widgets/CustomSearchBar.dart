import 'package:demo_app/widgets/textstyle.dart';
import 'package:flutter/material.dart';

class Customsearchbar extends StatelessWidget {
  const Customsearchbar({super.key});

  @override
  Widget build(BuildContext context) {
    final isdark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.all(16),
      child: TextField(
        style: AppTextStyles.withColor(
          AppTextStyles.buttonmid,
          Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
        ),
        decoration: InputDecoration(
          hintText: 'search',
          hintStyle: AppTextStyles.withColor(
            AppTextStyles.buttonmid,
            isdark ? Colors.grey[400]! : Colors.grey[600]!,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: isdark ? Colors.grey[400]! : Colors.grey[600]!,
          ),
          suffixIcon: Icon(
            Icons.tune,
            color: isdark ? Colors.grey[400]! : Colors.grey[600]!,
          ),
          filled: true,
          fillColor: isdark ? Colors.grey[800] : Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: isdark ? Colors.grey[800]! : Colors.grey[100]!,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}
