import 'package:demo_app/features/helpcenter/view/screens/widget/categorycard.dart';
import 'package:demo_app/widgets/textstyle.dart';
import 'package:flutter/material.dart';

class Helpcategoriessection extends StatelessWidget {
  const Helpcategoriessection({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {'item': Icons.shopping_bag_outlined, 'title': 'orders'},
      {'item': Icons.payment_outlined, 'title': 'payment'},
      {'item': Icons.local_shipping_outlined, 'title': 'shipping'},
      {'item': Icons.assignment_return_outlined, 'title': 'returns'},
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'help categories',
            style: AppTextStyles.withColor(
              AppTextStyles.h3,
              Theme.of(context).textTheme.bodyLarge!.color!,
            ),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.5,
            ),
            itemCount:categories.length ,
            itemBuilder: (context, index) {
              return Categorycard(
                title: categories[index]['title']as String,
                icon: categories[index]['icon']as IconData,
              );
            },
          ),
        ],
      ),
    );
  }
}
