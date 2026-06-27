import 'package:demo_app/features/reels/data/datasources/reel_remote_datasource.dart';
import 'package:demo_app/features/reels/data/models/reel_analytics_model.dart';
import 'package:demo_app/features/reels/data/models/reel_comment_model.dart';
import 'package:demo_app/features/reels/data/models/reel_model.dart';
import 'package:demo_app/features/reels/domain/repositories/reel_repository.dart';

/// Bridges the abstract [ReelRepository] to a [ReelRemoteDatasource].
/// Swap [_datasource] to change backends (mock → Firebase → REST).
class ReelRepositoryImpl implements ReelRepository {
  final ReelRemoteDatasource _datasource;

  const ReelRepositoryImpl(this._datasource);

  @override
  Future<List<ReelModel>> getReels({
    int page = 0,
    int pageSize = 10,
    String? category,
    String? searchQuery,
  }) =>
      _datasource.fetchReels(
        page: page,
        pageSize: pageSize,
        category: category,
        searchQuery: searchQuery,
      );

  @override
  Future<List<ReelModel>> getSellerReels(String sellerId) =>
      _datasource.fetchSellerReels(sellerId);

  @override
  Future<void> likeReel(String reelId, bool like) =>
      _datasource.likeReel(reelId, like);

  @override
  Future<void> saveReel(String reelId, bool save) =>
      _datasource.saveReel(reelId, save);

  @override
  Future<void> followSeller(String sellerId, bool follow) =>
      _datasource.followSeller(sellerId, follow);

  @override
  Future<void> incrementView(String reelId) =>
      _datasource.incrementView(reelId);

  @override
  Future<List<ReelCommentModel>> getComments(String reelId) =>
      _datasource.fetchComments(reelId);

  @override
  Future<ReelCommentModel> postComment(String reelId, String text) =>
      _datasource.postComment(reelId, text);

  @override
  Future<void> deleteComment(String reelId, String commentId) =>
      _datasource.deleteComment(reelId, commentId);

  @override
  Future<String> uploadReel({
    required String videoPath,
    required ReelModel metadata,
  }) =>
      _datasource.uploadReel(videoPath: videoPath, metadata: metadata);

  @override
  Future<void> updateReel(ReelModel reel) => _datasource.updateReel(reel);

  @override
  Future<void> deleteReel(String reelId) => _datasource.deleteReel(reelId);

  @override
  Future<ReelAnalyticsModel> getAnalytics(String reelId) =>
      _datasource.fetchAnalytics(reelId);

  @override
  Future<List<String>> getCategories() => _datasource.fetchCategories();
}
