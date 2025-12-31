import 'package:demo_app/controllers/authcontroller.dart';
import 'package:demo_app/view/forgetpassword.dart';
import 'package:demo_app/view/mainscreen.dart';
import 'package:demo_app/view/signup.dart';
import 'package:demo_app/widgets/customtextfield.dart';
import 'package:demo_app/widgets/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Signin extends StatelessWidget {
  Signin({super.key});
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();

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
              const SizedBox(height: 40),
              Text(
                "Welcome back, rat",
                style: AppTextStyles.withColor(
                  AppTextStyles.h1,
                  Theme.of(context).textTheme.bodyLarge!.color!,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "sign in to continue",
                style: AppTextStyles.withColor(
                  AppTextStyles.bodylarge,
                  isdark ? Colors.grey[400]! : Colors.grey[600]!,
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
              const SizedBox(height: 16),
              Customtextfield(
                label: "password",
                prefixIcon: Icons.lock_outlined,
                controller: _passwordcontroller,
                keyboardType: TextInputType.visiblePassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "please enter a valid password";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),
              Align(
                alignment: AlignmentGeometry.centerRight,
                child: TextButton(
                  onPressed: () => Get.to(() => Forgetpassword()),
                  child: Text(
                    "forgot password?",
                    style: AppTextStyles.withColor(
                      AppTextStyles.buttonmid,
                      Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _handlesignin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'signin',
                    style: AppTextStyles.withColor(
                      AppTextStyles.buttonmid,
                      Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "dont have an account?",
                    style: AppTextStyles.withColor(
                      AppTextStyles.bodymid,
                      isdark ? Colors.grey[400]! : Colors.grey[600]!,
                    ),
                  ),
                  TextButton(
                    onPressed: () => Get.to(() => Signup()),
                    child: Text(
                      'sign up',
                      style: AppTextStyles.withColor(
                        AppTextStyles.buttonmid,
                        Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handlesignin() {
    final Authcontroller authcontroller = Get.find<Authcontroller>();
    authcontroller.login();
    Get.offAll(() => const Mainscreen());
  }
}
