import 'package:demo_app/controllers/authcontroller.dart';
import 'package:demo_app/features/seller/controllers/seller_controller.dart';
import 'package:demo_app/features/seller/screens/seller_profile_setup.dart';
import 'package:demo_app/view/mainscreen.dart';
import 'package:demo_app/view/signin.dart';
import 'package:demo_app/widgets/customtextfield.dart';
import 'package:demo_app/widgets/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _confirmpasswordcontroller =
      TextEditingController();

  String _selectedRole = 'buyer'; // 'buyer' or 'seller'

  @override
  Widget build(BuildContext context) {
    final isdark = Theme.of(context).brightness == Brightness.dark;
    final primary = Theme.of(context).primaryColor;

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
                "Create Account",
                style: AppTextStyles.withColor(
                  AppTextStyles.h1,
                  Theme.of(context).textTheme.bodyLarge!.color!,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Sign up to get started",
                style: AppTextStyles.withColor(
                  AppTextStyles.bodylarge,
                  isdark ? Colors.grey[400]! : Colors.grey[400]!,
                ),
              ),
              const SizedBox(height: 28),

              // ── Role Selector ──
              Text(
                "I am a...",
                style: AppTextStyles.withColor(
                  AppTextStyles.bodymid,
                  isdark ? Colors.white70 : Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _RoleCard(
                      label: 'Buyer',
                      icon: Icons.shopping_bag_outlined,
                      selected: _selectedRole == 'buyer',
                      primary: primary,
                      isDark: isdark,
                      onTap: () => setState(() => _selectedRole = 'buyer'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _RoleCard(
                      label: 'Seller',
                      icon: Icons.storefront_outlined,
                      selected: _selectedRole == 'seller',
                      primary: primary,
                      isDark: isdark,
                      onTap: () => setState(() => _selectedRole = 'seller'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // ── Form Fields ──
              Customtextfield(
                label: "Full Name",
                prefixIcon: Icons.person_outlined,
                controller: _namecontroller,
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your name";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Customtextfield(
                label: "Email",
                prefixIcon: Icons.email_outlined,
                controller: _emailcontroller,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your email";
                  }
                  if (!GetUtils.isEmail(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Customtextfield(
                label: "Password",
                prefixIcon: Icons.lock_outlined,
                controller: _passwordcontroller,
                ispassword: true,
                keyboardType: TextInputType.visiblePassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your password";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Customtextfield(
                label: "Confirm Password",
                prefixIcon: Icons.lock_outlined,
                controller: _confirmpasswordcontroller,
                ispassword: true,
                keyboardType: TextInputType.visiblePassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please confirm your password";
                  }
                  if (value != _passwordcontroller.text) {
                    return "Passwords don't match";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _handleSignup,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Sign Up',
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
                    "Already have an account?",
                    style: AppTextStyles.withColor(
                      AppTextStyles.bodymid,
                      isdark ? Colors.grey[400]! : Colors.grey[600]!,
                    ),
                  ),
                  TextButton(
                    onPressed: () => Get.to(() => Signin()),
                    child: Text(
                      'Sign In',
                      style: AppTextStyles.withColor(
                        AppTextStyles.buttonmid,
                        primary,
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

  void _handleSignup() {
    final auth = Get.find<Authcontroller>();
    auth.login(role: _selectedRole);

    if (_selectedRole == 'seller') {
      Get.find<SellerController>(); // ensure initialized
      Get.off(() => const SellerProfileSetup());
    } else {
      Get.off(() => const Mainscreen());
    }
  }
}

class _RoleCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final Color primary;
  final bool isDark;
  final VoidCallback onTap;

  const _RoleCard({
    required this.label,
    required this.icon,
    required this.selected,
    required this.primary,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
        decoration: BoxDecoration(
          color: selected
              ? primary.withValues(alpha: 0.12)
              : (isDark
                  ? Colors.white.withValues(alpha: 0.05)
                  : Colors.grey.withValues(alpha: 0.08)),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? primary : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 32,
              color: selected ? primary : Colors.grey,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontWeight:
                    selected ? FontWeight.bold : FontWeight.w400,
                color: selected
                    ? primary
                    : (isDark ? Colors.white70 : Colors.black54),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
