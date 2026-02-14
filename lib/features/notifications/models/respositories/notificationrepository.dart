import 'package:demo_app/features/notifications/models/notificationtype.dart';

class Notificationrepository {
  List<Notificationitem> getnotifications() {
    return const [
      Notificationitem(
        title: 'order confirmed',
        message: 'your order #1111 has been confirmed and is being processed',
        time: '2 min ago',
        type: Notificationtype.order,
        isread: true,
      ),
      Notificationitem(
        title: 'special offer! ',
        message: 'get 20% off on all supplment this weekend',
        time: '1 hour ago',
        type: Notificationtype.promo,
        isread: true,
      ),
      Notificationitem(
        title: 'out for delivery',
        message: 'your order #1111 is out for delivery',
        time: '3 hour ago',
        type: Notificationtype.delivery,
        isread: true,
      ),
      Notificationitem(
        title: '',
        message: 'payment for #1111 was success',
        time: '2 min ago',
        type: Notificationtype.payment,
        isread: true,
      ),
    ];
  }
}
