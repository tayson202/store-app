import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_app/features/reels/data/models/reel_model.dart';
import 'package:demo_app/features/reels/presentation/controllers/reel_interaction_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReelSellerInfo extends StatelessWidget {
  final ReelModel reel;
  const ReelSellerInfo({super.key, required this.reel});

  @override
  Widget build(BuildContext context) {
    final interactionCtrl = Get.find<ReelInteractionController>();
    return Row(
      children: [
        // Avatar
        GestureDetector(
          onTap: () => _openSellerProfile(context),
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: ClipOval(
              child: reel.sellerAvatarUrl != null
                  ? CachedNetworkImage(
                      imageUrl: reel.sellerAvatarUrl!,
                      fit: BoxFit.cover,
                      errorWidget: (_, __, ___) => _fallbackAvatar(),
                    )
                  : _fallbackAvatar(),
            ),
          ),
        ),
        const SizedBox(width: 10),
        // Name + rating
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                reel.shopName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  shadows: [Shadow(color: Colors.black54, blurRadius: 4)],
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  const Icon(Icons.star_rounded, color: Color(0xFFFFD700), size: 14),
                  const SizedBox(width: 3),
                  Text(
                    reel.sellerRating.toStringAsFixed(1),
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        // Follow button
        GetBuilder<ReelInteractionController>(
          id: 'reel_${reel.id}',
          builder: (_) => GestureDetector(
            onTap: () => interactionCtrl.toggleFollow(reel),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
              decoration: BoxDecoration(
                color: reel.isFollowingSeller
                    ? Colors.white.withValues(alpha: 0.2)
                    : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white,
                  width: 1.5,
                ),
              ),
              child: Text(
                reel.isFollowingSeller ? 'Following' : 'Follow',
                style: TextStyle(
                  color: reel.isFollowingSeller ? Colors.white : Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _fallbackAvatar() => Container(
        color: Colors.grey[800],
        child: const Icon(Icons.store, color: Colors.white54, size: 22),
      );

  void _openSellerProfile(BuildContext context) {
    Get.snackbar(
      reel.shopName,
      'Seller profile — coming soon!',
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 2),
    );
  }
}
