import 'package:demo_app/widgets/textstyle.dart';
import 'package:flutter/material.dart';

class Paymentmethodcard extends StatelessWidget {
  const Paymentmethodcard({super.key});

  @override
  Widget build(BuildContext context) {
    final isdark = Theme.of(context).brightness == Brightness.dark;
    return  Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isdark?Colors.black.withOpacity(0.2):
            Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2)
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.asset('asset/card.webp',
                height: 24,
                ),
              ),
              const SizedBox(width: 12,),
              Expanded(child: 
              Column(
                children: [
                  Text(
                    'visa ending in4242',
                    style: AppTextStyles.withColor(
                      AppTextStyles.bodylarge, 
                      Theme.of(context).textTheme.bodyLarge!.color!
                      ),
                  ),
                  const SizedBox(height: 4,),
                  Text(
                    'expires 12/26 ',
                    style: AppTextStyles.withColor(
                      AppTextStyles.bodysmall, 
                      isdark?Colors.grey[400]!:Colors.grey[600]!
                      ),
                  ),

                ],
              ),
              ),
              IconButton(onPressed: (){},
               icon: Icon(
                Icons.edit_outlined,
                color: Theme.of(context).primaryColor,
               ),
               ),
            ],
          )
        ],
      ),
    );
  }
}