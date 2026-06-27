import 'package:demo_app/features/reels/data/models/reel_model.dart';
import 'package:flutter/material.dart';

class ReelOverlayInfo extends StatelessWidget {
  final ReelModel reel;
  const ReelOverlayInfo({super.key, required this.reel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            reel.category,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
        ),
        const SizedBox(height: 10),
        // Product title
        Text(
          reel.productTitle,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w800,
            height: 1.2,
            shadows: [
              Shadow(color: Colors.black87, blurRadius: 8),
            ],
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 6),
        // Description
        Text(
          reel.description,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.85),
            fontSize: 13,
            height: 1.4,
            shadows: const [Shadow(color: Colors.black54, blurRadius: 6)],
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 12),
        // Price row
        Row(
          children: [
            Text(
              '\$${reel.price.toStringAsFixed(2)}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w900,
                shadows: [Shadow(color: Colors.black87, blurRadius: 6)],
              ),
            ),
            if (reel.oldPrice != null) ...[
              const SizedBox(width: 8),
              Text(
                '\$${reel.oldPrice!.toStringAsFixed(2)}',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.lineThrough,
                  decorationColor: Colors.white54,
                ),
              ),
            ],
            if (reel.discountPercent != null) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF3B30),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '-${reel.discountPercent}%',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}
