import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

/// Minimal curved backdrop integrated directly into the scrolling page content.
/// Scrolls 1:1 with the page and provides clean glowing lines for frosted glass cards to blur through.
class AmbientMeshBackground extends StatelessWidget {
  final Widget child;
  final bool isDark;

  const AmbientMeshBackground({
    super.key,
    required this.child,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background layer sized to the full scrollable height of the child
        Positioned.fill(
          child: RepaintBoundary(
            child: CustomPaint(
              painter: _CurvedMeshPainter(isDark: isDark),
            ),
          ),
        ),

        // Foreground content layer
        child,
      ],
    );
  }
}

class _CurvedMeshPainter extends CustomPainter {
  final bool isDark;

  const _CurvedMeshPainter({required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // 1. Radiant ambient glowing spheres behind key content sections
    final cyanBase = isDark ? const Color(0xFF38BDF8) : const Color(0xFF0284C7);
    final indigoBase = isDark ? const Color(0xFF818CF8) : const Color(0xFF6366F1);
    final emeraldBase = isDark ? AppTheme.accentEmerald : const Color(0xFF34D399);
    final slateBase = isDark ? const Color(0xFFE2E8F0) : const Color(0xFF64748B);

    // Glowing cyan sphere behind hero & upper highlights
    final cyanPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          cyanBase.withValues(alpha: isDark ? 0.22 : 0.16),
          indigoBase.withValues(alpha: isDark ? 0.10 : 0.06),
          Colors.transparent,
        ],
        stops: const [0.0, 0.50, 1.0],
      ).createShader(
        Rect.fromCircle(
          center: Offset(w * 0.25, h * 0.08),
          radius: w * 0.48,
        ),
      );
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h), cyanPaint);

    // Glowing indigo sphere behind timeline & upper projects
    final indigoPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          indigoBase.withValues(alpha: isDark ? 0.20 : 0.14),
          cyanBase.withValues(alpha: isDark ? 0.08 : 0.04),
          Colors.transparent,
        ],
        stops: const [0.0, 0.55, 1.0],
      ).createShader(
        Rect.fromCircle(
          center: Offset(w * 0.78, h * 0.32),
          radius: w * 0.46,
        ),
      );
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h), indigoPaint);

    // Glowing cyan/indigo sphere behind projects & skills
    final projectsPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          cyanBase.withValues(alpha: isDark ? 0.18 : 0.12),
          indigoBase.withValues(alpha: isDark ? 0.09 : 0.05),
          Colors.transparent,
        ],
        stops: const [0.0, 0.50, 1.0],
      ).createShader(
        Rect.fromCircle(
          center: Offset(w * 0.28, h * 0.56),
          radius: w * 0.46,
        ),
      );
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h), projectsPaint);

    // Glowing emerald sphere behind education & contact
    final emeraldPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          emeraldBase.withValues(alpha: isDark ? 0.16 : 0.10),
          Colors.transparent,
        ],
        stops: const [0.0, 1.0],
      ).createShader(
        Rect.fromCircle(
          center: Offset(w * 0.65, h * 0.82),
          radius: w * 0.42,
        ),
      );
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h), emeraldPaint);

    // 2. Minimal flowing curved lines traversing behind cards
    void drawGlowPath(Path path, Color color, double coreWidth, double coreAlpha) {
      // Soft ambient luminous halo
      final glowPaint = Paint()
        ..color = color.withValues(alpha: isDark ? 0.14 : 0.10)
        ..style = PaintingStyle.stroke
        ..strokeWidth = coreWidth * 3.4
        ..strokeCap = StrokeCap.round;
      canvas.drawPath(path, glowPaint);

      // Crisp luminous core line
      final corePaint = Paint()
        ..color = color.withValues(alpha: coreAlpha)
        ..style = PaintingStyle.stroke
        ..strokeWidth = coreWidth
        ..strokeCap = StrokeCap.round;
      canvas.drawPath(path, corePaint);
    }

    // Line 1: Sweeps behind Hero Section & Highlights
    final path1 = Path()
      ..moveTo(-60, h * 0.07)
      ..cubicTo(w * 0.30, h * 0.03, w * 0.70, h * 0.12, w + 60, h * 0.08);
    drawGlowPath(path1, cyanBase, 2.4, isDark ? 0.60 : 0.55);

    // Line 2: Flows behind Career Experience Timeline
    final path2 = Path()
      ..moveTo(-60, h * 0.30)
      ..cubicTo(w * 0.35, h * 0.37, w * 0.68, h * 0.24, w + 60, h * 0.33);
    drawGlowPath(path2, indigoBase, 2.4, isDark ? 0.58 : 0.52);

    // Line 3: Sweeps across Featured Projects
    final path3 = Path()
      ..moveTo(-60, h * 0.50)
      ..cubicTo(w * 0.32, h * 0.44, w * 0.68, h * 0.58, w + 60, h * 0.49);
    drawGlowPath(path3, cyanBase, 2.4, isDark ? 0.60 : 0.55);

    // Line 4: Complementary ribbon curve behind Projects
    final path4 = Path()
      ..moveTo(-60, h * 0.56)
      ..cubicTo(w * 0.38, h * 0.62, w * 0.65, h * 0.50, w + 60, h * 0.60);
    drawGlowPath(path4, slateBase, 1.8, isDark ? 0.42 : 0.40);

    // Line 5: Flows behind Technical Skills & Education
    final path5 = Path()
      ..moveTo(-60, h * 0.76)
      ..cubicTo(w * 0.32, h * 0.70, w * 0.68, h * 0.82, w + 60, h * 0.75);
    drawGlowPath(path5, emeraldBase, 2.2, isDark ? 0.55 : 0.50);

    // Line 6: Flows behind Contact & Footer
    final path6 = Path()
      ..moveTo(-60, h * 0.92)
      ..cubicTo(w * 0.38, h * 0.96, w * 0.72, h * 0.88, w + 60, h * 0.93);
    drawGlowPath(path6, cyanBase, 2.0, isDark ? 0.50 : 0.46);
  }

  @override
  bool shouldRepaint(covariant _CurvedMeshPainter oldDelegate) =>
      oldDelegate.isDark != isDark;
}
