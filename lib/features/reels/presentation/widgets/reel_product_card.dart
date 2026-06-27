import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_app/controllers/product.dart';
import 'package:demo_app/features/reels/data/models/reel_model.dart';
import 'package:demo_app/widgets/productdatascreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReelProductCard extends StatelessWidget {
  final ReelModel reel;
  const ReelProductCard({super.key, required this.reel});

  @override
  Widget build(BuildContext context) {
    final hasDiscount = reel.oldPrice != null && reel.discountPercent != null;

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.2),
              width: 1.5,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Row 1: Product Thumbnail + Information
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product image
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.white24,
                        width: 1,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(11),
                      child: reel.productImageUrl != null
                          ? CachedNetworkImage(
                              imageUrl: reel.productImageUrl!,
                              fit: BoxFit.cover,
                              placeholder: (_, __) => Container(color: Colors.white10),
                              errorWidget: (_, __, ___) => _fallbackImage(),
                            )
                          : _fallbackImage(),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          reel.productTitle,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              '\$${reel.price.toStringAsFixed(2)}',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            if (hasDiscount) ...[
                              const SizedBox(width: 6),
                              Text(
                                '\$${reel.oldPrice!.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  color: Colors.white54,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              'by ${reel.shopName}',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.star_rounded,
                              color: Color(0xFFFFD700),
                              size: 13,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              reel.sellerRating.toStringAsFixed(1),
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Row 2: Action Buttons (Compare & View)
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => _handleCompare(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        side: BorderSide(
                          color: Colors.white.withValues(alpha: 0.4),
                          width: 1,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Compare Now',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _navigateToProduct(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'View Product',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _fallbackImage() {
    return Container(
      color: Colors.white10,
      child: const Icon(
        Icons.shopping_bag_outlined,
        color: Colors.white38,
        size: 24,
      ),
    );
  }

  void _navigateToProduct() {
    final product = Product(
      name: reel.productTitle,
      category: reel.category,
      price: reel.price,
      oldprice: reel.oldPrice,
      imageurl: 'asset/image/OIP.webp', // use existing asset image
      isfavorite: reel.isLiked,
      description: reel.description,
    );

    Get.to(() => ProductDataScreen(product: product));
  }

  void _handleCompare(BuildContext context) {
    Get.snackbar(
      'Price Comparison',
      'Comparing ${reel.productTitle} across 3 other sellers.\nBest price found: \$${(reel.price * 0.95).toStringAsFixed(2)} at ElectroShop!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black87,
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 4),
    );
  }
}
