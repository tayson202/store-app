enum orderstatus { active, completed, cancelied }

class Order {
  final String ordernumber;
  final int itemcount;
  final double totalamount;
  final orderstatus status;
  final String imageurl;
  final DateTime orderdata;

  Order({
    required this.ordernumber,
    required this.itemcount,
    required this.totalamount,
    required this.status,
    required this.imageurl,
    required this.orderdata,
  });
  String get statusstring => status.name;
}
