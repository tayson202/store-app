import 'package:demo_app/controllers/authcontroller.dart';
import 'package:demo_app/features/seller/controllers/seller_controller.dart';
import 'package:demo_app/view/signin.dart';
import 'package:demo_app/widgets/textstyle.dart';
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

  @override
  Widget build(BuildContext context) {
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
            onPressed: () => Get.snackbar('Coming Soon',
                'Add product feature is coming soon!',
                snackPosition: SnackPosition.BOTTOM),
          ),
        ],
      ),
      body: Center(
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
      ),
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
