import 'package:demo_app/features/reels/data/models/reel_model.dart';
import 'package:demo_app/features/reels/domain/repositories/reel_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class ReelFeedController extends GetxController {
  final ReelRepository _repository;

  ReelFeedController(this._repository);

  // ── Feed State ──────────────────────────────────────────────
  final RxList<ReelModel> reels = <ReelModel>[].obs;
  final RxBool isLoading = true.obs;
  final RxBool isLoadingMore = false.obs;
  final RxBool hasMore = true.obs;
  final RxString error = ''.obs;
  int _page = 0;
  static const _pageSize = 8;

  // ── Category Filter ──────────────────────────────────────────
  final RxList<String> categories = <String>[].obs;
  final RxString selectedCategory = 'All'.obs;

  // ── Current Page ─────────────────────────────────────────────
  final RxInt currentIndex = 0.obs;
  late final PageController pageController;

  // ── Video Controllers (active window: current + 1 preloaded) ──
  final Map<int, VideoPlayerController> _videoControllers = {};
  final RxBool isMuted = false.obs;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
    _loadCategories();
    loadReels();
  }

  @override
  void onClose() {
    pageController.dispose();
    for (final vc in _videoControllers.values) {
      vc.dispose();
    }
    _videoControllers.clear();
    super.onClose();
  }

  // ── Data Loading ──────────────────────────────────────────────

  Future<void> _loadCategories() async {
    try {
      final cats = await _repository.getCategories();
      categories.assignAll(cats);
    } catch (_) {}
  }

  Future<void> loadReels({bool refresh = false}) async {
    if (refresh) {
      _page = 0;
      hasMore.value = true;
      reels.clear();
      _disposeAllControllers();
    }
    if (!hasMore.value) return;

    if (_page == 0) {
      isLoading.value = true;
    } else {
      isLoadingMore.value = true;
    }
    error.value = '';

    try {
      final newReels = await _repository.getReels(
        page: _page,
        pageSize: _pageSize,
        category: selectedCategory.value == 'All' ? null : selectedCategory.value,
      );

      if (newReels.isEmpty) {
        hasMore.value = false;
      } else {
        reels.addAll(newReels);
        _page++;
        // Pre-initialize the first two video controllers
        if (_page == 1) {
          _initController(0);
          if (reels.length > 1) _initController(1);
        }
      }
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
      isLoadingMore.value = false;
    }
  }

  void onCategoryChanged(String category) {
    if (selectedCategory.value == category) return;
    selectedCategory.value = category;
    loadReels(refresh: true);
    if (pageController.hasClients) {
      pageController.jumpToPage(0);
    }
  }

  // ── Page Change ───────────────────────────────────────────────

  void onPageChanged(int index) {
    final previous = currentIndex.value;
    currentIndex.value = index;

    // Pause previous, play current
    _pauseController(previous);
    _playController(index);

    // Pre-load next
    if (index + 1 < reels.length) _initController(index + 1);

    // Dispose controllers far behind
    if (previous > 1) _disposeController(previous - 2);

    // Load more when approaching the end
    if (index >= reels.length - 3 && hasMore.value && !isLoadingMore.value) {
      loadReels();
    }

    // Increment view count
    if (index < reels.length) {
      _repository.incrementView(reels[index].id);
    }
  }

  // ── Video Player Management ───────────────────────────────────

  VideoPlayerController? getController(int index) => _videoControllers[index];

  Future<void> _initController(int index) async {
    if (index < 0 || index >= reels.length) return;
    if (_videoControllers.containsKey(index)) return;

    final url = reels[index].videoUrl;
    final controller = VideoPlayerController.networkUrl(Uri.parse(url));
    _videoControllers[index] = controller;

    try {
      await controller.initialize();
      controller.setLooping(true);
      controller.setVolume(isMuted.value ? 0 : 1);
      if (index == currentIndex.value) {
        controller.play();
      }
      update(['video_$index']);
    } catch (_) {
      // Handle init failure gracefully — thumbnail will show instead
    }
  }

  void _playController(int index) {
    final vc = _videoControllers[index];
    if (vc != null && vc.value.isInitialized) {
      vc.setVolume(isMuted.value ? 0 : 1);
      vc.play();
    } else {
      _initController(index);
    }
  }

  void _pauseController(int index) {
    _videoControllers[index]?.pause();
  }

  void _disposeController(int index) {
    final vc = _videoControllers.remove(index);
    vc?.dispose();
  }

  void _disposeAllControllers() {
    for (final vc in _videoControllers.values) {
      vc.dispose();
    }
    _videoControllers.clear();
  }

  void toggleMute() {
    isMuted.value = !isMuted.value;
    final volume = isMuted.value ? 0.0 : 1.0;
    for (final vc in _videoControllers.values) {
      vc.setVolume(volume);
    }
  }

  void togglePlayPause() {
    final vc = _videoControllers[currentIndex.value];
    if (vc == null || !vc.value.isInitialized) return;
    if (vc.value.isPlaying) {
      vc.pause();
    } else {
      vc.play();
    }
    update(['video_${currentIndex.value}']);
  }

  bool isPlaying(int index) {
    return _videoControllers[index]?.value.isPlaying ?? false;
  }
}
