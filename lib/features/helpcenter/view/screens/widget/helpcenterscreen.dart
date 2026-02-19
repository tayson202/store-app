import 'package:demo_app/features/helpcenter/view/screens/widget/contactsupportsection.dart';
import 'package:demo_app/features/helpcenter/view/screens/widget/helpcategoriessection.dart';
import 'package:demo_app/features/helpcenter/view/screens/widget/popularquestionsection.dart';
import 'package:demo_app/widgets/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class Helpcenterscreen extends StatelessWidget {
  const Helpcenterscreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          'help center',
          style: AppTextStyles.withColor(
            AppTextStyles.h3,
            isdark ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [buildsearchbar(context, isdark),
          const SizedBox(height: 24,),
          Popularquestionsection(),
          const SizedBox(height: 24,),
          const Helpcategoriessection(),
          const SizedBox(height: 24,),
          const Contactsupportsection(),
          ],
        ),
      ),
    );
  }

  Widget buildsearchbar(BuildContext context, bool isdark) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration:  BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: isdark?
            Colors.black.withOpacity(0.2):
            Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2)
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'search for help',
          hintStyle: AppTextStyles.withColor(
            AppTextStyles.buttonmid, 
            isdark?Colors.grey[400]!:Colors.grey[600]!),
            prefixIcon: Icon(
              Icons.search,
              color: isdark?Colors.grey[400]!:Colors.grey[600]!,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none
            ),
            filled: true,
            fillColor: Theme.of(context).cardColor,
        ),
      ),
    );
  }
}
