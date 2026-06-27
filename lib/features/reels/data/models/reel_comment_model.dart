class ReelCommentModel {
  final String id;
  final String reelId;
  final String userId;
  final String username;
  final String? avatarUrl;
  final String text;
  final DateTime timestamp;
  int likes;
  bool isLikedByMe;

  ReelCommentModel({
    required this.id,
    required this.reelId,
    required this.userId,
    required this.username,
    this.avatarUrl,
    required this.text,
    required this.timestamp,
    this.likes = 0,
    this.isLikedByMe = false,
  });

  factory ReelCommentModel.fromJson(Map<String, dynamic> json) =>
      ReelCommentModel(
        id: json['id'] ?? '',
        reelId: json['reelId'] ?? '',
        userId: json['userId'] ?? '',
        username: json['username'] ?? '',
        avatarUrl: json['avatarUrl'],
        text: json['text'] ?? '',
        timestamp: json['timestamp'] != null
            ? DateTime.parse(json['timestamp'])
            : DateTime.now(),
        likes: json['likes'] ?? 0,
        isLikedByMe: json['isLikedByMe'] ?? false,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'reelId': reelId,
        'userId': userId,
        'username': username,
        'avatarUrl': avatarUrl,
        'text': text,
        'timestamp': timestamp.toIso8601String(),
        'likes': likes,
        'isLikedByMe': isLikedByMe,
      };
}
