import 'package:demo_app/controllers/themecontroll.dart';
import 'package:demo_app/features/privacypolicy/view/screens/privacypolicyscreen.dart';
import 'package:demo_app/features/terms%20of%20service/view/widget/screens/termsofservicescreen.dart';
import 'package:demo_app/widgets/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Settingscreen extends StatelessWidget {
  const Settingscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isdark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios),
          color: isdark ? Colors.white : Colors.black,
        ),
        title: Text(
          'settings',
          style: AppTextStyles.withColor(
            AppTextStyles.h3,
            isdark ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildsection(context, 'appearance', [buildthemetoggle(context)]),
            buildsection(context, 'notification', [
              buildswitchtile(
                context,
                'push notification',
                'receive push notification about orders and promotions',
                true,
              ),
              buildswitchtile(
                context,
                'email notification',
                'receive email update about your orders',
                false,
              ),
            ]),
            buildsection(context, 'privacy', [
              buildnavigationtile(
                context,
                'privacy policy',
                'view our privacy policy',
                Icons.privacy_tip_outlined,
                onTap: () => Get.to(()=>Privacypolicyscreen()),
              ),
              buildnavigationtile(
                context,
                'terms of service',
                'read our terms of services',
                Icons.description_outlined,
              ),
              buildnavigationtile(
                context,
                'terms of service',
                'read our terms of services',
                Icons.description_outlined,
                onTap: () => Get.to(()=>const Termsofservicescreen()),
              ),
            ]),
            buildsection(context,
             'about', [
              buildnavigationtile(
                context,
                'app version',
                '1.0.0',
                Icons.info_outline,
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Widget buildsection(
    BuildContext context,
    String title,
    List<Widget> children,
  ) {
    final isdark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
          child: Text(
            title,
            style: AppTextStyles.withColor(
              AppTextStyles.h3,
              isdark ? Colors.grey[400]! : Colors.grey[600]!,
            ),
          ),
        ),
        ...children,
      ],
    );
  }

  Widget buildthemetoggle(BuildContext context) {
    final isdark = Theme.of(context).brightness == Brightness.dark;
    return GetBuilder<Themecontroll>(
      builder: (controller) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: isdark
                  ? Colors.black.withOpacity(0.2)
                  : Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          leading: Icon(
            controller.isdarkmode ? Icons.dark_mode : Icons.light_mode,
            color: Theme.of(context).primaryColor,
          ),
          title: Text(
            'darkmode',
            style: AppTextStyles.withColor(
              AppTextStyles.bodymid,
              Theme.of(context).textTheme.bodyLarge!.color!,
            ),
          ),
          trailing: Switch.adaptive(
            value: controller.isdarkmode,
            onChanged: (Value) => controller.toggltheme(),
            activeColor: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }

  Widget buildswitchtile(
    BuildContext context,
    String title,
    String subtitle,
    bool initialvalue,
  ) {
    final isdark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: isdark
                ? Colors.black.withOpacity(0.2)
                : Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        title: Text(
          title,
          style: AppTextStyles.withColor(
            AppTextStyles.bodymid,
            Theme.of(context).textTheme.bodyLarge!.color!,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: AppTextStyles.withColor(
            AppTextStyles.bodysmall,
            isdark ? Colors.grey[400]! : Colors.grey[600]!,
          ),
        ),
        trailing: Switch.adaptive(
          value: initialvalue,
          onChanged: (Value) {},
          activeColor: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  Widget buildnavigationtile(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon, {
    VoidCallback? onTap,
  }) {
    final isdark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: isdark
                  ? Colors.black.withOpacity(0.2)
                  : Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          leading: Icon(icon, color: Theme.of(context).primaryColor),
          title: Text(
            title,
            style: AppTextStyles.withColor(
              AppTextStyles.bodymid,
              Theme.of(context).textTheme.bodyLarge!.color!,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: AppTextStyles.withColor(
              AppTextStyles.bodysmall,
              isdark ? Colors.grey[400]! : Colors.grey[600]!,
            ),
          ),
          trailing: Icon(
            Icons.chevron_right,
            color: isdark ? Colors.grey[400] : Colors.grey[600],
          ),
          //onTap: () {},
        ),
      ),
    );
  }
}
