import 'package:demo_app/controllers/themecontroll.dart';
import 'package:demo_app/widgets/CategoryChips.dart';
import 'package:demo_app/widgets/CustomSearchBar.dart';
import 'package:demo_app/widgets/ProductGrid.dart';
import 'package:demo_app/widgets/salebanner.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage('asset/OIP (1).webp'),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Hello Tayson',
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      Text(
                        'Good Morning',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.notifications_outlined),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.shopping_bag_outlined),
                  ),
                  GetBuilder<Themecontroll>(
                    builder: (controller) => IconButton(
                      onPressed: controller.toggltheme,
                      icon: Icon(
                        controller.isdarkmode
                            ? Icons.light_mode
                            : Icons.dark_mode,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// Search bar
            const Customsearchbar(),

            /// Categories
            const Categorychips(),

            /// Sale banner
            const Salebanner(),

            /// Popular products header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Popular Products',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      'See all',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ),
                ],
              ),
            ),
            //product grid
            const Expanded(child: Productgrid()),
          ],
        ),
      ),
    );
  }
}
