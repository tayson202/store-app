import 'package:demo_app/controllers/authcontroller.dart';
import 'package:demo_app/features/seller/controllers/seller_controller.dart';
import 'package:demo_app/view/signin.dart';
import 'package:demo_app/widgets/textstyle.dart';
import 'package:demo_app/controllers/product.dart';
import 'package:demo_app/view/settingscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SellerDashboard extends StatelessWidget {
  const SellerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = Theme.of(context).primaryColor;
    final SellerController sc = Get.find<SellerController>();

    return Obx(() {
      final tabs = [
        _HomeTab(isDark: isDark, primary: primary, sc: sc),
        _ProductsTab(isDark: isDark, primary: primary),
        _OrdersTab(isDark: isDark, primary: primary),
        _ProfileTab(isDark: isDark, primary: primary, sc: sc),
      ];

      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: tabs[sc.currentTabIndex.value],
        ),
        bottomNavigationBar: _buildBottomNav(context, sc, isDark, primary),
      );
    });
  }

  Widget _buildBottomNav(BuildContext context, SellerController sc,
      bool isDark, Color primary) {
    final items = [
      {'icon': Icons.dashboard_rounded, 'label': 'Dashboard'},
      {'icon': Icons.inventory_2_rounded, 'label': 'Products'},
      {'icon': Icons.receipt_long_rounded, 'label': 'Orders'},
      {'icon': Icons.person_rounded, 'label': 'Profile'},
    ];

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E2C) : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(items.length, (i) {
                  final selected = sc.currentTabIndex.value == i;
                  return GestureDetector(
                    onTap: () => sc.changeTab(i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: selected
                            ? primary.withValues(alpha: 0.15)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            items[i]['icon'] as IconData,
                            color: selected ? primary : Colors.grey,
                            size: 22,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            items[i]['label'] as String,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: selected
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                              color: selected ? primary : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              )),
        ),
      ),
    );
  }
}

// ─────────────────── HOME TAB ───────────────────
class _HomeTab extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final SellerController sc;
  const _HomeTab(
      {required this.isDark, required this.primary, required this.sc});

  @override
  Widget build(BuildContext context) {
    final shopName =
        sc.sellerProfile.value?.shopName ?? 'Your Shop';

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 160,
          floating: false,
          pinned: true,
          backgroundColor: primary,
          automaticallyImplyLeading: false,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primary, primary.withValues(alpha: 0.7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.fromLTRB(24, 60, 24, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '👋 Welcome back,',
                      style: AppTextStyles.withColor(
                          AppTextStyles.bodymid, Colors.white70),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      shopName,
                      style: AppTextStyles.withColor(
                          AppTextStyles.h1, Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(20),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              Text(
                'Overview',
                style: AppTextStyles.withColor(
                  AppTextStyles.h2,
                  isDark ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                      child: _StatCard(
                    label: 'Products',
                    value: '0',
                    icon: Icons.inventory_2_rounded,
                    color: Colors.blue,
                    isDark: isDark,
                  )),
                  const SizedBox(width: 12),
                  Expanded(
                      child: _StatCard(
                    label: 'Orders',
                    value: '0',
                    icon: Icons.receipt_long_rounded,
                    color: Colors.orange,
                    isDark: isDark,
                  )),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                      child: _StatCard(
                    label: 'Revenue',
                    value: '\$0',
                    icon: Icons.attach_money_rounded,
                    color: Colors.green,
                    isDark: isDark,
                  )),
                  const SizedBox(width: 12),
                  Expanded(
                      child: _StatCard(
                    label: 'Reviews',
                    value: '0',
                    icon: Icons.star_rounded,
                    color: Colors.purple,
                    isDark: isDark,
                  )),
                ],
              ),
              const SizedBox(height: 24),
              _QuickActionCard(
                isDark: isDark,
                primary: primary,
                label: 'Add Your First Product',
                subtitle: 'Start selling by listing a product',
                icon: Icons.add_box_rounded,
                onTap: () => Get.find<SellerController>().changeTab(1),
              ),
            ]),
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label, value;
  final IconData icon;
  final Color color;
  final bool isDark;
  const _StatCard(
      {required this.label,
      required this.value,
      required this.icon,
      required this.color,
      required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E2C) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 2),
          Text(label,
              style: TextStyle(
                  fontSize: 12, color: Colors.grey[500])),
        ],
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final String label, subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const _QuickActionCard(
      {required this.isDark,
      required this.primary,
      required this.label,
      required this.subtitle,
      required this.icon,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [primary, primary.withValues(alpha: 0.7)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 32),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15)),
                  const SizedBox(height: 4),
                  Text(subtitle,
                      style: const TextStyle(
                          color: Colors.white70, fontSize: 12)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded,
                color: Colors.white70, size: 16),
          ],
        ),
      ),
    );
  }
}

