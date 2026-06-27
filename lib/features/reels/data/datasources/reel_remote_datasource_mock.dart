import 'dart:math';
import 'package:demo_app/features/reels/data/datasources/reel_remote_datasource.dart';
import 'package:demo_app/features/reels/data/models/reel_analytics_model.dart';
import 'package:demo_app/features/reels/data/models/reel_comment_model.dart';
import 'package:demo_app/features/reels/data/models/reel_model.dart';

/// Mock datasource using Google's public sample videos + picsum images.
/// Replace this class with [ReelRemoteDatasourceFirebase] when Firebase is ready.
class ReelRemoteDatasourceMock implements ReelRemoteDatasource {
  static final _rng = Random();

  // Public domain short video clips (Google Cloud sample bucket — CORS enabled)
  static const _videoUrls = [
    'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
    'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4',
    'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4',
    'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4',
    'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4',
    'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Subaru_Outback_On_Street_And_Dirt.mp4',
    'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4',
    'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WhatCarCanYouGetForAGrand.mp4',
  ];

  static final _products = [
    _MockProduct('Wireless Noise-Cancelling Earbuds', 'Premium sound with 30hr battery. ANC + transparency mode.', 89.99, 129.99, 31, 'Electronics', 'TechZone', 4.8),
    _MockProduct('Ultra-Boost Running Shoes', 'Responsive cushioning for every stride. Breathable mesh upper.', 124.99, 169.99, 26, 'Sports', 'SportElite', 4.7),
    _MockProduct('Hydrating Skincare Set', '5-piece routine with vitamin C, hyaluronic acid & retinol.', 49.99, 79.99, 38, 'Beauty', 'BeautyPro', 4.9),
    _MockProduct('Smart Watch Pro 2025', 'Health monitoring, GPS & 7-day battery. Water resistant.', 199.99, 299.99, 33, 'Electronics', 'GadgetHub', 4.6),
    _MockProduct('Non-Slip Yoga Mat', '6mm thick eco-friendly TPE. Alignment lines included.', 34.99, 54.99, 36, 'Sports', 'FitLife', 4.8),
    _MockProduct('Premium Coffee Maker', '12-cup programmable with built-in grinder & thermal carafe.', 79.99, 119.99, 33, 'Kitchen', 'KitchenPro', 4.7),
    _MockProduct('Anti-Theft Travel Backpack', '30L waterproof with USB charging port & hidden zippers.', 54.99, 84.99, 35, 'Travel', 'TravelGear', 4.8),
    _MockProduct('LED Desk Lamp Smart', 'Touch control, 5 color modes, wireless charging pad.', 44.99, 69.99, 36, 'Home', 'HomeDecor', 4.6),
    _MockProduct('Portable Bluetooth Speaker', '360° surround sound, 20hr battery, IPX7 waterproof.', 59.99, 99.99, 40, 'Electronics', 'AudioMax', 4.9),
    _MockProduct('Gaming Mouse RGB', '25600 DPI, 8 programmable buttons, ergonomic design.', 39.99, 64.99, 38, 'Gaming', 'GamersParadise', 4.7),
    _MockProduct('Stainless Steel Water Bottle', '32oz vacuum insulated, keeps cold 24h hot 12h.', 24.99, 39.99, 38, 'Sports', 'EcoGear', 4.8),
    _MockProduct('Air Fryer XL 6Qt', 'Rapid air technology, 8 cooking presets, dishwasher safe.', 89.99, 139.99, 35, 'Kitchen', 'KitchenPro', 4.7),
    _MockProduct('Resistance Bands Set', '5 levels (10–50lbs), latex-free, includes door anchor & guide.', 19.99, 34.99, 43, 'Sports', 'FitLife', 4.9),
    _MockProduct('Wireless Charging Pad 3-in-1', 'Charge phone + watch + earbuds simultaneously.', 34.99, 59.99, 42, 'Electronics', 'TechZone', 4.6),
    _MockProduct('Face Roller & Gua Sha Set', 'Rose quartz tools for lymphatic drainage & facial sculpting.', 22.99, 39.99, 43, 'Beauty', 'BeautyPro', 4.8),
    _MockProduct('Mechanical Keyboard', 'TKL layout, hot-swappable switches, per-key RGB lighting.', 79.99, 129.99, 38, 'Gaming', 'GamersParadise', 4.7),
    _MockProduct('Foam Roller Deep Tissue', '13-inch high-density EVA foam for muscle recovery.', 29.99, 49.99, 40, 'Sports', 'FitLife', 4.8),
    _MockProduct('Humidifier Cool Mist', 'Ultra-quiet, 360° nozzle, auto shut-off, 4L tank.', 39.99, 64.99, 38, 'Home', 'HomeDecor', 4.7),
    _MockProduct('Protein Shaker Bottle', 'BlenderBall whisk, leak-proof, 28oz BPA-free.', 14.99, 24.99, 40, 'Sports', 'EcoGear', 4.9),
    _MockProduct('Standing Desk Converter', 'Sit-stand in 3 seconds, dual monitor ready, 33lb capacity.', 149.99, 229.99, 35, 'Home', 'HomeDecor', 4.6),
  ];

