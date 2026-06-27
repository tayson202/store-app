import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_app/features/reels/data/models/reel_model.dart';
import 'package:demo_app/features/reels/presentation/controllers/reel_feed_controller.dart';
import 'package:demo_app/features/reels/presentation/controllers/reel_interaction_controller.dart';
import 'package:demo_app/features/reels/presentation/screens/reel_comments_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReelActionSidebar extends StatelessWidget {
  final ReelModel reel;
  const ReelActionSidebar({super.key, required this.reel});

  @override
  Widget build(BuildContext context) {
    final interactionCtrl = Get.find<ReelInteractionController>();
    final feedCtrl = Get.find<ReelFeedController>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Seller Avatar with small add/follow badge
        _buildSellerAvatar(context, interactionCtrl),
        const SizedBox(height: 20),

        // Like Button
        GetBuilder<ReelInteractionController>(
          id: 'reel_${reel.id}',
          builder: (_) => _buildActionButton(
            icon: reel.isLiked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
            color: reel.isLiked ? Colors.red : Colors.white,
            label: _formatCount(reel.likes),
            onTap: () => interactionCtrl.toggleLike(reel),
            animate: reel.isLiked,
          ),
        ),

        // Comments Button
        _buildActionButton(
          icon: Icons.chat_bubble_outline_rounded,
          color: Colors.white,
          label: _formatCount(reel.comments),
          onTap: () => _showComments(context),
        ),

        // Save Button
        GetBuilder<ReelInteractionController>(
          id: 'reel_${reel.id}',
          builder: (_) => _buildActionButton(
            icon: reel.isSaved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
            color: reel.isSaved ? Colors.amber : Colors.white,
            label: _formatCount(reel.saves),
            onTap: () => interactionCtrl.toggleSave(reel),
          ),
        ),

        // Share Button
        _buildActionButton(
          icon: Icons.share_rounded,
          color: Colors.white,
          label: _formatCount(reel.shares),
          onTap: () => interactionCtrl.shareReel(reel),
        ),

        // Mute/Volume Toggle Button
        Obx(() => _buildActionButton(
              icon: feedCtrl.isMuted.value
                  ? Icons.volume_off_rounded
                  : Icons.volume_up_rounded,
              color: Colors.white,
              label: '',
              onTap: () => feedCtrl.toggleMute(),
            )),
      ],
    );
  }

  Widget _buildSellerAvatar(
    BuildContext context,
    ReelInteractionController ctrl,
  ) {
    return Stack(
      alignment: Alignment.bottomCenter,
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
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
        GetBuilder<ReelInteractionController>(
          id: 'reel_${reel.id}',
          builder: (_) {
            if (reel.isFollowingSeller) return const SizedBox.shrink();
            return Positioned(
              bottom: -6,
              child: GestureDetector(
                onTap: () => ctrl.toggleFollow(reel),
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 14,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _fallbackAvatar() {
    return Container(
      color: Colors.grey[800],
      child: const Icon(
        Icons.store_rounded,
        color: Colors.white70,
        size: 24,
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required String label,
    required VoidCallback onTap,
    bool animate = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          children: [
            AnimatedScale(
              scale: animate ? 1.2 : 1.0,
              duration: const Duration(milliseconds: 150),
              child: Icon(
                icon,
                color: color,
                size: 32,
                shadows: const [
                  Shadow(
                    color: Colors.black54,
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
            ),
            if (label.isNotEmpty) ...[
              const SizedBox(height: 5),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  shadows: [
                    Shadow(
                      color: Colors.black54,
                      blurRadius: 4,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _formatCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    }
    return count.toString();
  }

  void _showComments(BuildContext context) {
    Get.bottomSheet(
      ReelCommentsScreen(reel: reel),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }
}
