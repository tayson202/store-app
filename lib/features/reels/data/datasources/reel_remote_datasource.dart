import 'package:demo_app/features/reels/data/models/reel_analytics_model.dart';
import 'package:demo_app/features/reels/data/models/reel_comment_model.dart';
import 'package:demo_app/features/reels/data/models/reel_model.dart';

/// Abstract datasource — implement this to swap mock ↔ Firebase ↔ REST.
abstract class ReelRemoteDatasource {
  Future<List<ReelModel>> fetchReels({
    int page = 0,
    int pageSize = 10,
    String? category,
    String? searchQuery,
  });

  Future<List<ReelModel>> fetchSellerReels(String sellerId);

  Future<void> likeReel(String reelId, bool like);
  Future<void> saveReel(String reelId, bool save);
  Future<void> followSeller(String sellerId, bool follow);
  Future<void> incrementView(String reelId);

  Future<List<ReelCommentModel>> fetchComments(String reelId);
  Future<ReelCommentModel> postComment(String reelId, String text);
  Future<void> deleteComment(String reelId, String commentId);

  Future<String> uploadReel({required String videoPath, required ReelModel metadata});
  Future<void> updateReel(ReelModel reel);
  Future<void> deleteReel(String reelId);

  Future<ReelAnalyticsModel> fetchAnalytics(String reelId);
  Future<List<String>> fetchCategories();
}
