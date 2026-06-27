import 'package:demo_app/features/reels/data/models/reel_model.dart';
import 'package:demo_app/features/reels/presentation/widgets/reel_action_sidebar.dart';
import 'package:demo_app/features/reels/presentation/widgets/reel_overlay_info.dart';
import 'package:demo_app/features/reels/presentation/widgets/reel_product_card.dart';
import 'package:demo_app/features/reels/presentation/widgets/reel_seller_info.dart';
import 'package:demo_app/features/reels/presentation/widgets/reel_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ReelPageItem extends StatelessWidget {
  final ReelModel reel;
  final int index;

  const ReelPageItem({
    super.key,
    required this.reel,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // 1. Base Loop Player
        ReelVideoPlayer(reel: reel, index: index),

        // 2. Linear Gradient overlays to ensure text/sidebar visibility
        _buildGradients(),

        // 3. Right Action Sidebar (likes, comment, share, bookmark, mute)
        Positioned(
          right: 12,
          bottom: 120,
          child: ReelActionSidebar(reel: reel)
              .animate()
              .fade(duration: const Duration(milliseconds: 400))
              .slideX(begin: 0.5, end: 0, curve: Curves.easeOutCubic),
        ),

        // 4. Bottom-Left Information Overlay & Floating Product Card
        Positioned(
          left: 16,
          right: 88, // Clear action sidebar area
          bottom: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Seller shop info
              ReelSellerInfo(reel: reel)
                  .animate()
                  .fade(duration: const Duration(milliseconds: 300))
                  .slideY(begin: 0.2, end: 0),
              const SizedBox(height: 12),

              // Title, Description & Pricing
              ReelOverlayInfo(reel: reel)
                  .animate()
                  .fade(duration: const Duration(milliseconds: 400), delay: const Duration(milliseconds: 100))
                  .slideY(begin: 0.2, end: 0),
              const SizedBox(height: 16),

              // Floating Product Glass Card
              ReelProductCard(reel: reel)
                  .animate()
                  .fade(duration: const Duration(milliseconds: 500), delay: const Duration(milliseconds: 200))
                  .slideY(begin: 0.3, end: 0, curve: Curves.easeOutBack),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGradients() {
    return Stack(
      children: [
        // Top shadow (for category chips / status bar)
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: 140,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withValues(alpha: 0.6),
                  Colors.black.withValues(alpha: 0.3),
                  Colors.transparent,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
        // Bottom shadow (for text content overlay & product card)
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          height: 380,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.35),
                  Colors.black.withValues(alpha: 0.75),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
