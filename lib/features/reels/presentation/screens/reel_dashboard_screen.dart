import 'package:demo_app/features/reels/data/models/reel_analytics_model.dart';
import 'package:demo_app/features/reels/presentation/controllers/reel_upload_controller.dart';
import 'package:demo_app/features/reels/presentation/widgets/reel_analytics_card.dart';
import 'package:demo_app/features/reels/presentation/widgets/reel_stats_grid.dart';
import 'package:demo_app/features/reels/presentation/widgets/reel_upload_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReelDashboardScreen extends StatefulWidget {
  const ReelDashboardScreen({super.key});

  @override
  State<ReelDashboardScreen> createState() => _ReelDashboardScreenState();
}

class _ReelDashboardScreenState extends State<ReelDashboardScreen> {
  final controller = Get.find<ReelUploadController>();

  @override
  void initState() {
    super.initState();
    // Load mock seller videos
    controller.loadMyVideos('seller_techzone');
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF13131A) : Colors.grey[50],
      appBar: AppBar(
        backgroundColor: isDark ? const Color(0xFF1E1E2C) : Colors.white,
        elevation: 0.5,
        title: Text(
          'Showcase Studio',
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: isDark ? Colors.white : Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Aggregate Video Stats
            const Text(
              'Showcase Analytics',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),
            const ReelStatsGrid(),
            const SizedBox(height: 24),

            // Video Upload Entry Point Card
            const ReelUploadCard(),
            const SizedBox(height: 24),

            // Video Management Section
            const Text(
              'Manage Uploads',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),

            Obx(() {
              if (controller.isLoadingVideos.value) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              if (controller.myVideos.isEmpty) {
                return _buildEmptyState(isDark);
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.myVideos.length,
                itemBuilder: (context, index) {
                  final reel = controller.myVideos[index];
                  // Provide realistic mock analytics per uploaded video
                  final analytics = ReelAnalyticsModel(
                    reelId: reel.id,
                    views: reel.views > 0 ? reel.views : 1420,
                    likes: reel.likes > 0 ? reel.likes : 325,
                    comments: reel.comments > 0 ? reel.comments : 42,
                    saves: reel.saves > 0 ? reel.saves : 18,
                    avgWatchTimeSeconds: 15.4,
                    completionRate: 0.45,
                  );

                  return ReelAnalyticsCard(
                    reel: reel,
                    analytics: analytics,
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: isDark ? Colors.white10 : Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.videocam_off_outlined, size: 48, color: Colors.grey),
          SizedBox(height: 12),
          Text(
            'No videos uploaded',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          SizedBox(height: 4),
          Text(
            'Upload your first video to start engaging buyers.',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