// ─────────────────── PRODUCTS TAB ───────────────────
class _ProductsTab extends StatelessWidget {
  final bool isDark;
  final Color primary;
  const _ProductsTab({required this.isDark, required this.primary});

  void _showProductForm(BuildContext context, SellerController sc, {Product? productToEdit, int? indexToEdit}) {
    final titleCtrl = TextEditingController(text: productToEdit?.name ?? '');
    final descCtrl = TextEditingController(text: productToEdit?.description ?? '');
    final priceCtrl = TextEditingController(text: productToEdit?.price.toString() ?? '');
    final oldPriceCtrl = TextEditingController(text: productToEdit?.oldprice?.toString() ?? '');
    String selectedCat = productToEdit?.category ?? 'creatine';

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E2C) : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                productToEdit == null ? 'Add Product' : 'Edit Product',
                style: AppTextStyles.withColor(AppTextStyles.h2, isDark ? Colors.white : Colors.black),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: titleCtrl,
                style: TextStyle(color: isDark ? Colors.white : Colors.black),
                decoration: InputDecoration(
                  labelText: 'Product Name',
                  labelStyle: const TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: isDark ? Colors.white24 : Colors.black12)),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: primary)),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: descCtrl,
                maxLines: 2,
                style: TextStyle(color: isDark ? Colors.white : Colors.black),
                decoration: InputDecoration(
                  labelText: 'Description',
                  labelStyle: const TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: isDark ? Colors.white24 : Colors.black12)),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: primary)),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: priceCtrl,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      style: TextStyle(color: isDark ? Colors.white : Colors.black),
                      decoration: InputDecoration(
                        labelText: 'Price',
                        labelStyle: const TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: isDark ? Colors.white24 : Colors.black12)),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: primary)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: oldPriceCtrl,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      style: TextStyle(color: isDark ? Colors.white : Colors.black),
                      decoration: InputDecoration(
                        labelText: 'Old Price (Optional)',
                        labelStyle: const TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: isDark ? Colors.white24 : Colors.black12)),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: primary)),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: selectedCat,
                dropdownColor: isDark ? const Color(0xFF1E1E2C) : Colors.white,
                style: TextStyle(color: isDark ? Colors.white : Colors.black),
                decoration: InputDecoration(
                  labelText: 'Category',
                  labelStyle: const TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: isDark ? Colors.white24 : Colors.black12)),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: primary)),
                ),
                items: ['creatine', 'protine', 'pants', 'accessories', 'vitamins']
                    .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                    .toList(),
                onChanged: (val) {
                  if (val != null) selectedCat = val;
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final name = titleCtrl.text.trim();
                    final desc = descCtrl.text.trim();
                    final price = double.tryParse(priceCtrl.text) ?? 0.0;
                    final oldPrice = double.tryParse(oldPriceCtrl.text);

                    if (name.isEmpty || desc.isEmpty || price <= 0) {
                      Get.snackbar('Required Fields', 'Please fill in all mandatory fields.');
                      return;
                    }

                    final newProduct = Product(
                      name: name,
                      category: selectedCat,
                      price: price,
                      oldprice: oldPrice,
                      imageurl: productToEdit?.imageurl ?? 'asset/image/OIP.webp',
                      description: desc,
                      isfavorite: productToEdit?.isfavorite ?? false,
                    );

                    if (productToEdit == null) {
                      sc.addProduct(newProduct);
                      Get.snackbar('Success', 'Product added successfully.');
                    } else {
                      sc.updateProduct(indexToEdit!, newProduct);
                      Get.snackbar('Success', 'Product updated successfully.');
                    }
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text(productToEdit == null ? 'Add Product' : 'Save Changes'),
                ),
              ),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final SellerController sc = Get.find<SellerController>();

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: isDark ? const Color(0xFF1E1E2C) : Colors.white,
        elevation: 0,
        title: Text('My Products',
            style: AppTextStyles.withColor(
                AppTextStyles.h2,
                isDark ? Colors.white : Colors.black)),
        actions: [
          IconButton(
            icon: Icon(Icons.add_rounded, color: primary),
            onPressed: () => _showProductForm(context, sc),
          ),
        ],
      ),
      body: Obx(() {
        if (sc.myProducts.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.inventory_2_outlined,
                    size: 80, color: Colors.grey[300]),
                const SizedBox(height: 16),
                Text('No products yet',
                    style: AppTextStyles.withColor(
                        AppTextStyles.h1,
                        isDark ? Colors.white54 : Colors.black38)),
                const SizedBox(height: 8),
                Text('Tap + to add your first product',
                    style: TextStyle(color: Colors.grey[500])),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: sc.myProducts.length,
          itemBuilder: (context, index) {
            final p = sc.myProducts[index];
            return Card(
              color: isDark ? const Color(0xFF252538) : Colors.white,
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: ListTile(
                contentPadding: const EdgeInsets.all(12),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(p.imageurl, width: 50, height: 50, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Container(color: Colors.grey[800], child: const Icon(Icons.shopping_bag))),
                ),
                title: Text(p.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(p.category, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                    const SizedBox(height: 4),
                    Text('\$${p.price.toStringAsFixed(2)}', style: TextStyle(color: primary, fontWeight: FontWeight.bold)),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit_outlined, color: Colors.blue),
                      onPressed: () => _showProductForm(context, sc, productToEdit: p, indexToEdit: index),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline_rounded, color: Colors.redAccent),
                      onPressed: () {
                        Get.dialog(
                          AlertDialog(
                            title: const Text('Delete Product?'),
                            content: Text('Are you sure you want to delete ${p.name}?'),
                            actions: [
                              TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
                              ElevatedButton(
                                onPressed: () {
                                  sc.deleteProduct(p);
                                  Get.back();
                                },
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                child: const Text('Delete'),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

// ─────────────────── ORDERS TAB ───────────────────
class _OrdersTab extends StatelessWidget {
  final bool isDark;
  final Color primary;
  const _OrdersTab({required this.isDark, required this.primary});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: isDark ? const Color(0xFF1E1E2C) : Colors.white,
        elevation: 0,
        title: Text('Orders',
            style: AppTextStyles.withColor(
                AppTextStyles.h2,
                isDark ? Colors.white : Colors.black)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.receipt_long_outlined,
                size: 80, color: Colors.grey[300]),
            const SizedBox(height: 16),
            Text('No orders yet',
                style: AppTextStyles.withColor(
                    AppTextStyles.h1,
                    isDark ? Colors.white54 : Colors.black38)),
            const SizedBox(height: 8),
            Text('Your incoming orders will appear here',
                style: TextStyle(color: Colors.grey[500])),
          ],
        ),
      ),
    );
  }
}

// ─────────────────── PROFILE TAB ───────────────────
class _ProfileTab extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final SellerController sc;
  const _ProfileTab(
      {required this.isDark, required this.primary, required this.sc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: isDark ? const Color(0xFF1E1E2C) : Colors.white,
        elevation: 0,
        title: Text('My Profile',
            style: AppTextStyles.withColor(
                AppTextStyles.h2,
                isDark ? Colors.white : Colors.black)),
      ),
      body: Obx(() {
        final profile = sc.sellerProfile.value;
        if (profile == null) {
          return const Center(child: Text('No profile found'));
        }
        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Avatar
              CircleAvatar(
                radius: 44,
                backgroundColor: primary.withValues(alpha: 0.15),
                child: Icon(Icons.storefront_rounded,
                    size: 44, color: primary),
              ),
              const SizedBox(height: 12),
              Text(profile.shopName,
                  style: AppTextStyles.withColor(
                      AppTextStyles.h1,
                      isDark ? Colors.white : Colors.black)),
              const SizedBox(height: 4),
              Text(profile.address,
                  style: TextStyle(color: Colors.grey[500])),
              const SizedBox(height: 20),
              // Categories
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: profile.categories
                    .map((c) => Chip(
                          label: Text(c,
                              style: TextStyle(
                                  fontSize: 12, color: primary)),
                          backgroundColor: primary.withValues(alpha: 0.1),
                          side: BorderSide.none,
                          padding:
                              const EdgeInsets.symmetric(horizontal: 4),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 24),
              _InfoRow(icon: Icons.person_outline, label: 'Name', value: profile.name, isDark: isDark),
              _InfoRow(icon: Icons.phone_outlined, label: 'Phone', value: profile.phone, isDark: isDark),
              _InfoRow(icon: Icons.description_outlined, label: 'About', value: profile.description, isDark: isDark),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => Get.to(() => const Settingscreen()),
                  icon: const Icon(Icons.settings_outlined, color: Colors.white),
                  label: const Text('Settings',
                      style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    final auth = Get.find<Authcontroller>();
                    auth.logout();
                    Get.offAll(() => Signin());
                  },
                  icon: const Icon(Icons.logout_rounded, color: Colors.red),
                  label: const Text('Logout',
                      style: TextStyle(color: Colors.red)),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.red),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label, value;
  final bool isDark;
  const _InfoRow(
      {required this.icon,
      required this.label,
      required this.value,
      required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isDark
              ? Colors.white.withValues(alpha: 0.06)
              : Colors.grey.withValues(alpha: 0.07),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Icon(icon, size: 18, color: Colors.grey),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(
                        fontSize: 11, color: Colors.grey)),
                const SizedBox(height: 2),
                Text(value,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: isDark ? Colors.white : Colors.black)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
