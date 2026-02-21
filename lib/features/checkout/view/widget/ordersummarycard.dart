import 'package:demo_app/widgets/textstyle.dart';
import 'package:flutter/material.dart';

class Ordersummarycard extends StatelessWidget {
  const Ordersummarycard({super.key});

  @override
  Widget build(BuildContext context) {
    final isdark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
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
      child: Column(
        children: [buildsummaryrow(context, 'subtotal', '\$599.9'),
        const SizedBox(height: 8,),
        buildsummaryrow(context, 'shipping', '\$10.00'),
        const SizedBox(height: 8,),
        buildsummaryrow(context, 'tax', '\$53.00'),
        const Padding(padding: EdgeInsets.symmetric(vertical: 12),
        child: Divider(),
        ),
         buildsummaryrow(context, 'total', '\$670.00',istotal: true),
        ],
      ),
    );
  }

  Widget buildsummaryrow(
    BuildContext context,
    String label,
    String value, {
    bool istotal = false,
  }) {
    final TextStyle = istotal ? AppTextStyles.h3 : AppTextStyles.bodylarge;
    final Color = istotal
        ? Theme.of(context).primaryColor
        : Theme.of(context).textTheme.bodyLarge!.color!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
      Text(
        label,
        style: AppTextStyles.withColor(TextStyle, Color),
      ),
      Text(
        value,
        style: AppTextStyles.withColor(TextStyle, Color),
      )

      ],
    );
  }
}
