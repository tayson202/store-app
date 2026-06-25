import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class LocalVideoPlayer extends StatefulWidget {
  final String assetPath;
  final double width;
  final double height;
  final bool loop;
  final bool autoPlay;

  const LocalVideoPlayer({
    super.key,
    required this.assetPath,
    this.width = 200,
    this.height = 200,
    this.loop = true,
    this.autoPlay = true,
  });

  @override
  State<LocalVideoPlayer> createState() => _LocalVideoPlayerState();
}

class _LocalVideoPlayerState extends State<LocalVideoPlayer> {
  VideoPlayerController? _controller;
  bool _isInitialized = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    try {
      // Create controller with correct asset path
      final path = widget.assetPath.startsWith('assets/') || widget.assetPath.startsWith('asset/')
          ? widget.assetPath
          : 'asset/${widget.assetPath}';
      
      _controller = VideoPlayerController.asset(path);
      await _controller!.initialize();
      
      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
        if (widget.loop) {
          await _controller!.setLooping(true);
        }
        if (widget.autoPlay) {
          await _controller!.play();
        }
      }
    } catch (e) {
      debugPrint('Error initializing video player: $e');
      if (mounted) {
        setState(() {
          _hasError = true;
        });
      }
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return Container(
        width: widget.width,
        height: widget.height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.video_library_outlined, size: 48, color: Colors.grey[500]),
            const SizedBox(height: 8),
            Text(
              'Video Preview Unavailable',
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
          ],
        ),
      );
    }

    if (!_isInitialized || _controller == null) {
      return SizedBox(
        width: widget.width,
        height: widget.height,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: AspectRatio(
          aspectRatio: _controller!.value.aspectRatio,
          child: VideoPlayer(_controller!),
        ),
      ),
    );
  }
}
