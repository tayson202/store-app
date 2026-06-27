import 'package:flutter/material.dart';

class ReelStatsGrid extends StatelessWidget {
  const ReelStatsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.6,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _buildStatTile(
          context: context,
          icon: Icons.remove_red_eye_outlined,
          color: Colors.blue,
          value: '45.8K',
          label: 'Total Views',
          isDark: isDark,
        ),
        _buildStatTile(
          context: context,
          icon: Icons.favorite_border_rounded,
          color: Colors.redAccent,
          value: '12.4K',
          label: 'Total Likes',
          isDark: isDark,
        ),
        _buildStatTile(
          context: context,
          icon: Icons.timer_outlined,
          color: Colors.orange,
          value: '22.4s',
          label: 'Avg Watch Time',
          isDark: isDark,
        ),
        _buildStatTile(
          context: context,
          icon: Icons.trending_up_rounded,
          color: Colors.green,
          value: '4.8%',
          label: 'CTR (Clicks)',
          isDark: isDark,
        ),
      ],
    );
  }

  Widget _buildStatTile({
    required BuildContext context,
    required IconData icon,
    required Color color,
    required String value,
    required String label,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF252538) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black26 : Colors.grey.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const Spacer(),
              const Icon(Icons.arrow_upward_rounded, color: Colors.green, size: 12),
              const Text(
                '12%',
                style: TextStyle(color: Colors.green, fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(color: Colors.grey, fontSize: 11),
          ),
        ],
      ),
    );
  }
}
