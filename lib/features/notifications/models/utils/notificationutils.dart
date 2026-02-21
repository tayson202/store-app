import 'package:demo_app/features/notifications/models/notificationtype.dart';
import 'package:flutter/material.dart';

class Notificationutils {
  static IconData getnotificationicon(Notificationtype type) {
    switch (type) {
      case Notificationtype.order:
        return Icons.shopping_bag_outlined;
      case Notificationtype.delivery:
        return Icons.local_shipping_outlined;
      case Notificationtype.promo:
        return Icons.local_offer_outlined;
      case Notificationtype.payment:
        return Icons.payment_rounded;
    }
  }

  static Color geticonbackgroundcolor(
    BuildContext context,
    Notificationtype type,
  ) {
    switch (type) {
      case Notificationtype.order:
        return Theme.of(context).primaryColor.withOpacity(0.1);
      case Notificationtype.delivery:
        return Colors.green[100]!;
      case Notificationtype.promo:
        return Colors.orange[100]!;
      case Notificationtype.payment:
        return Colors.red[100]!;
    }
  }

  static Color geticoncolor(BuildContext context, Notificationtype type) {
    switch (type) {
      case Notificationtype.order:
        return Theme.of(context).primaryColor;
      case Notificationtype.delivery:
        return Colors.green;
      case Notificationtype.promo:
        return Colors.orange;
      case Notificationtype.payment:
        return Colors.red;
    }
  }
}
