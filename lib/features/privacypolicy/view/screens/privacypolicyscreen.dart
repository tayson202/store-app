import 'package:demo_app/features/privacypolicy/view/widget/infosection.dart';
import 'package:demo_app/widgets/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class Privacypolicyscreen extends StatelessWidget {
  const Privacypolicyscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isdark = Theme.of(context).brightness == Brightness.dark;
    final screensize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(onPressed: ()=>Get.back(), icon: Icon(
          Icons.arrow_back_ios,
          color: isdark?Colors.white:Colors.black,
        ),
        ),
        title: Text(
          'privacy policy',
          style: AppTextStyles.withColor(
            AppTextStyles.h3, 
            isdark?Colors.white:Colors.black),
        ),
        
      ),body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(screensize.width*0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Infosection(
                title: 'information we collect',
                content: 'we collect information that u provide directly to us,including name,email address',

              ),
              Infosection(
                title: 'how we use your information',
                content: 'we use your information we collect to provide ,maintain,and improve our services,process your transections,and send you updates...',

              ),
              Infosection(
                title: 'information sharing',
                content: 'we collect information that u provide directly to us,including name,email address',

              ),
              Infosection(
                title: 'data security  ',
                content: 'we collect information that u provide directly to us,including name,email address',

              ),
              Infosection(
                title: 'your rights',
                content: 'we collect information that u provide directly to us,including name,email address',

              ),
              Infosection(
                title: 'cookie policy ',
                content: 'we collect information that u provide directly to us,including name,email address',

              ),
              const SizedBox(height: 24,),
              Text(
                'last updated:march 2024',
                style: AppTextStyles.withColor(
                  AppTextStyles.bodysmall, 
                  isdark?Colors.grey[400]!:Colors.grey[600]!),
              )
            ],
          ),
        ),
      ),
    );
  }
}
