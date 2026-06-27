import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_app/features/reels/data/models/reel_analytics_model.dart';
import 'package:demo_app/features/reels/data/models/reel_model.dart';
import 'package:demo_app/features/reels/presentation/controllers/reel_upload_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReelAnalyticsCard extends StatelessWidget {
  final ReelModel reel;
  final ReelAnalyticsModel analytics;

  const ReelAnalyticsCard({
    super.key,
    required this.reel,
    required this.analytics,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final controller = Get.find<ReelUploadController>();

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF252538) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black26 : Colors.grey.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Row 1: Product Thumbnail and Basic Info
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Reel thumbnail
                Container(
                  width: 50,
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.black,
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: reel.thumbnailUrl != null
                      ? CachedNetworkImage(
                          imageUrl: reel.thumbnailUrl!,
                          fit: BoxFit.cover,
                        )
                      : const Icon(Icons.videocam, color: Colors.white54),
                ),
                const SizedBox(width: 12),
                // Title and category
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        reel.productTitle,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Category: ${reel.category}',
                        style: const TextStyle(color: Colors.grey, fontSize: 11),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '\$${reel.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                // Delete Button
                IconButton(
                  icon: const Icon(Icons.delete_outline_rounded, color: Colors.redAccent),
                  onPressed: () => _confirmDelete(context, controller),
                ),
              ],
            ),
          ),
          const Divider(height: 1),

          // Row 2: Stats Grid Summary
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem(Icons.play_arrow_outlined, 'Views', analytics.views),
                _buildStatItem(Icons.favorite_border_rounded, 'Likes', analytics.likes),
                _buildStatItem(Icons.chat_bubble_outline_rounded, 'Comments', analytics.comments),
                _buildStatItem(Icons.bookmark_border_rounded, 'Saves', analytics.saves),
              ],
            ),
          ),

          // Row 3: Watch Time & Completion Rate
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isDark ? Colors.white10 : Colors.grey[50],
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Avg Watch: ${analytics.avgWatchTimeSeconds.toStringAsFixed(1)}s',
                  style: const TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Completion Rate: ${(analytics.completionRate * 100).toStringAsFixed(0)}%',
                  style: const TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String label, int value) {
    return Column(
      children: [
        Icon(icon, size: 18, color: Colors.grey),
        const SizedBox(height: 4),
        Text(
          _formatNum(value),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 9, color: Colors.grey),
        ),
      ],
    );
  }

  String _formatNum(int num) {
    if (num >= 1000) {
      return '${(num / 1000).toStringAsFixed(1)}K';
    }
    return num.toString();
  }

  void _confirmDelete(BuildContext context, ReelUploadController ctrl) {
    Get.dialog(
      AlertDialog(
        title: const Text('Delete Showcase?'),
        content: const Text('Are you sure you want to delete this product showcase video? This action is permanent.'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              ctrl.deleteVideo(reel.id);
              Get.back();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
