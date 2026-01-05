import 'package:demo_app/controllers/product.dart';
import 'package:demo_app/widgets/textstyle.dart';
import 'package:flutter/material.dart';

class Productcard extends StatelessWidget {
  final Product product;

  const Productcard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      constraints: BoxConstraints(maxWidth: screenWidth * 0.9),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.3)
                : Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              /// Product image
              AspectRatio(
                aspectRatio: 16 / 9,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: Image.asset(
                    product.imageurl,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              /// Favorite button
              Positioned(
                right: 8,
                top: 8,
                child: IconButton(
                  icon: Icon(
                    product.isfavorite ? Icons.favorite : Icons.favorite_border,
                    color: product.isfavorite
                        ? Theme.of(context).primaryColor
                        : isDark
                        ? Colors.grey[400]
                        : Colors.grey,
                  ),
                  onPressed: () {},
                ),
              ),

              /// Discount badge
              if (product.oldprice != null)
                Positioned(
                  left: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      '${(((product.oldprice! - product.price) / product.oldprice!) * 100).round()}% OFF',
                      style: AppTextStyles.withColor(
                        AppTextStyles.withweight(
                          AppTextStyles.bodysmall,
                          FontWeight.bold,
                        ),
                        Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),

          /// Product details
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: AppTextStyles.withColor(
                    AppTextStyles.withweight(AppTextStyles.h3, FontWeight.bold),
                    Theme.of(context).textTheme.bodyLarge!.color!,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: screenWidth * 0.01),
                Text(
                  product.category,
                  style: AppTextStyles.withColor(
                    AppTextStyles.bodymid,
                    isDark ? Colors.grey[400]! : Colors.grey[600]!,
                  ),
                ),
                SizedBox(height: screenWidth * 0.02),
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: AppTextStyles.withColor(
                    AppTextStyles.withweight(
                      AppTextStyles.bodylarge,
                      FontWeight.bold,
                    ),
                    Theme.of(context).textTheme.bodyLarge!.color!,
                  ),
                ),
                if (product.oldprice != null) ...[
                  SizedBox(width: screenWidth * 0.01),
                  Text(
                    '\$${product.oldprice?.toStringAsFixed(2)}',
                    style: AppTextStyles.withColor(
                      AppTextStyles.bodysmall,
                      isDark ? Colors.grey[400]! : Colors.grey[600]!,
                    ).copyWith(decoration: TextDecoration.lineThrough),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
