import 'package:demo_app/controllers/cart_controller.dart';
import 'package:demo_app/controllers/product.dart';
import 'package:demo_app/controllers/wishlist_controller.dart';
import 'package:demo_app/widgets/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Wishlistscreen extends StatelessWidget {
  const Wishlistscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isdark = Theme.of(context).brightness == Brightness.dark;
    final WishlistController wishlistController = Get.find<WishlistController>();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'wishlist',
          style: AppTextStyles.withColor(
            AppTextStyles.h3,
            isdark ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: Obx(() {
        final List<Product> favoriteProducts = products
            .where((p) => wishlistController.isFavorite(p))
            .toList();

        if (favoriteProducts.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.favorite_border_outlined,
                  size: 80,
                  color: isdark ? Colors.grey[700] : Colors.grey[300],
                ),
                const SizedBox(height: 24),
                Text(
                  'your wishlist is empty',
                  style: AppTextStyles.withColor(
                    AppTextStyles.h2,
                    isdark ? Colors.grey[400]! : Colors.grey[600]!,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'tap the favorite icon on items to add them here',
                  style: AppTextStyles.withColor(
                    AppTextStyles.bodymid,
                    isdark ? Colors.grey[500]! : Colors.grey[500]!,
                  ),
                ),
              ],
            ),
          );
        }

        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: buildsummerysection(context, favoriteProducts.length),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => buildwishlistitem(
                    context,
                    favoriteProducts[index],
                  ),
                  childCount: favoriteProducts.length,
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget buildsummerysection(BuildContext context, int count) {
    final isdark = Theme.of(context).brightness == Brightness.dark;
    final WishlistController wishlistController = Get.find<WishlistController>();
    final CartController cartController = Get.find<CartController>();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isdark ? Colors.grey[850] : Colors.grey[100],
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$count items',
                style: AppTextStyles.withColor(
                  AppTextStyles.h2,
                  Theme.of(context).textTheme.bodyLarge!.color!,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'in your wishlist',
                style: AppTextStyles.withColor(
                  AppTextStyles.bodymid,
                  isdark ? Colors.grey[400]! : Colors.grey[600]!,
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              wishlistController.addAllToCart(cartController);
              Get.snackbar(
                'Wishlist Swapped',
                'All wishlist items were added to your cart.',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Theme.of(context).primaryColor,
                colorText: Colors.white,
                margin: const EdgeInsets.all(16),
                borderRadius: 12,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: Text(
              'add all to cart',
              style: AppTextStyles.withColor(
                AppTextStyles.buttonmid,
                Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildwishlistitem(BuildContext context, Product product) {
    final isdark = Theme.of(context).brightness == Brightness.dark;
    final WishlistController wishlistController = Get.find<WishlistController>();
    final CartController cartController = Get.find<CartController>();

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: isdark
                ? Colors.black.withValues(alpha: 0.2)
                : Colors.grey.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(12),
            ),
            child: Image.asset(
              product.imageurl,
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: AppTextStyles.withColor(
                      AppTextStyles.bodylarge,
                      Theme.of(context).textTheme.bodyLarge!.color!,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.category,
                    style: AppTextStyles.withColor(
                      AppTextStyles.bodysmall,
                      isdark ? Colors.grey[400]! : Colors.grey[600]!,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: AppTextStyles.withColor(
                          AppTextStyles.h3,
                          Theme.of(context).textTheme.bodyLarge!.color!,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              cartController.addProduct(product, 'M');
                              Get.snackbar(
                                'Added to Cart',
                                '${product.name} was added to your cart.',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Theme.of(context).primaryColor,
                                colorText: Colors.white,
                                margin: const EdgeInsets.all(16),
                                borderRadius: 12,
                              );
                            },
                            icon: const Icon(Icons.shopping_cart_outlined),
                            color: Theme.of(context).primaryColor,
                          ),
                          IconButton(
                            onPressed: () => wishlistController.toggleFavorite(product),
                            icon: const Icon(Icons.delete_outline),
                            color: isdark
                                ? Colors.grey[400]!
                                : Colors.grey[600]!,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
