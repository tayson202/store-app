import 'package:demo_app/controllers/navigation_controller.dart';
import 'package:demo_app/controllers/themecontroll.dart';
import 'package:demo_app/view/accountscreen.dart';
import 'package:demo_app/view/homescreen.dart';
import 'package:demo_app/view/shoppingscreen.dart';
import 'package:demo_app/view/wishlistscreen.dart';
import 'package:demo_app/widgets/CustomButtomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Mainscreen extends StatelessWidget {
  const Mainscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigationController navigationController =
        Get.find<NavigationController>();

    return GetBuilder<Themecontroll>(
      builder: (themeControll) => Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Obx(
          () => AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: IndexedStack(
              key: ValueKey(navigationController.currentIndex.value),
              index: navigationController.currentIndex.value,
              children: const [
                Homescreen(),
                Shoppingscreen(),
                Wishlistscreen(),
                Accountscreen(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: const Custombuttomnavbar(),
      ),
    );
  }
}
