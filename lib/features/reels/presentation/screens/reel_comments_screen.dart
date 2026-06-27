import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_app/features/reels/data/models/reel_comment_model.dart';
import 'package:demo_app/features/reels/data/models/reel_model.dart';
import 'package:demo_app/features/reels/presentation/controllers/reel_interaction_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReelCommentsScreen extends StatefulWidget {
  final ReelModel reel;
  const ReelCommentsScreen({super.key, required this.reel});

  @override
  State<ReelCommentsScreen> createState() => _ReelCommentsScreenState();
}

class _ReelCommentsScreenState extends State<ReelCommentsScreen> {
  final controller = Get.find<ReelInteractionController>();
  final TextEditingController _commentInputCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.loadComments(widget.reel.id);
  }

  @override
  void dispose() {
    _commentInputCtrl.dispose();
    super.dispose();
  }

  void _submitComment() {
    final text = _commentInputCtrl.text.trim();
    if (text.isEmpty) return;
    controller.postComment(widget.reel, text);
    _commentInputCtrl.clear();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E2C) : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          // Drag handle indicator
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: isDark ? Colors.white24 : Colors.black12,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 12),

          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Comments (${widget.reel.comments})',
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.close_rounded,
                    color: isDark ? Colors.white70 : Colors.black54,
                  ),
                  onPressed: () => Get.back(),
                ),
              ],
            ),
          ),
          const Divider(height: 1),

          // Comments List
          Expanded(
            child: Obx(() {
              if (controller.isLoadingComments.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.comments.isEmpty) {
                return _buildEmptyState(isDark);
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: controller.comments.length,
                itemBuilder: (context, index) {
                  return _buildCommentTile(context, controller.comments[index]);
                },
              );
            }),
          ),
          const Divider(height: 1),

          // Comment Input
          Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 16,
              top: 12,
              left: 16,
              right: 16,
            ),
            child: Row(
              children: [
                // Current user avatar placeholder
                const CircleAvatar(
                  radius: 18,
                  backgroundImage: CachedNetworkImageProvider('https://i.pravatar.cc/80?img=1'),
                ),
                const SizedBox(width: 12),
                // Text Field
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.white10 : Colors.grey[100],
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: TextField(
                      controller: _commentInputCtrl,
                      style: TextStyle(color: isDark ? Colors.white : Colors.black),
                      decoration: const InputDecoration(
                        hintText: 'Add a comment...',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                      ),
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => _submitComment(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // Send button
                Obx(() => controller.isPostingComment.value
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : IconButton(
                        icon: Icon(
                          Icons.send_rounded,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: _submitComment,
                      )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentTile(BuildContext context, ReelCommentModel comment) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar
          CircleAvatar(
            radius: 18,
            backgroundColor: Colors.grey[800],
            backgroundImage: comment.avatarUrl != null
                ? CachedNetworkImageProvider(comment.avatarUrl!)
                : null,
            child: comment.avatarUrl == null
                ? const Icon(Icons.person, color: Colors.white70, size: 18)
                : null,
          ),
          const SizedBox(width: 12),
          // Comment Bubble
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      comment.username,
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _timeAgo(comment.timestamp),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  comment.text,
                  style: TextStyle(
                    color: isDark ? Colors.white.withValues(alpha: 0.87) : Colors.black.withValues(alpha: 0.87),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          // Like comment button
          Column(
            children: [
              IconButton(
                icon: Icon(
                  comment.isLikedByMe ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                  size: 16,
                  color: comment.isLikedByMe ? Colors.red : Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    comment.isLikedByMe = !comment.isLikedByMe;
                    comment.likes = comment.isLikedByMe
                        ? comment.likes + 1
                        : (comment.likes - 1).clamp(0, 9999);
                  });
                },
              ),
              if (comment.likes > 0)
                Text(
                  '${comment.likes}',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.chat_bubble_outline_rounded,
            size: 48,
            color: Colors.grey,
          ),
          const SizedBox(height: 12),
          Text(
            'No comments yet',
            style: TextStyle(
              color: isDark ? Colors.white54 : Colors.black54,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Be the first to share your thoughts!',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  String _timeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inDays > 0) return '${diff.inDays}d';
    if (diff.inHours > 0) return '${diff.inHours}h';
    if (diff.inMinutes > 0) return '${diff.inMinutes}m';
    return 'now';
  }
}
