import 'package:demo_app/features/notifications/models/notificationtype.dart';
import 'package:demo_app/features/notifications/models/respositories/notificationrepository.dart';
import 'package:demo_app/features/notifications/models/utils/notificationutils.dart';
import 'package:demo_app/widgets/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class Notificationscreen extends StatelessWidget {
  final Notificationrepository repository = Notificationrepository();
  Notificationscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isdark = Theme.of(context).brightness == Brightness.dark;
    final Notification = repository.getnotifications();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: isdark ? Colors.white : Colors.black,
          ),
        ),
        title: Text(
          'notifications',
          style: AppTextStyles.withColor(
            AppTextStyles.h3,
            isdark ? Colors.white : Colors.black,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'mark all as read',
              style: AppTextStyles.withColor(
                AppTextStyles.bodymid,
                Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: Notification.length,
        itemBuilder: (context, index) =>
            buildnotificationcard(context, Notification[index]),
      ),
    );
  }

  Widget buildnotificationcard(
    BuildContext context,
    Notificationitem notification,
  ) {
    final isdark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: notification.isread
            ? Theme.of(context).cardColor
            : Theme.of(context).primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isdark
                ? Colors.black.withOpacity(0.2)
                : Colors.grey.withOpacity(0.1),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Notificationutils.geticonbackgroundcolor(
              context,
              notification.type,
            ),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Notificationutils.getnotificationicon(notification.type),
            color: Notificationutils.geticoncolor(context, notification.type),
          ),
        ),
        title: Text(
          notification.title,
          style: AppTextStyles.withColor(
            AppTextStyles.bodylarge,
            Theme.of(context).textTheme.bodyLarge!.color!,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              notification.message,
              style: AppTextStyles.withColor(
                AppTextStyles.bodysmall,
                isdark ? Colors.grey[400]! : Colors.grey[600]!,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
