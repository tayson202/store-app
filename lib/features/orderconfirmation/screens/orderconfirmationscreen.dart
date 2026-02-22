import 'package:demo_app/features/notifications/models/myorders/model/view/screens/myorderscreen.dart';
import 'package:demo_app/view/mainscreen.dart';
import 'package:demo_app/widgets/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:lottie/lottie.dart';

class Orderconfirmationscreen extends StatelessWidget {
  final String ordernumber;
  final double totalamount;
  const Orderconfirmationscreen({
    super.key,
    required this.ordernumber,
    required this.totalamount,
  });

  @override
  Widget build(BuildContext context) {
    final isdark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'asset/Placed Order.mp4',
                width: 200,
                height: 200,
                repeat: false,
              ),
              const SizedBox(height: 32),
              Text(
                'order confirmed!',
                textAlign: TextAlign.center,
                style: AppTextStyles.withColor(
                  AppTextStyles.h2,
                  isdark ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'your order %$ordernumber has been successfully placed',
                textAlign: TextAlign.center,
                style: AppTextStyles.withColor(
                  AppTextStyles.bodylarge,
                  isdark ? Colors.grey[400]! : Colors.grey[600]!,
                ),
              ),
              const SizedBox(height: 48),
              ElevatedButton(
                onPressed: () {
                  Get.to(() => Myorderscreen());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 48,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'track order',
                  style: AppTextStyles.withColor(
                    AppTextStyles.bodymid,
                    Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Get.offAll(() => const Mainscreen());
                },
                child: Text(
                  'continue shopping',
                  style: AppTextStyles.withColor(
                    AppTextStyles.bodymid,
                    Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
