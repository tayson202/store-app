import 'package:demo_app/widgets/customtextfield.dart';
import 'package:demo_app/widgets/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Forgetpassword extends StatelessWidget {
  Forgetpassword({super.key});
  final TextEditingController _emailcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isdark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Get.back(),
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: isdark ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "reset passsword ",
                style: AppTextStyles.withColor(
                  AppTextStyles.bodylarge,
                  isdark ? Colors.grey[400]! : Colors.grey[400]!,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "enter youremail to reset your password ",
                style: AppTextStyles.withColor(
                  AppTextStyles.bodylarge,
                  isdark ? Colors.grey[400]! : Colors.grey[400]!,
                ),
              ),
              const SizedBox(height: 40),
              Customtextfield(
                label: "email",
                prefixIcon: Icons.email_outlined,
                controller: _emailcontroller,
                ispassword: true,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "please enter a valid email";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    showSuccessDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'send reset link',
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
      ),
    );
  }

  void showSuccessDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        title: Text('check your email', style: AppTextStyles.h3),
        content: Text(
          'we have sent password recovery instruction to your email',
          style: AppTextStyles.bodymid,
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'ok',
              style: AppTextStyles.withColor(
                AppTextStyles.buttonmid,
                Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
