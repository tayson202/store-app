import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ReelShimmerLoader extends StatelessWidget {
  const ReelShimmerLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[900]!,
      highlightColor: Colors.grey[700]!,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black,
        child: Stack(
          children: [
            // Video placeholder
            Container(color: Colors.grey[900]),

            // Bottom overlay shimmer
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Seller avatar + name
                    Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: Colors.grey[800],
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 120,
                              height: 14,
                              color: Colors.grey[800],
                            ),
                            const SizedBox(height: 6),
                            Container(
                              width: 80,
                              height: 11,
                              color: Colors.grey[800],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Title
                    Container(width: double.infinity, height: 18, color: Colors.grey[800]),
                    const SizedBox(height: 8),
                    Container(width: 200, height: 14, color: Colors.grey[800]),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),

            // Right sidebar shimmer
            Positioned(
              right: 16,
              bottom: 100,
              child: Column(
                children: List.generate(
                  4,
                  (i) => Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Product card shimmer
            Positioned(
              bottom: 120,
              left: 16,
              right: 80,
              child: Container(
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.grey[800]!.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
