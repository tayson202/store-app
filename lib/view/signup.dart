import 'package:demo_app/view/mainscreen.dart';
import 'package:demo_app/view/signin.dart';
import 'package:demo_app/widgets/customtextfield.dart';
import 'package:demo_app/widgets/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Signup extends StatelessWidget {
  Signup({super.key});
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _emailcontroller = TextEditingController();
  // ignore: unused_field
  final TextEditingController _confirmpasswordcontroller =
      TextEditingController();

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
                "create account",
                style: AppTextStyles.withColor(
                  AppTextStyles.h1,
                  Theme.of(context).textTheme.bodyLarge!.color!,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "sign up to get started ",
                style: AppTextStyles.withColor(
                  AppTextStyles.bodylarge,
                  isdark ? Colors.grey[400]! : Colors.grey[400]!,
                ),
              ),
              const SizedBox(height: 40),
              Customtextfield(
                label: "fullname",
                prefixIcon: Icons.person_outlined,
                controller: _namecontroller,
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "please enter a your name";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Customtextfield(
                label: "email",
                prefixIcon: Icons.email_outlined,
                controller: _emailcontroller,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "please enter a your email";
                  }
                  if (!GetUtils.isEmail(value)) {
                    return 'please enter avalid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Customtextfield(
                label: "password",
                prefixIcon: Icons.lock_outlined,
                controller: _passwordcontroller,
                ispassword: true,
                keyboardType: TextInputType.visiblePassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "please enter a your password";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Customtextfield(
                label: "confirm password",
                prefixIcon: Icons.lock_outlined,
                controller: _passwordcontroller,
                ispassword: true,
                keyboardType: TextInputType.visiblePassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "please confirm your password";
                  }
                  if (value != _passwordcontroller.text) {
                    return "passwords dont match";
                  }
                  return null;
                },
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.off(() => const Mainscreen()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'sign up',
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
                    "alredy have an account?",
                    style: AppTextStyles.withColor(
                      AppTextStyles.bodymid,
                      isdark ? Colors.grey[400]! : Colors.grey[600]!,
                    ),
                  ),
                  TextButton(
                    onPressed: () => Get.to(() => Signin()),
                    child: Text(
                      'sign in',
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
}
