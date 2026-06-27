import 'dart:math';
import 'package:demo_app/features/reels/data/models/reel_model.dart';
import 'package:demo_app/features/reels/domain/repositories/reel_repository.dart';
import 'package:demo_app/features/reels/presentation/controllers/reel_feed_controller.dart';
import 'package:get/get.dart';

class ReelUploadController extends GetxController {
  final ReelRepository _repository;

  ReelUploadController(this._repository);

  // ── Form Fields ───────────────────────────────────────────────
  final RxString videoPath = ''.obs;
  final RxString productTitle = ''.obs;
  final RxString description = ''.obs;
  final RxString price = ''.obs;
  final RxString oldPrice = ''.obs;
  final RxString category = 'Electronics'.obs;
  final RxInt currentStep = 0.obs;

  // ── Upload State ──────────────────────────────────────────────
  final RxBool isUploading = false.obs;
  final RxDouble uploadProgress = 0.0.obs;
  final RxString uploadError = ''.obs;

  // ── Seller's videos ──────────────────────────────────────────
  final RxList<ReelModel> myVideos = <ReelModel>[].obs;
  final RxBool isLoadingVideos = false.obs;

  Future<void> loadMyVideos(String sellerId) async {
    isLoadingVideos.value = true;
    try {
      final videos = await _repository.getSellerReels(sellerId);
      myVideos.assignAll(videos);
    } catch (e) {
      Get.snackbar('Error', 'Could not load your videos.');
    } finally {
      isLoadingVideos.value = false;
    }
  }

  bool get isFormValid =>
      videoPath.isNotEmpty &&
      productTitle.value.trim().isNotEmpty &&
      description.value.trim().isNotEmpty &&
      price.value.isNotEmpty &&
      double.tryParse(price.value) != null;

  Future<void> uploadVideo(String sellerId, String sellerName, String shopName) async {
    if (!isFormValid) {
      Get.snackbar('Incomplete', 'Please fill in all required fields.');
      return;
    }

    isUploading.value = true;
    uploadProgress.value = 0;
    uploadError.value = '';

    try {
      // Simulate upload progress
      for (int i = 1; i <= 10; i++) {
        await Future.delayed(const Duration(milliseconds: 200));
        uploadProgress.value = i / 10;
      }

      final reel = ReelModel(
        id: 'reel_${DateTime.now().millisecondsSinceEpoch}',
        sellerId: sellerId,
        sellerName: sellerName,
        shopName: shopName,
        sellerRating: 4.5,
        videoUrl: videoPath.value,
        productTitle: productTitle.value.trim(),
        description: description.value.trim(),
        price: double.tryParse(price.value) ?? 0,
        oldPrice: double.tryParse(oldPrice.value),
        discountPercent: _calcDiscount(),
        category: category.value,
        productId: 'product_${Random().nextInt(9999)}',
        createdAt: DateTime.now(),
      );

      await _repository.uploadReel(videoPath: videoPath.value, metadata: reel);
      myVideos.insert(0, reel);

      // Append to the active global video feed
      try {
        final feedCtrl = Get.find<ReelFeedController>();
        feedCtrl.reels.insert(0, reel);
      } catch (_) {}

      _resetForm();
      Get.back();
      Get.snackbar(
        '🎉 Published!',
        'Your video is now live.',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
    } catch (e) {
      uploadError.value = e.toString();
      Get.snackbar('Upload Failed', 'Please try again.');
    } finally {
      isUploading.value = false;
    }
  }

  Future<void> deleteVideo(String reelId) async {
    try {
      await _repository.deleteReel(reelId);
      myVideos.removeWhere((r) => r.id == reelId);
      Get.snackbar('Deleted', 'Video removed successfully.');
    } catch (_) {
      Get.snackbar('Error', 'Could not delete video.');
    }
  }

  int? _calcDiscount() {
    final p = double.tryParse(price.value);
    final op = double.tryParse(oldPrice.value);
    if (p == null || op == null || op <= p) return null;
    return (((op - p) / op) * 100).round();
  }

  void _resetForm() {
    videoPath.value = '';
    productTitle.value = '';
    description.value = '';
    price.value = '';
    oldPrice.value = '';
    category.value = 'Electronics';
    currentStep.value = 0;
  }

  void setVideoPath(String path) => videoPath.value = path;
  void nextStep() => currentStep.value = (currentStep.value + 1).clamp(0, 2);
  void prevStep() => currentStep.value = (currentStep.value - 1).clamp(0, 2);
}
