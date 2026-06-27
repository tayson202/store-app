import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_app/features/reels/data/models/reel_model.dart';
import 'package:demo_app/features/reels/presentation/controllers/reel_feed_controller.dart';
import 'package:demo_app/features/reels/presentation/widgets/reel_page_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ReelSearchScreen extends StatefulWidget {
  const ReelSearchScreen({super.key});

  @override
  State<ReelSearchScreen> createState() => _ReelSearchScreenState();
}

class _ReelSearchScreenState extends State<ReelSearchScreen> {
  final feedCtrl = Get.find<ReelFeedController>();
  final TextEditingController _searchCtrl = TextEditingController();
  final RxList<ReelModel> _results = <ReelModel>[].obs;
  final RxBool _isSearching = false.obs;
  final RxString _query = ''.obs;

  @override
  void initState() {
    super.initState();
    // Default show all reels
    _results.assignAll(feedCtrl.reels);
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  void _onSearch(String val) async {
    _query.value = val;
    if (val.trim().isEmpty) {
      _results.assignAll(feedCtrl.reels);
      return;
    }

    _isSearching.value = true;
    try {
      // Query repository via feed controller's repository access if needed,
      // or directly use feed controller's list with local matching
      final searchVal = val.toLowerCase();
      final matched = feedCtrl.reels.where((r) =>
          r.productTitle.toLowerCase().contains(searchVal) ||
          r.description.toLowerCase().contains(searchVal) ||
          r.category.toLowerCase().contains(searchVal) ||
          r.shopName.toLowerCase().contains(searchVal)).toList();
      
      _results.assignAll(matched);
    } catch (_) {
      Get.snackbar('Error', 'Search failed.');
    } finally {
      _isSearching.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF13131A) : Colors.grey[50],
      appBar: AppBar(
        backgroundColor: isDark ? const Color(0xFF1E1E2C) : Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: isDark ? Colors.white : Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: isDark ? Colors.white10 : Colors.grey[100],
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextField(
            controller: _searchCtrl,
            onChanged: _onSearch,
            style: TextStyle(color: isDark ? Colors.white : Colors.black),
            decoration: const InputDecoration(
              hintText: 'Search products, categories, shops...',
              hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
              prefixIcon: Icon(Icons.search, color: Colors.grey, size: 20),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 8),
            ),
          ),
        ),
      ),
      body: Obx(() {
        if (_isSearching.value) {
          return _buildGridShimmer();
        }

        if (_results.isEmpty) {
          return _buildNoResultsState(isDark);
        }

        return GridView.builder(
          padding: const EdgeInsets.all(12),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.65,
          ),
          itemCount: _results.length,
          itemBuilder: (context, index) {
            return _buildReelThumbnail(context, _results[index]);
          },
        );
      }),
    );
  }

  Widget _buildReelThumbnail(BuildContext context, ReelModel reel) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () {
        // Find index in master feed or jump to a dedicated feed page view
        final masterIdx = feedCtrl.reels.indexWhere((r) => r.id == reel.id);
        if (masterIdx != -1) {
          feedCtrl.pageController.jumpToPage(masterIdx);
          Get.back();
        } else {
          // Launch a standalone player
          Get.to(() => Scaffold(
                backgroundColor: Colors.black,
                body: ReelPageItem(reel: reel, index: 0),
              ));
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: isDark ? Colors.grey[900] : Colors.grey[200],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Thumbnail image
            if (reel.thumbnailUrl != null)
              CachedNetworkImage(
                imageUrl: reel.thumbnailUrl!,
                fit: BoxFit.cover,
              )
            else
              Container(color: Colors.grey[850]),

            // Gradient shadow overlay
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.black38,
                      Colors.black87,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),

            // Top Category tag
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  reel.category,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),

            // Views overlay count
            Positioned(
              top: 8,
              right: 8,
              child: Row(
                children: [
                  const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 14),
                  const SizedBox(width: 2),
                  Text(
                    _formatViews(reel.views),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),

            // Product / Seller Details Overlay at bottom
            Positioned(
              bottom: 8,
              left: 8,
              right: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    reel.productTitle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${reel.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        reel.shopName,
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 10,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridShimmer() {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.65,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNoResultsState(bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.search_off_rounded, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          Text(
            'No results for "${_query.value}"',
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Try checking spelling or search categories.',
            style: TextStyle(color: Colors.grey, fontSize: 13),
          ),
        ],
      ),
    );
  }

  String _formatViews(int views) {
    if (views >= 1000) {
      return '${(views / 1000).toStringAsFixed(0)}K';
    }
    return views.toString();
  }
}
