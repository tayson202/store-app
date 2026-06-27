import 'package:demo_app/features/reels/data/models/reel_analytics_model.dart';
import 'package:demo_app/features/reels/data/models/reel_comment_model.dart';
import 'package:demo_app/features/reels/data/models/reel_model.dart';

/// Abstract contract for all reel data operations.
/// Swap implementations (mock → Firebase → REST) without touching the UI.
abstract class ReelRepository {
  /// Fetch paginated reels. [category] null = all categories.
  Future<List<ReelModel>> getReels({
    int page = 0,
    int pageSize = 10,
    String? category,
    String? searchQuery,
  });

  /// Fetch reels uploaded by a specific seller.
  Future<List<ReelModel>> getSellerReels(String sellerId);

  Future<void> likeReel(String reelId, bool like);
  Future<void> saveReel(String reelId, bool save);
  Future<void> followSeller(String sellerId, bool follow);
  Future<void> incrementView(String reelId);

  Future<List<ReelCommentModel>> getComments(String reelId);
  Future<ReelCommentModel> postComment(String reelId, String text);
  Future<void> deleteComment(String reelId, String commentId);

  Future<String> uploadReel({
    required String videoPath,
    required ReelModel metadata,
  });
  Future<void> updateReel(ReelModel reel);
  Future<void> deleteReel(String reelId);

  Future<ReelAnalyticsModel> getAnalytics(String reelId);

  Future<List<String>> getCategories();
}
