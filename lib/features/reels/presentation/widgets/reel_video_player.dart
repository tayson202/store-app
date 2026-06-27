import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_app/features/reels/data/models/reel_model.dart';
import 'package:demo_app/features/reels/presentation/controllers/reel_feed_controller.dart';
import 'package:demo_app/features/reels/presentation/controllers/reel_interaction_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class ReelVideoPlayer extends StatefulWidget {
  final ReelModel reel;
  final int index;

  const ReelVideoPlayer({
    super.key,
    required this.reel,
    required this.index,
  });

  @override
  State<ReelVideoPlayer> createState() => _ReelVideoPlayerState();
}

class _ReelVideoPlayerState extends State<ReelVideoPlayer> with TickerProviderStateMixin {
  final feedCtrl = Get.find<ReelFeedController>();
  final interactionCtrl = Get.find<ReelInteractionController>();

  bool _showPlayIcon = false;
  bool _showLikeHeart = false;
  Offset _heartPosition = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReelFeedController>(
      id: 'video_${widget.index}',
      builder: (controller) {
        final vc = controller.getController(widget.index);

        return GestureDetector(
          onTap: () {
            controller.togglePlayPause();
            setState(() {
              _showPlayIcon = true;
            });
            Future.delayed(const Duration(milliseconds: 600), () {
              if (mounted) {
                setState(() {
                  _showPlayIcon = false;
                });
              }
            });
          },
          onDoubleTapDown: (details) {
            setState(() {
              _heartPosition = details.localPosition;
              _showLikeHeart = true;
            });
            if (!widget.reel.isLiked) {
              interactionCtrl.toggleLike(widget.reel);
            }
            Future.delayed(const Duration(milliseconds: 800), () {
              if (mounted) {
                setState(() {
                  _showLikeHeart = false;
                });
              }
            });
          },
          child: Stack(
            fit: StackFit.expand,
            children: [
              // 1. Video Player or Thumbnail
              if (vc != null && vc.value.isInitialized)
                Center(
                  child: AspectRatio(
                    aspectRatio: vc.value.aspectRatio,
                    child: VideoPlayer(vc),
                  ),
                )
              else
                // Thumbnail / Loading fallback
                _buildThumbnailFallback(),

              // 2. Play/Pause Action Indicator Overlay
              if (_showPlayIcon)
                (Center(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: Colors.black38,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      controller.isPlaying(widget.index)
                          ? Icons.play_arrow_rounded
                          : Icons.pause_rounded,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                )
                    .animate()
                    .scale(
                      begin: const Offset(0.8, 0.8),
                      end: const Offset(1.3, 1.3),
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeOutBack,
                    )
                    .fadeOut(delay: const Duration(milliseconds: 300))),

              // 3. Double-tap Like Heart Overlay
              if (_showLikeHeart)
                Positioned(
                  left: _heartPosition.dx - 50,
                  top: _heartPosition.dy - 50,
                  child: (const Icon(
                    Icons.favorite_rounded,
                    color: Colors.red,
                    size: 100,
                  ))
                      .animate()
                      .scale(
                        begin: const Offset(0.3, 0.3),
                        end: const Offset(1.2, 1.2),
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeOutBack,
                      )
                      .then()
                      .scale(
                        begin: const Offset(1.2, 1.2),
                        end: const Offset(0.0, 0.0),
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeIn,
                        delay: const Duration(milliseconds: 300),
                      ),
                ),

              // 4. Thin custom progress bar at the very bottom
              if (vc != null && vc.value.isInitialized)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: VideoProgressIndicator(
                    vc,
                    allowScrubbing: true,
                    colors: VideoProgressColors(
                      playedColor: Theme.of(context).primaryColor,
                      bufferedColor: Colors.white30,
                      backgroundColor: Colors.white10,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildThumbnailFallback() {
    return Stack(
      fit: StackFit.expand,
      children: [
        if (widget.reel.thumbnailUrl != null)
          CachedNetworkImage(
            imageUrl: widget.reel.thumbnailUrl!,
            fit: BoxFit.cover,
            placeholder: (_, __) => Container(color: Colors.black),
            errorWidget: (_, __, ___) => Container(color: Colors.black),
          )
        else
          Container(color: Colors.black),
        const Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white70),
          ),
        ),
      ],
    );
  }
}
