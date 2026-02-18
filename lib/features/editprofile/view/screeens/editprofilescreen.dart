import 'package:demo_app/features/editprofile/view/widget/profileform.dart';
import 'package:demo_app/features/editprofile/view/widget/profileimage.dart';
import 'package:demo_app/widgets/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class Editprofilescreen extends StatelessWidget {
  const Editprofilescreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isdark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold (
      appBar: AppBar(
        leading: IconButton(onPressed: ()=>Get.back(), icon: const Icon(
          Icons.arrow_back_ios
        )),
        title: Text(
          'edit profile',
          style: AppTextStyles.withColor(
            AppTextStyles.h3, 
            isdark?Colors.white:Colors.black),
        ),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 24,),
            Profileimage(),
            SizedBox(height: 32,),
            Profileform(),
          ],
        ),
      ),
    );
  }
}