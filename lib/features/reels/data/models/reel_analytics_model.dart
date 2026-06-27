class ReelAnalyticsModel {
  final String reelId;
  final int views;
  final int likes;
  final int comments;
  final int shares;
  final int saves;
  final double avgWatchTimeSeconds;
  final double completionRate; // 0.0 - 1.0
  final int followsFromReel;

  const ReelAnalyticsModel({
    required this.reelId,
    this.views = 0,
    this.likes = 0,
    this.comments = 0,
    this.shares = 0,
    this.saves = 0,
    this.avgWatchTimeSeconds = 0,
    this.completionRate = 0,
    this.followsFromReel = 0,
  });

  double get engagementRate =>
      views == 0 ? 0 : (likes + comments + shares + saves) / views;

  factory ReelAnalyticsModel.fromJson(Map<String, dynamic> json) =>
      ReelAnalyticsModel(
        reelId: json['reelId'] ?? '',
        views: json['views'] ?? 0,
        likes: json['likes'] ?? 0,
        comments: json['comments'] ?? 0,
        shares: json['shares'] ?? 0,
        saves: json['saves'] ?? 0,
        avgWatchTimeSeconds: (json['avgWatchTimeSeconds'] ?? 0).toDouble(),
        completionRate: (json['completionRate'] ?? 0).toDouble(),
        followsFromReel: json['followsFromReel'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'reelId': reelId,
        'views': views,
        'likes': likes,
        'comments': comments,
        'shares': shares,
        'saves': saves,
        'avgWatchTimeSeconds': avgWatchTimeSeconds,
        'completionRate': completionRate,
        'followsFromReel': followsFromReel,
      };
}
