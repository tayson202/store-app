import 'package:demo_app/features/helpcenter/view/screens/widget/questioncard.dart';
import 'package:demo_app/widgets/textstyle.dart';
import 'package:flutter/material.dart';

class Popularquestionsection extends StatelessWidget {
  const Popularquestionsection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding (
      padding:const EdgeInsets.symmetric(horizontal: 16) ,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'popular questions',
            style: AppTextStyles.withColor(
              AppTextStyles.h3, 
              Theme.of(context).textTheme.bodyLarge!.color!
              ),
          ),
          const SizedBox(height: 16,),
          Questioncard(
            title: 'how to track my order',
            icon: Icons.local_shipping_outlined,
          ),
          const SizedBox(height: 12,),
          const Questioncard(title: 
          'how to return an item', icon: 
          Icons.local_shipping_outlined
          ),
        ],
      ),
    );
  }
}