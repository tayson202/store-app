import 'package:demo_app/features/reels/data/models/reel_comment_model.dart';
import 'package:demo_app/features/reels/data/models/reel_model.dart';
import 'package:demo_app/features/reels/domain/repositories/reel_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

/// Handles all user interactions with a reel: like, save, follow, share, comments.
class ReelInteractionController extends GetxController {
  final ReelRepository _repository;

  ReelInteractionController(this._repository);

  // ── Comments ──────────────────────────────────────────────────
  final RxList<ReelCommentModel> comments = <ReelCommentModel>[].obs;
  final RxBool isLoadingComments = false.obs;
  final RxBool isPostingComment = false.obs;
  String? _loadedReelId;

  // ── Loading States ────────────────────────────────────────────
  final RxSet<String> likingReels = <String>{}.obs;
  final RxSet<String> savingReels = <String>{}.obs;
  final RxSet<String> followingSellers = <String>{}.obs;

  // ── Like ──────────────────────────────────────────────────────

  Future<void> toggleLike(ReelModel reel) async {
    if (likingReels.contains(reel.id)) return;
    likingReels.add(reel.id);

    // Optimistic update
    reel.isLiked = !reel.isLiked;
    reel.likes = reel.isLiked ? reel.likes + 1 : (reel.likes - 1).clamp(0, 999999);
    update(['reel_${reel.id}']);

    try {
      await _repository.likeReel(reel.id, reel.isLiked);
    } catch (_) {
      // Rollback on error
      reel.isLiked = !reel.isLiked;
      reel.likes = reel.isLiked ? reel.likes + 1 : (reel.likes - 1).clamp(0, 999999);
      update(['reel_${reel.id}']);
    } finally {
      likingReels.remove(reel.id);
    }
  }

  // ── Save ──────────────────────────────────────────────────────

  Future<void> toggleSave(ReelModel reel) async {
    if (savingReels.contains(reel.id)) return;
    savingReels.add(reel.id);

    reel.isSaved = !reel.isSaved;
    reel.saves = reel.isSaved ? reel.saves + 1 : (reel.saves - 1).clamp(0, 999999);
    update(['reel_${reel.id}']);

    if (reel.isSaved) {
      Get.snackbar(
        'Saved!',
        '${reel.productTitle} saved to your collection.',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
    }

    try {
      await _repository.saveReel(reel.id, reel.isSaved);
    } catch (_) {
      reel.isSaved = !reel.isSaved;
      reel.saves = reel.isSaved ? reel.saves + 1 : (reel.saves - 1).clamp(0, 999999);
      update(['reel_${reel.id}']);
    } finally {
      savingReels.remove(reel.id);
    }
  }

  // ── Follow ────────────────────────────────────────────────────

  Future<void> toggleFollow(ReelModel reel) async {
    if (followingSellers.contains(reel.sellerId)) return;
    followingSellers.add(reel.sellerId);

    reel.isFollowingSeller = !reel.isFollowingSeller;
    update(['reel_${reel.id}']);

    if (reel.isFollowingSeller) {
      Get.snackbar(
        'Following ${reel.shopName}',
        'You\'ll see more videos from this seller.',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
    }

    try {
      await _repository.followSeller(reel.sellerId, reel.isFollowingSeller);
    } catch (_) {
      reel.isFollowingSeller = !reel.isFollowingSeller;
      update(['reel_${reel.id}']);
    } finally {
      followingSellers.remove(reel.sellerId);
    }
  }

  // ── Share ─────────────────────────────────────────────────────

  Future<void> shareReel(ReelModel reel) async {
    try {
      await SharePlus.instance.share(
        ShareParams(
          text: '🛍️ Check out ${reel.productTitle} from ${reel.shopName}!\n'
              '💰 Only \$${reel.price.toStringAsFixed(2)}\n\n'
              'Download the app to shop now!',
          subject: reel.productTitle,
        ),
      );
      reel.shares++;
    } catch (_) {}
  }

  // ── Comments ──────────────────────────────────────────────────

  Future<void> loadComments(String reelId) async {
    if (_loadedReelId == reelId) return;
    isLoadingComments.value = true;
    comments.clear();
    _loadedReelId = reelId;
    try {
      final result = await _repository.getComments(reelId);
      comments.assignAll(result);
    } catch (e) {
      Get.snackbar('Error', 'Could not load comments.');
    } finally {
      isLoadingComments.value = false;
    }
  }

  Future<void> postComment(ReelModel reel, String text) async {
    if (text.trim().isEmpty) return;
    isPostingComment.value = true;
    try {
      final comment = await _repository.postComment(reel.id, text.trim());
      comments.insert(0, comment);
      reel.comments++;
      update(['reel_${reel.id}']);
    } catch (e) {
      Get.snackbar('Error', 'Could not post comment.');
    } finally {
      isPostingComment.value = false;
    }
  }

  Future<void> deleteComment(ReelModel reel, String commentId) async {
    try {
      await _repository.deleteComment(reel.id, commentId);
      comments.removeWhere((c) => c.id == commentId);
      reel.comments = (reel.comments - 1).clamp(0, 999999);
      update(['reel_${reel.id}']);
    } catch (_) {}
  }
}
