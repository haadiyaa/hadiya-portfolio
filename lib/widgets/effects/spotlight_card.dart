import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// Pure neutral grey frosted blur glass card with iOS liquid border and curved elevation.
class SpotlightCard extends HookWidget {
  final Widget Function(bool isHovered) builder;
  final bool isDark;
  final Color? glowColor;
  final double borderRadius;
  final EdgeInsets padding;
  final VoidCallback? onTap;

  const SpotlightCard({
    super.key,
    required this.builder,
    required this.isDark,
    this.glowColor,
    this.borderRadius = 20,
    this.padding = const EdgeInsets.all(26),
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isHovered = useState(false);

    // Crystal-clear translucent glass gradient (allows background curves to blur through vividly)
    final greyGlassGradient = isDark
        ? LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1E2330).withValues(alpha: isHovered.value ? 0.18 : 0.10),
              const Color(0xFF11141E).withValues(alpha: isHovered.value ? 0.24 : 0.14),
            ],
            stops: const [0.0, 1.0],
          )
        : LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFFFFFFFF).withValues(alpha: isHovered.value ? 0.42 : 0.28),
              const Color(0xFFE2E8F0).withValues(alpha: isHovered.value ? 0.30 : 0.18),
            ],
            stops: const [0.0, 1.0],
          );

    return MouseRegion(
      onEnter: (_) => isHovered.value = true,
      onExit: (_) => isHovered.value = false,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 240),
          curve: Curves.easeOutCubic,
          transform: Matrix4.translationValues(0.0, isHovered.value ? -4.0 : 0.0, 0.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            boxShadow: [
              // Ambient elevation drop shadow
              BoxShadow(
                color: Colors.black.withValues(
                  alpha: isDark ? (isHovered.value ? 0.42 : 0.28) : 0.08,
                ),
                blurRadius: isHovered.value ? 28 : 16,
                offset: Offset(0, isHovered.value ? 10 : 5),
              ),
              // Subtle specular liquid rim elevation aura
              BoxShadow(
                color: (isDark ? const Color(0xFF38BDF8) : const Color(0xFF0284C7))
                    .withValues(alpha: isHovered.value ? 0.08 : 0.02),
                blurRadius: 12,
                spreadRadius: -2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
              child: Container(
                decoration: BoxDecoration(
                  gradient: greyGlassGradient,
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                child: CustomPaint(
                  foregroundPainter: _LiquidGlassElevationPainter(
                    isDark: isDark,
                    isHovered: isHovered.value,
                    borderRadius: borderRadius,
                  ),
                  child: Padding(
                    padding: padding,
                    child: builder(isHovered.value),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Paints the iOS liquid glass border with curved elevation (meniscus bevel) and micro-texture.
class _LiquidGlassElevationPainter extends CustomPainter {
  final bool isDark;
  final bool isHovered;
  final double borderRadius;

  const _LiquidGlassElevationPainter({
    required this.isDark,
    required this.isHovered,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final outerRRect = RRect.fromRectAndRadius(rect, Radius.circular(borderRadius));

    // 1. Outer Liquid Perimeter Edge (smooth specular gradient stroke, zero hard flat lines)
    final borderGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: isDark
          ? [
              Colors.white.withValues(alpha: isHovered ? 0.34 : 0.22),
              const Color(0xFF94A3B8).withValues(alpha: isHovered ? 0.16 : 0.10),
              Colors.white.withValues(alpha: isHovered ? 0.08 : 0.04),
            ]
          : [
              Colors.white.withValues(alpha: isHovered ? 0.85 : 0.70),
              const Color(0xFFCBD5E1).withValues(alpha: isHovered ? 0.55 : 0.45),
              const Color(0xFF94A3B8).withValues(alpha: isHovered ? 0.35 : 0.25),
            ],
      stops: const [0.0, 0.45, 1.0],
    );

    final borderPaint = Paint()
      ..shader = borderGradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = isHovered ? 1.4 : 1.1;
    canvas.drawRRect(outerRRect, borderPaint);

    // 2. Liquid Meniscus Curved Elevation (Inner Bevel Contour)
    // An inset contour ring just inside the perimeter that creates the physical 2.5D curved elevation
    final meniscusRRect = outerRRect.deflate(2.2);

    // Inner light catch on the top-left curve (convex liquid surface tension)
    final highlightGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: isDark
          ? [
              Colors.white.withValues(alpha: isHovered ? 0.20 : 0.12),
              Colors.white.withValues(alpha: isHovered ? 0.06 : 0.03),
              Colors.transparent,
            ]
          : [
              Colors.white.withValues(alpha: isHovered ? 0.60 : 0.45),
              Colors.white.withValues(alpha: 0.10),
              Colors.transparent,
            ],
      stops: const [0.0, 0.35, 0.70],
    );

    final meniscusPaint = Paint()
      ..shader = highlightGradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8;
    canvas.drawRRect(meniscusRRect, meniscusPaint);

    // Inner refraction shadow on the bottom-right curve (gives physical depth/elevation)
    final shadowGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Colors.transparent,
        Colors.black.withValues(alpha: isDark ? (isHovered ? 0.24 : 0.16) : 0.06),
      ],
      stops: const [0.60, 1.0],
    );

    final shadowPaint = Paint()
      ..shader = shadowGradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6;
    canvas.drawRRect(meniscusRRect, shadowPaint);

    // 3. Microscopic Frosted Texture (fine tactile stippling)
    final dotPaint = Paint()
      ..color = isDark
          ? Colors.white.withValues(alpha: 0.022)
          : Colors.black.withValues(alpha: 0.018)
      ..style = PaintingStyle.fill;

    const step = 8.0;
    for (double y = 4; y < size.height; y += step) {
      final xOffset = ((y / step).round() % 2 == 0) ? 0.0 : (step / 2);
      for (double x = 4; x < size.width; x += step) {
        canvas.drawCircle(Offset(x + xOffset, y), 0.75, dotPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _LiquidGlassElevationPainter oldDelegate) =>
      oldDelegate.isDark != isDark ||
      oldDelegate.isHovered != isHovered ||
      oldDelegate.borderRadius != borderRadius;
}
