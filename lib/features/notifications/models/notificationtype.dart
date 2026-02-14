enum Notificationtype { order, delivery, promo, payment }

class Notificationitem {
  final String title;
  final String message;
  final String time;
  final Notificationtype type;
  final bool isread;

  const Notificationitem({
    required this.title,
    required this.message,
    required this.time,
    required this.type,
    this.isread = false,
  });
}
