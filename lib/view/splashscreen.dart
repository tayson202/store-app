import 'package:demo_app/controllers/authcontroller.dart';
import 'package:demo_app/view/mainscreen.dart';
import 'package:demo_app/view/onboarding.dart';
import 'package:demo_app/view/signin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Splashscreen extends StatelessWidget {
  Splashscreen({super.key});
  final Authcontroller authcontroller = Get.find<Authcontroller>();

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).primaryColor;
    Future.delayed(const Duration(milliseconds: 2500), () {
      if (authcontroller.isfirsttime) {
        Get.off(() => const Onboarding());
      } else if (authcontroller.isloggedin) {
        Get.off(() => const Mainscreen());
      } else {
        Get.off(() => Signin());
      }
    });

    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  primary,
                  primary.withOpacity(0.8),
                  primary.withOpacity(0.6),
                ],
              ),
            ),
          ),

          // Grid pattern overlay
          Positioned.fill(
            child: Opacity(
              opacity: 0.05,
              child: const GridPattern(color: Colors.white),
            ),
          ),

          // Center animated "GYM UNITY" text
          Center(
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 1200),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    "GYM",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 8,
                    ),
                  ),
                  Text(
                    "UNITY",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 4,
                    ),
                  ),
                ],
              ),
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.translate(
                    offset: Offset(0, 10 * (1 - value)),
                    child: child,
                  ),
                );
              },
            ),
          ),

          // Bottom animated subtitle
          Positioned(
            bottom: 48,
            left: 0,
            right: 0,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 1200),
              builder: (context, value, child) {
                return Opacity(opacity: value, child: child);
              },
              child: Text(
                'style meets simple',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 14,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GridPattern extends StatelessWidget {
  final Color color;

  const GridPattern({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: GridPainter(color: color));
  }
}

class GridPainter extends CustomPainter {
  final Color color;

  GridPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 0.5;

    const spacing = 20.0;

    for (double i = 0; i < size.width; i += spacing) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }

    for (double i = 0; i < size.height; i += spacing) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
