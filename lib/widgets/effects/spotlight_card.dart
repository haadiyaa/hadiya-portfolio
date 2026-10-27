import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../theme/app_theme.dart';

/// Premium iOS-inspired Liquid Glass Card with backdrop refraction,
/// specular rim highlights, and interactive cursor-following liquid glow.
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
    this.borderRadius = 22,
    this.padding = const EdgeInsets.all(26),
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isHovered = useState(false);
    final mousePos = useState<Offset>(Offset.zero);

    final accent = glowColor ?? AppTheme.primaryCyan;

    // Multi-stop liquid glass gradient fill
    final glassGradient = isDark
        ? LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white.withValues(alpha: isHovered.value ? 0.10 : 0.06),
              const Color(0xFF101726).withValues(alpha: isHovered.value ? 0.70 : 0.60),
              accent.withValues(alpha: isHovered.value ? 0.08 : 0.02),
            ],
            stops: const [0.0, 0.65, 1.0],
          )
        : LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white.withValues(alpha: isHovered.value ? 0.90 : 0.78),
              Colors.white.withValues(alpha: isHovered.value ? 0.65 : 0.52),
              accent.withValues(alpha: isHovered.value ? 0.06 : 0.01),
            ],
            stops: const [0.0, 0.7, 1.0],
          );

    // iOS Specular glass rim border
    final glassBorderColor = isHovered.value
        ? accent.withValues(alpha: isDark ? 0.65 : 0.55)
        : (isDark
            ? Colors.white.withValues(alpha: 0.13)
            : Colors.white.withValues(alpha: 0.85));

    return MouseRegion(
      onEnter: (e) {
        isHovered.value = true;
        mousePos.value = e.localPosition;
      },
      onExit: (_) => isHovered.value = false,
      onHover: (e) => mousePos.value = e.localPosition,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 240),
          curve: Curves.easeOutCubic,
          transform: Matrix4.translationValues(0.0, isHovered.value ? -5.0 : 0.0, 0.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            boxShadow: [
              // Deep diffused ambient shadow
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.35 : 0.07),
                blurRadius: isHovered.value ? 30 : 16,
                offset: Offset(0, isHovered.value ? 14 : 6),
              ),
              // Liquid colored glow
              if (isHovered.value)
                BoxShadow(
                  color: accent.withValues(alpha: isDark ? 0.22 : 0.14),
                  blurRadius: 28,
                  spreadRadius: 1,
                  offset: const Offset(0, 4),
                ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
              child: Container(
                decoration: BoxDecoration(
                  gradient: glassGradient,
                  borderRadius: BorderRadius.circular(borderRadius),
                  border: Border.all(
                    color: glassBorderColor,
                    width: isHovered.value ? 1.4 : 1.1,
                  ),
                ),
                child: CustomPaint(
                  foregroundPainter: _LiquidGlassPainter(
                    mousePos: mousePos.value,
                    isHovered: isHovered.value,
                    accentColor: accent,
                    isDark: isDark,
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

/// Paints the iOS specular rim light and interactive liquid spotlight
class _LiquidGlassPainter extends CustomPainter {
  final Offset mousePos;
  final bool isHovered;
  final Color accentColor;
  final bool isDark;

  _LiquidGlassPainter({
    required this.mousePos,
    required this.isHovered,
    required this.accentColor,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Specular top-edge liquid rim light
    final rimPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.topRight,
        colors: [
          Colors.white.withValues(alpha: isDark ? 0.35 : 0.8),
          Colors.white.withValues(alpha: isDark ? 0.10 : 0.3),
          Colors.transparent,
        ],
        stops: const [0.0, 0.45, 0.85],
      ).createShader(Rect.fromLTWH(0, 0, size.width, 2.5));

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(1, 1, size.width - 2, 2.0),
        const Radius.circular(16),
      ),
      rimPaint,
    );

    // 2. Interactive liquid chromatic spotlight when hovered
    if (isHovered) {
      final spotlightPaint = Paint()
        ..shader = RadialGradient(
          colors: [
            accentColor.withValues(alpha: isDark ? 0.12 : 0.08),
            accentColor.withValues(alpha: 0.0),
          ],
        ).createShader(Rect.fromCircle(center: mousePos, radius: 190));

      canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), spotlightPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _LiquidGlassPainter oldDelegate) {
    return oldDelegate.mousePos != mousePos ||
        oldDelegate.isHovered != isHovered ||
        oldDelegate.accentColor != accentColor ||
        oldDelegate.isDark != isDark;
  }
}
