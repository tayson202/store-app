import 'package:demo_app/features/notifications/models/myorders/model/view/screens/order.dart';

class Orderrepository {
  List<Order> getorders() {
    return [
      Order(
        ordernumber: '1111',
        itemcount: 2,
        totalamount: 2900.9,
        status: orderstatus.active,
        imageurl: 'asset/OIP (1).webp',
        orderdata: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      Order(
        ordernumber: '2222',
        itemcount: 3,
        totalamount: 3870.9,
        status: orderstatus.active,
        imageurl: 'asset/OIP (2).webp',
        orderdata: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      Order(
        ordernumber: '3333',
        itemcount: 1,
        totalamount: 1900.9,
        status: orderstatus.completed,
        imageurl: 'asset/OIP (3).webp',
        orderdata: DateTime.now().subtract(const Duration(hours: 8)),
      ),
      Order(
        ordernumber: '4444',
        itemcount: 2,
        totalamount: 2950.9,
        status: orderstatus.cancelied,
        imageurl: 'asset/OIP.webp',
        orderdata: DateTime.now().subtract(const Duration(hours: 7)),
      ),
    ];
  }

  List<Order> getorderbystatus(orderstatus status) {
    return getorders().where((order) => order.status == status).toList();
  }
}