  static final List<ReelModel> _allReels = List.generate(
    _products.length,
    (i) {
      final p = _products[i];
      final seed = i + 42;
      return ReelModel(
        id: 'reel_$i',
        sellerId: 'seller_${p.store.toLowerCase().replaceAll(' ', '_')}',
        sellerName: '${p.store} Official',
        shopName: p.store,
        sellerRating: p.rating,
        sellerAvatarUrl: 'https://i.pravatar.cc/150?img=${(i % 20) + 1}',
        videoUrl: _videoUrls[i % _videoUrls.length],
        thumbnailUrl: 'https://picsum.photos/seed/$seed/400/700',
        productTitle: p.name,
        description: p.description,
        price: p.price,
        oldPrice: p.oldPrice,
        discountPercent: p.discount,
        category: p.category,
        productImageUrl: 'https://picsum.photos/seed/${seed + 100}/300/300',
        productId: 'product_$i',
        likes: 1200 + _rng.nextInt(50000),
        comments: 80 + _rng.nextInt(5000),
        shares: 40 + _rng.nextInt(2000),
        saves: 60 + _rng.nextInt(3000),
        views: 10000 + _rng.nextInt(500000),
        isLiked: false,
        isSaved: false,
        isFollowingSeller: false,
        createdAt: DateTime.now().subtract(Duration(hours: i * 6)),
        durationSeconds: 15 + _rng.nextInt(45),
      );
    },
  );

  // Simulate local state for likes/saves/follows
  final Map<String, bool> _likeState = {};
  final Map<String, bool> _saveState = {};
  final Map<String, bool> _followState = {};

  static final List<ReelCommentModel> _comments = List.generate(
    30,
    (i) => ReelCommentModel(
      id: 'comment_$i',
      reelId: 'reel_${i % _products.length}',
      userId: 'user_$i',
      username: _usernames[i % _usernames.length],
      avatarUrl: 'https://i.pravatar.cc/80?img=${(i % 30) + 5}',
      text: _commentTexts[i % _commentTexts.length],
      timestamp: DateTime.now().subtract(Duration(minutes: i * 13)),
      likes: _rng.nextInt(500),
      isLikedByMe: false,
    ),
  );

  static const _usernames = [
    'tech_lover99', 'shopaholic_sara', 'deal_hunter_23', 'bestbuyer_alex',
    'trendy_tess', 'budget_boss', 'luxe_lifestyle', 'everyday_essentials',
    'smart_shopper', 'value_victor',
  ];

  static const _commentTexts = [
    'This is amazing! Just ordered mine 🔥',
    'The quality is unbelievable for this price!',
    'Been using this for 3 months, highly recommend!',
    'Finally found what I was looking for 😍',
    'Shipping was super fast, love it!',
    'Great product! The discount makes it even better',
    'My second one, first lasted 2 years!',
    'Perfect gift idea! Already bought 3 for my family',
    'Does this come in other colors?',
    'Can you do a comparison with the premium version?',
  ];

  @override
  Future<List<ReelModel>> fetchReels({
    int page = 0,
    int pageSize = 10,
    String? category,
    String? searchQuery,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));
    var filtered = List<ReelModel>.from(_allReels);

    if (category != null && category != 'All') {
      filtered = filtered.where((r) => r.category == category).toList();
    }
    if (searchQuery != null && searchQuery.isNotEmpty) {
      final q = searchQuery.toLowerCase();
      filtered = filtered.where((r) =>
          r.productTitle.toLowerCase().contains(q) ||
          r.description.toLowerCase().contains(q) ||
          r.category.toLowerCase().contains(q) ||
          r.shopName.toLowerCase().contains(q)).toList();
    }

