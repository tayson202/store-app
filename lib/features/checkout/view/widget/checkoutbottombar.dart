import 'package:demo_app/widgets/textstyle.dart';
import 'package:flutter/material.dart';

class Checkoutbottombar extends StatelessWidget {
  final double totalamount;
  final VoidCallback onplaceorder;
  const Checkoutbottombar({
    super.key,
   required this.totalamount,
    required this.onplaceorder});

  @override
  Widget build(BuildContext context) {
    final isdark = Theme.of(context).brightness == Brightness.dark;
    return SafeArea (
      child: Container(
        padding: const EdgeInsets.all(24),
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
      child: ElevatedButton(onPressed: onplaceorder,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12)
        )
      ),
       child: Text(
        'place order(\$${totalamount.toStringAsFixed(2)})',
        style: AppTextStyles.withColor(
          AppTextStyles.buttonmid, Colors.white),
       ),
       ),
      ),
    );
  }
}
