import 'package:demo_app/features/notifications/models/myorders/model/repository/orderrepository.dart';
import 'package:demo_app/features/notifications/models/myorders/model/view/screens/order.dart';
import 'package:demo_app/features/notifications/models/myorders/model/view/widgets/ordercard.dart';
import 'package:demo_app/widgets/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class Myorderscreen extends StatelessWidget {
  final Orderrepository repository = Orderrepository();
  Myorderscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isdark = Theme.of(context).brightness == Brightness.dark;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back_ios,
              color: isdark ? Colors.white : Colors.black,
            ),
          ),
          title: Text(
            'my order',
            style: AppTextStyles.withColor(
              AppTextStyles.h3,
              isdark ? Colors.white : Colors.black,
            ),
          ),
          bottom: TabBar(
            labelColor: Theme.of(context).primaryColor,
            unselectedLabelColor: isdark ? Colors.grey[400] : Colors.grey[600],
            indicatorColor: Theme.of(context).primaryColor,
            tabs: [
              Tab(text: 'active'),
              Tab(text: 'completed'),
              Tab(text: 'cancelled'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            buildorderlist(context, orderstatus.active),
            buildorderlist(context, orderstatus.completed),
            buildorderlist(context, orderstatus.cancelied),
          ],
        ),
      ),
    );
  }

  Widget buildorderlist(BuildContext context, orderstatus status) {
    // ignore: unused_local_variable
    final isdark = Theme.of(context).brightness == Brightness.dark;
    final Order = repository.getorderbystatus(status);
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: Order.length,
      itemBuilder: (context, index) =>
          Ordercard(order: Order[index], onviewdetails: () {}),
    );
  }
}
