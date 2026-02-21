import 'package:demo_app/features/checkout/view/widget/addresscard.dart';
import 'package:demo_app/features/checkout/view/widget/checkoutbottombar.dart';
import 'package:demo_app/features/checkout/view/widget/ordersummarycard.dart';
import 'package:demo_app/features/checkout/view/widget/paymentmethodcard.dart';
import 'package:demo_app/features/orderconfirmation/screens/orderconfirmationscreen.dart';
import 'package:demo_app/widgets/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

class Checkoutscreen extends StatelessWidget {
  const Checkoutscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isdark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: isdark ? Colors.white : Colors.black,
          ),
        ),
        title: Text(
          'checkout',
          style: AppTextStyles.withColor(
            AppTextStyles.h3,
            isdark ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            builtsectiontitle(context, 'shipping address'),
            const SizedBox(height: 16),
            Addresscard(),
            const SizedBox(height: 24),
            builtsectiontitle(context, ' payment method'),
            const SizedBox(height: 16),
            Paymentmethodcard(),
            const SizedBox(height: 24),
            builtsectiontitle(context, ' order summary'),
            const SizedBox(height: 16),
            Ordersummarycard(),
          ],
        ),
      ),
      bottomNavigationBar: Checkoutbottombar(
        totalamount: 662.89,
        onplaceorder: () {
          //generate arandom order number feom backend
          final orderNumber =
              'ord${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';
          Get.to(() => Orderconfirmationscreen());
        },
      ),
    );
  }

  Widget builtsectiontitle(BuildContext context, String title) {
    return Text(
      title,
      style: AppTextStyles.withColor(
        AppTextStyles.h3,
        Theme.of(context).textTheme.bodyLarge!.color!,
      ),
    );
  }
}
