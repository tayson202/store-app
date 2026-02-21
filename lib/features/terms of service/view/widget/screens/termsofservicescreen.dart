import 'package:demo_app/features/privacypolicy/view/widget/infosection.dart';
import 'package:demo_app/widgets/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Termsofservicescreen extends StatelessWidget {
  const Termsofservicescreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isdark = Theme.of(context).brightness == Brightness.dark;
    final screensize = MediaQuery.of(context).size;
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
          'terms of service',
          style: AppTextStyles.withColor(
            AppTextStyles.h3,
            isdark ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(screensize.width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Infosection(
                title: 'welcome to GYM UNITY',
                content:
                    'by accessing and using this application,you accept and agree to be bound by the terms and provision of this agreement',
              ),
              Infosection(
                title: 'account registeration',
                content:
                    'by accessing and using this application,you accept and agree to be bound by the terms and provision of this agreement',
              ),
              Infosection(
                title: 'user responsibilities',
                content:
                    'by accessing and using this application,you accept and agree to be bound by the terms and provision of this agreement',
              ),
              Infosection(
                title: 'privacy policy',
                content:
                    'by accessing and using this application,you accept and agree to be bound by the terms and provision of this agreement',
              ),
              Infosection(
                title: 'intellectural property',
                content:
                    'by accessing and using this application,you accept and agree to be bound by the terms and provision of this agreement',
              ),
              Infosection(
                title: 'termination',
                content:
                    'by accessing and using this application,you accept and agree to be bound by the terms and provision of this agreement',
              ),
              const SizedBox(height: 24),
              Text(
                'last updated:march 2024',
                style: AppTextStyles.withColor(
                  AppTextStyles.bodysmall,
                  isdark ? Colors.grey[400]! : Colors.grey[600]!,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
