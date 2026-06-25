import 'package:demo_app/controllers/cart_controller.dart';
import 'package:demo_app/controllers/product.dart';
import 'package:demo_app/features/checkout/view/screens/checkoutscreen.dart';
import 'package:demo_app/widgets/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Cartscreen extends StatelessWidget {
  const Cartscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isdark = Theme.of(context).brightness == Brightness.dark;
    final CartController cartController = Get.find<CartController>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios),
          color: isdark ? Colors.white : Colors.black,
        ),
        title: Text(
          'my cart',
          style: AppTextStyles.withColor(
            AppTextStyles.h3,
            isdark ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: Obx(() {
        if (cartController.cartItems.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.shopping_cart_outlined,
                  size: 80,
                  color: isdark ? Colors.grey[700] : Colors.grey[300],
                ),
                const SizedBox(height: 24),
                Text(
                  'your cart is empty',
                  style: AppTextStyles.withColor(
                    AppTextStyles.h2,
                    isdark ? Colors.grey[400]! : Colors.grey[600]!,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'explore products to add them to your cart',
                  style: AppTextStyles.withColor(
                    AppTextStyles.bodymid,
                    isdark ? Colors.grey[500]! : Colors.grey[500]!,
                  ),
                ),
              ],
            ),
          );
        }

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: cartController.cartItems.length,
                itemBuilder: (context, index) =>
                    buildcartitem(context, cartController.cartItems[index]),
              ),
            ),
            buildcartsummery(context),
          ],
        );
      }),
    );
  }

  Widget buildcartitem(BuildContext context, CartItem cartItem) {
    final isdark = Theme.of(context).brightness == Brightness.dark;
    final CartController cartController = Get.find<CartController>();
    final product = cartItem.product;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
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
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
            child: Image.asset(
              product.imageurl,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "${product.name} (${cartItem.size})",
                          style: AppTextStyles.withColor(
                            AppTextStyles.bodylarge,
                            Theme.of(context).textTheme.bodyLarge!.color!,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        onPressed: () =>
                            showdeleteconfirmationdialog(context, cartItem),
                        icon: Icon(
                          Icons.delete_outline,
                          color: Colors.red[400],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${(product.price * cartItem.quantity).toStringAsFixed(2)}',
                        style: AppTextStyles.withColor(
                          AppTextStyles.h3,
                          Theme.of(context).primaryColor,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () => cartController.decreaseQuantity(product, cartItem.size),
                              icon: Icon(
                                Icons.remove,
                                size: 20,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            Text(
                              '${cartItem.quantity}',
                              style: AppTextStyles.withColor(
                                AppTextStyles.bodylarge,
                                Theme.of(context).primaryColor,
                              ),
                            ),
                            IconButton(
                              onPressed: () => cartController.addProduct(product, cartItem.size),
                              icon: Icon(
                                Icons.add,
                                size: 20,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ],
                        ),
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

  void showdeleteconfirmationdialog(BuildContext context, CartItem cartItem) {
    final isdark = Theme.of(context).brightness == Brightness.dark;
    final CartController cartController = Get.find<CartController>();
    
    Get.dialog(
      AlertDialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        contentPadding: const EdgeInsets.all(24),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red[400]!.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.delete_outline,
                color: Colors.red[400],
                size: 32,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'remove item',
              style: AppTextStyles.withColor(
                AppTextStyles.h3,
                Theme.of(context).textTheme.bodyLarge!.color!,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'are u sure u want to remove this item from your cart?',
              textAlign: TextAlign.center,
              style: AppTextStyles.withColor(
                AppTextStyles.bodymid,
                isdark ? Colors.grey[400]! : Colors.grey[600]!,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Get.back(),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      side: BorderSide(
                        color: isdark ? Colors.white70 : Colors.black12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'cancel',
                      style: AppTextStyles.withColor(
                        AppTextStyles.bodymid,
                        Theme.of(context).textTheme.bodyLarge!.color!,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      cartController.removeProduct(cartItem.product, cartItem.size);
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[400],
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'remove',
                      style: AppTextStyles.withColor(
                        AppTextStyles.bodymid,
                        Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      barrierColor: Colors.black54,
    );
  }

  Widget buildcartsummery(BuildContext context) {
    final CartController cartController = Get.find<CartController>();
    
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'total(${cartController.totalItemsCount} items)',
                style: AppTextStyles.withColor(
                  AppTextStyles.bodymid,
                  Theme.of(context).textTheme.bodyLarge!.color!,
                ),
              ),
              Text(
                '\$${cartController.totalAmount.toStringAsFixed(2)}',
                style: AppTextStyles.withColor(
                  AppTextStyles.h2,
                  Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Get.to(() => const Checkoutscreen()),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'proceed to checkout',
                style: AppTextStyles.withColor(
                  AppTextStyles.bodymid,
                  Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
