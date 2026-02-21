import 'package:demo_app/widgets/textstyle.dart';
import 'package:flutter/material.dart';

class Addresscard extends StatelessWidget {
  const Addresscard({super.key});

  @override
  Widget build(BuildContext context) {
    final isdark = Theme.of(context).brightness == Brightness.dark;
    return Container (
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
        children: [
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 12,),
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'home',
                    style: AppTextStyles.withColor(
                      AppTextStyles.bodylarge, 
                      Theme.of(context).textTheme.bodyLarge!.color!
                      ),
                  ),
                  const SizedBox(height: 4,),
                  Text(
                    '123 main street,apt 55\n cairo,eg',
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