    // Apply in-memory state
    for (final reel in filtered) {
      reel.isLiked = _likeState[reel.id] ?? reel.isLiked;
      reel.isSaved = _saveState[reel.id] ?? reel.isSaved;
      reel.isFollowingSeller = _followState[reel.sellerId] ?? reel.isFollowingSeller;
    }

    final start = page * pageSize;
    if (start >= filtered.length) return [];
    final end = (start + pageSize).clamp(0, filtered.length);
    return filtered.sublist(start, end);
  }

  @override
  Future<List<ReelModel>> fetchSellerReels(String sellerId) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _allReels.where((r) => r.sellerId == sellerId).toList();
  }

  @override
  Future<void> likeReel(String reelId, bool like) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _likeState[reelId] = like;
    final reel = _allReels.firstWhere((r) => r.id == reelId, orElse: () => _allReels.first);
    reel.isLiked = like;
    reel.likes = like ? reel.likes + 1 : (reel.likes - 1).clamp(0, 999999);
  }

  @override
  Future<void> saveReel(String reelId, bool save) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _saveState[reelId] = save;
    final reel = _allReels.firstWhere((r) => r.id == reelId, orElse: () => _allReels.first);
    reel.isSaved = save;
    reel.saves = save ? reel.saves + 1 : (reel.saves - 1).clamp(0, 999999);
  }

  @override
  Future<void> followSeller(String sellerId, bool follow) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _followState[sellerId] = follow;
    for (final reel in _allReels.where((r) => r.sellerId == sellerId)) {
      reel.isFollowingSeller = follow;
    }
  }

  @override
  Future<void> incrementView(String reelId) async {
    final reel = _allReels.firstWhere((r) => r.id == reelId, orElse: () => _allReels.first);
    reel.views++;
  }

  @override
  Future<List<ReelCommentModel>> fetchComments(String reelId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _comments.where((c) => c.reelId == reelId).toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }

  @override
  Future<ReelCommentModel> postComment(String reelId, String text) async {
    await Future.delayed(const Duration(milliseconds: 400));
    final comment = ReelCommentModel(
      id: 'comment_${DateTime.now().millisecondsSinceEpoch}',
      reelId: reelId,
      userId: 'current_user',
      username: 'You',
      avatarUrl: 'https://i.pravatar.cc/80?img=1',
      text: text,
      timestamp: DateTime.now(),
      likes: 0,
    );
    _comments.insert(0, comment);
    final reel = _allReels.firstWhere((r) => r.id == reelId, orElse: () => _allReels.first);
    reel.comments++;
    return comment;
  }

  @override
  Future<void> deleteComment(String reelId, String commentId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _comments.removeWhere((c) => c.id == commentId);
  }

  @override
  Future<String> uploadReel({required String videoPath, required ReelModel metadata}) async {
    await Future.delayed(const Duration(seconds: 2));
    _allReels.insert(0, metadata);
    return metadata.id;
  }

  @override
  Future<void> updateReel(ReelModel reel) async {
    await Future.delayed(const Duration(milliseconds: 400));
    final idx = _allReels.indexWhere((r) => r.id == reel.id);
    if (idx != -1) _allReels[idx] = reel;
  }

  @override
  Future<void> deleteReel(String reelId) async {
    await Future.delayed(const Duration(milliseconds: 400));
    _allReels.removeWhere((r) => r.id == reelId);
  }

  @override
  Future<ReelAnalyticsModel> fetchAnalytics(String reelId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final reel = _allReels.firstWhere((r) => r.id == reelId, orElse: () => _allReels.first);
    return ReelAnalyticsModel(
      reelId: reelId,
      views: reel.views,
      likes: reel.likes,
      comments: reel.comments,
      shares: reel.shares,
      saves: reel.saves,
      avgWatchTimeSeconds: 18.5 + _rng.nextDouble() * 20,
      completionRate: 0.3 + _rng.nextDouble() * 0.5,
      followsFromReel: 10 + _rng.nextInt(500),
    );
  }

  @override
  Future<List<String>> fetchCategories() async {
    return ['All', 'Electronics', 'Sports', 'Beauty', 'Kitchen', 'Travel', 'Home', 'Gaming'];
  }
}

class _MockProduct {
  final String name;
  final String description;
  final double price;
  final double oldPrice;
  final int discount;
  final String category;
  final String store;
  final double rating;

  const _MockProduct(
    this.name,
    this.description,
    this.price,
    this.oldPrice,
    this.discount,
    this.category,
    this.store,
    this.rating,
  );
}
