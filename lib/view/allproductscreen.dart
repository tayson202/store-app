import 'package:demo_app/widgets/ProductGrid.dart';
import 'package:demo_app/widgets/filterbottomsheet.dart';
import 'package:demo_app/widgets/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Allproductscreen extends StatelessWidget {
  const Allproductscreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final isdark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: isdark ? Colors.white : Colors.black,
          ),
        ),
        title: Text(
          'all products',
          style: AppTextStyles.withColor(
            AppTextStyles.h3,
            isdark ? Colors.white : Colors.black,
          ),
        ),
        actions: [
          //search icon
          IconButton(
            onPressed: () => Filterbottomsheet.show(context),
            icon: Icon(
              Icons.search,
              color: isdark ? Colors.white : Colors.black,
            ),
          ),
          //filter icon
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.filter_list,
              color: isdark ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
      body: const Productgrid(),
    );
  }
}
