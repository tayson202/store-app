import 'package:flutter/material.dart';
import 'package:demo_app/controllers/themecontroll.dart';
import 'package:demo_app/widgets/CustomSearchBar.dart';
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
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage('assetName'),
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'hello tayson',
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      Text(
                        'good morning',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.notifications_outlined),
                  ),
                  //cart
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.shopping_bag_outlined),
                  ),
                  //theme
                  GetBuilder<Themecontroll>(
                    builder: (controller) => IconButton(
                      onPressed: (() => controller.toggltheme()),
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
            //search bar
            const Customsearchbar(),
          ],
        ),
      ),
    );
  }
}
