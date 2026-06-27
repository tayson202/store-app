import 'package:demo_app/features/seller/controllers/seller_controller.dart';
import 'package:demo_app/features/seller/models/seller_model.dart';
import 'package:demo_app/features/seller/screens/seller_dashboard.dart';
import 'package:demo_app/widgets/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SellerProfileSetup extends StatefulWidget {
  const SellerProfileSetup({super.key});

  @override
  State<SellerProfileSetup> createState() => _SellerProfileSetupState();
}

class _SellerProfileSetupState extends State<SellerProfileSetup> {
  final _formKey = GlobalKey<FormState>();
  final SellerController _sellerController = Get.find<SellerController>();

  final _nameController = TextEditingController();
  final _shopNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _descController = TextEditingController();

  int _step = 0;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = Theme.of(context).primaryColor;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(isDark, primary),
            _buildStepIndicator(primary),
            Expanded(
              child: Form(
                key: _formKey,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: _step == 0
                      ? _buildPersonalInfoStep(isDark, primary)
                      : _buildCategoryStep(isDark, primary),
                ),
              ),
            ),
            _buildBottomButton(primary),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(bool isDark, Color primary) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primary, primary.withValues(alpha: 0.6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.storefront_rounded, color: Colors.white, size: 30),
          ),
          const SizedBox(height: 16),
          Text(
            'Set Up Your Shop',
            style: AppTextStyles.withColor(
              AppTextStyles.h1,
              isDark ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            _step == 0
                ? 'Tell us about you and your business'
                : 'What will you be selling?',
            style: AppTextStyles.withColor(
              AppTextStyles.bodylarge,
              isDark ? Colors.grey[400]! : Colors.grey[600]!,
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildStepIndicator(Color primary) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: List.generate(2, (i) {
          final active = i == _step;
          final done = i < _step;
          return Expanded(
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              height: 4,
              decoration: BoxDecoration(
                color: (active || done) ? primary : Colors.grey.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildPersonalInfoStep(bool isDark, Color primary) {
    return SingleChildScrollView(
      key: const ValueKey('step0'),
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          _buildField(
            controller: _nameController,
            label: 'Full Name',
            icon: Icons.person_outline,
            hint: 'Your full name',
            validator: (v) => v!.isEmpty ? 'Required' : null,
          ),
          const SizedBox(height: 16),
          _buildField(
            controller: _shopNameController,
            label: 'Shop Name',
            icon: Icons.storefront_outlined,
            hint: 'Your store name',
            validator: (v) => v!.isEmpty ? 'Required' : null,
          ),
          const SizedBox(height: 16),
          _buildField(
            controller: _phoneController,
            label: 'Phone Number',
            icon: Icons.phone_outlined,
            hint: '+1 234 567 8900',
            keyboardType: TextInputType.phone,
            validator: (v) => v!.isEmpty ? 'Required' : null,
          ),
          const SizedBox(height: 16),
          _buildField(
            controller: _addressController,
            label: 'Business Address',
            icon: Icons.location_on_outlined,
            hint: 'City, Country',
            validator: (v) => v!.isEmpty ? 'Required' : null,
          ),
          const SizedBox(height: 16),
          _buildField(
            controller: _descController,
            label: 'Business Description',
            icon: Icons.description_outlined,
            hint: 'Tell customers about your shop...',
            maxLines: 3,
            validator: (v) => v!.isEmpty ? 'Required' : null,
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryStep(bool isDark, Color primary) {
    return SingleChildScrollView(
      key: const ValueKey('step1'),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select all that apply',
            style: AppTextStyles.withColor(
              AppTextStyles.bodymid,
              isDark ? Colors.grey[400]! : Colors.grey[600]!,
            ),
          ),
          const SizedBox(height: 16),
          Obx(() => Wrap(
                spacing: 10,
                runSpacing: 10,
                children: SellerController.availableCategories.map((cat) {
                  final selected = _sellerController.isCategorySelected(cat);
                  return GestureDetector(
                    onTap: () => _sellerController.toggleCategory(cat),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: selected
                            ? primary
                            : (isDark
                                ? Colors.white.withValues(alpha: 0.07)
                                : Colors.grey.withValues(alpha: 0.1)),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: selected ? primary : Colors.transparent,
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (selected) ...[
                            const Icon(Icons.check, color: Colors.white, size: 14),
                            const SizedBox(width: 6),
                          ],
                          Text(
                            cat,
                            style: AppTextStyles.withColor(
                              AppTextStyles.bodymid,
                              selected
                                  ? Colors.white
                                  : (isDark ? Colors.white70 : Colors.black87),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              )),
        ],
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String hint,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      maxLines: maxLines,
      style: TextStyle(color: isDark ? Colors.white : Colors.black),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, size: 20),
        filled: true,
        fillColor: isDark ? Colors.white.withValues(alpha: 0.06) : Colors.grey.withValues(alpha: 0.08),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
              color: Theme.of(context).primaryColor, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }

  Widget _buildBottomButton(Color primary) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _handleNext,
          style: ElevatedButton.styleFrom(
            backgroundColor: primary,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            elevation: 0,
          ),
          child: Text(
            _step == 0 ? 'Continue' : 'Launch My Shop 🚀',
            style: AppTextStyles.withColor(AppTextStyles.buttonmid, Colors.white),
          ),
        ),
      ),
    );
  }

  void _handleNext() {
    if (_step == 0) {
      if (_formKey.currentState!.validate()) {
        setState(() => _step = 1);
      }
    } else {
      if (_sellerController.selectedCategories.isEmpty) {
        Get.snackbar(
          'Select a Category',
          'Please choose at least one product category',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
          margin: const EdgeInsets.all(16),
        );
        return;
      }
      final model = SellerModel(
        name: _nameController.text.trim(),
        email: '',
        shopName: _shopNameController.text.trim(),
        phone: _phoneController.text.trim(),
        address: _addressController.text.trim(),
        description: _descController.text.trim(),
        categories: _sellerController.selectedCategories.toList(),
      );
      _sellerController.saveProfile(model);
      Get.offAll(() => const SellerDashboard());
    }
  }
}
