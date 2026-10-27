import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../theme/app_theme.dart';

/// Ambient animated backdrop isolated with RepaintBoundary for maximum frame rates.
class AmbientMeshBackground extends HookWidget {
  final Widget child;
  final bool isDark;

  const AmbientMeshBackground({
    super.key,
    required this.child,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: const Duration(seconds: 14),
    )..repeat(reverse: true);

    return Stack(
      children: [
        // Isolated background layer
        Positioned.fill(
          child: RepaintBoundary(
            child: AnimatedBuilder(
              animation: controller,
              builder: (context, _) {
                return CustomPaint(
                  painter: _MeshGridPainter(
                    animationValue: controller.value,
                    isDark: isDark,
                  ),
                );
              },
            ),
          ),
        ),

        // Foreground content layer
        child,
      ],
    );
  }
}

class _MeshGridPainter extends CustomPainter {
  final double animationValue;
  final bool isDark;

  _MeshGridPainter({required this.animationValue, required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    // Subtle grid dots
    final dotPaint = Paint()
      ..color = isDark
          ? Colors.white.withValues(alpha: 0.025)
          : Colors.black.withValues(alpha: 0.035)
      ..style = PaintingStyle.fill;

    const spacing = 52.0;
    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), 1.0, dotPaint);
      }
    }

    // Top-left ambient glow (Cyan)
    final shift1 = math.sin(animationValue * 2 * math.pi) * 30;
    final cyanPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          (isDark ? AppTheme.primaryCyan : const Color(0xFF67E8F9))
              .withValues(alpha: isDark ? 0.09 : 0.06),
          Colors.transparent,
        ],
      ).createShader(
        Rect.fromCircle(
          center: Offset(size.width * 0.15 + shift1, size.height * 0.12 - shift1),
          radius: size.width * 0.45,
        ),
      );
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), cyanPaint);

    // Center-right ambient glow (Indigo)
    final shift2 = math.cos(animationValue * 2 * math.pi) * 40;
    final indigoPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          AppTheme.accentIndigo.withValues(alpha: isDark ? 0.07 : 0.04),
          Colors.transparent,
        ],
      ).createShader(
        Rect.fromCircle(
          center: Offset(size.width * 0.85 - shift2, size.height * 0.35 + shift2),
          radius: size.width * 0.4,
        ),
      );
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), indigoPaint);

    // Lower ambient glow (Emerald)
    final shift3 = math.sin((animationValue + 0.5) * 2 * math.pi) * 25;
    final emeraldPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          AppTheme.accentEmerald.withValues(alpha: isDark ? 0.05 : 0.03),
          Colors.transparent,
        ],
      ).createShader(
        Rect.fromCircle(
          center: Offset(size.width * 0.3 + shift3, size.height * 0.75),
          radius: size.width * 0.35,
        ),
      );
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), emeraldPaint);
  }

  @override
  bool shouldRepaint(covariant _MeshGridPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue ||
        oldDelegate.isDark != isDark;
  }
}
