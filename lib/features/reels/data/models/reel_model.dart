class ReelModel {
  final String id;
  final String sellerId;
  final String sellerName;
  final String shopName;
  final double sellerRating;
  final String? sellerAvatarUrl;
  final String videoUrl;
  final String? thumbnailUrl;
  final String productTitle;
  final String description;
  final double price;
  final double? oldPrice;
  final int? discountPercent;
  final String category;
  final String? productImageUrl;
  final String? productId;
  int likes;
  int comments;
  int shares;
  int saves;
  int views;
  bool isLiked;
  bool isSaved;
  bool isFollowingSeller;
  final DateTime createdAt;
  final int durationSeconds;

  ReelModel({
    required this.id,
    required this.sellerId,
    required this.sellerName,
    required this.shopName,
    this.sellerRating = 4.5,
    this.sellerAvatarUrl,
    required this.videoUrl,
    this.thumbnailUrl,
    required this.productTitle,
    required this.description,
    required this.price,
    this.oldPrice,
    this.discountPercent,
    required this.category,
    this.productImageUrl,
    this.productId,
    this.likes = 0,
    this.comments = 0,
    this.shares = 0,
    this.saves = 0,
    this.views = 0,
    this.isLiked = false,
    this.isSaved = false,
    this.isFollowingSeller = false,
    required this.createdAt,
    this.durationSeconds = 30,
  });

  factory ReelModel.fromJson(Map<String, dynamic> json) => ReelModel(
        id: json['id'] ?? '',
        sellerId: json['sellerId'] ?? '',
        sellerName: json['sellerName'] ?? '',
        shopName: json['shopName'] ?? '',
        sellerRating: (json['sellerRating'] ?? 4.5).toDouble(),
        sellerAvatarUrl: json['sellerAvatarUrl'],
        videoUrl: json['videoUrl'] ?? '',
        thumbnailUrl: json['thumbnailUrl'],
        productTitle: json['productTitle'] ?? '',
        description: json['description'] ?? '',
        price: (json['price'] ?? 0).toDouble(),
        oldPrice: json['oldPrice'] != null ? (json['oldPrice']).toDouble() : null,
        discountPercent: json['discountPercent'],
        category: json['category'] ?? '',
        productImageUrl: json['productImageUrl'],
        productId: json['productId'],
        likes: json['likes'] ?? 0,
        comments: json['comments'] ?? 0,
        shares: json['shares'] ?? 0,
        saves: json['saves'] ?? 0,
        views: json['views'] ?? 0,
        isLiked: json['isLiked'] ?? false,
        isSaved: json['isSaved'] ?? false,
        isFollowingSeller: json['isFollowingSeller'] ?? false,
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'])
            : DateTime.now(),
        durationSeconds: json['durationSeconds'] ?? 30,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'sellerId': sellerId,
        'sellerName': sellerName,
        'shopName': shopName,
        'sellerRating': sellerRating,
        'sellerAvatarUrl': sellerAvatarUrl,
        'videoUrl': videoUrl,
        'thumbnailUrl': thumbnailUrl,
        'productTitle': productTitle,
        'description': description,
        'price': price,
        'oldPrice': oldPrice,
        'discountPercent': discountPercent,
        'category': category,
        'productImageUrl': productImageUrl,
        'productId': productId,
        'likes': likes,
        'comments': comments,
        'shares': shares,
        'saves': saves,
        'views': views,
        'isLiked': isLiked,
        'isSaved': isSaved,
        'isFollowingSeller': isFollowingSeller,
        'createdAt': createdAt.toIso8601String(),
        'durationSeconds': durationSeconds,
      };

  ReelModel copyWith({
    String? id,
    String? sellerId,
    String? sellerName,
    String? shopName,
    double? sellerRating,
    String? sellerAvatarUrl,
    String? videoUrl,
    String? thumbnailUrl,
    String? productTitle,
    String? description,
    double? price,
    double? oldPrice,
    int? discountPercent,
    String? category,
    String? productImageUrl,
    String? productId,
    int? likes,
    int? comments,
    int? shares,
    int? saves,
    int? views,
    bool? isLiked,
    bool? isSaved,
    bool? isFollowingSeller,
    DateTime? createdAt,
    int? durationSeconds,
  }) =>
      ReelModel(
        id: id ?? this.id,
        sellerId: sellerId ?? this.sellerId,
        sellerName: sellerName ?? this.sellerName,
        shopName: shopName ?? this.shopName,
        sellerRating: sellerRating ?? this.sellerRating,
        sellerAvatarUrl: sellerAvatarUrl ?? this.sellerAvatarUrl,
        videoUrl: videoUrl ?? this.videoUrl,
        thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
        productTitle: productTitle ?? this.productTitle,
        description: description ?? this.description,
        price: price ?? this.price,
        oldPrice: oldPrice ?? this.oldPrice,
        discountPercent: discountPercent ?? this.discountPercent,
        category: category ?? this.category,
        productImageUrl: productImageUrl ?? this.productImageUrl,
        productId: productId ?? this.productId,
        likes: likes ?? this.likes,
        comments: comments ?? this.comments,
        shares: shares ?? this.shares,
        saves: saves ?? this.saves,
        views: views ?? this.views,
        isLiked: isLiked ?? this.isLiked,
        isSaved: isSaved ?? this.isSaved,
        isFollowingSeller: isFollowingSeller ?? this.isFollowingSeller,
        createdAt: createdAt ?? this.createdAt,
        durationSeconds: durationSeconds ?? this.durationSeconds,
      );
}
