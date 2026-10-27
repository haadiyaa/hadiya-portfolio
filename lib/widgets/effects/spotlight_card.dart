import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../theme/app_theme.dart';

/// Next-gen interactive card with dynamic cursor-following spotlight glow.
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
    final mousePos = useState<Offset>(Offset.zero);

    final cardBg = isDark ? AppTheme.darkCard : AppTheme.lightCard;
    final cardHoverBg = isDark ? AppTheme.darkCardHover : AppTheme.lightCardHover;
    final border = isDark ? AppTheme.darkBorder : AppTheme.lightBorder;
    final accent = glowColor ?? AppTheme.primaryCyan;

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
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          transform: Matrix4.translationValues(0.0, isHovered.value ? -4.0 : 0.0, 0.0),
          decoration: BoxDecoration(
            color: isHovered.value ? cardHoverBg : cardBg,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: isHovered.value
                  ? accent.withValues(alpha: 0.6)
                  : border,
              width: isHovered.value ? 1.5 : 1.0,
            ),
            boxShadow: [
              BoxShadow(
                color: isHovered.value
                    ? accent.withValues(alpha: isDark ? 0.20 : 0.12)
                    : Colors.black.withValues(alpha: isDark ? 0.25 : 0.03),
                blurRadius: isHovered.value ? 24 : 12,
                offset: Offset(0, isHovered.value ? 10 : 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: CustomPaint(
              foregroundPainter: isHovered.value
                  ? _SpotlightPainter(
                      position: mousePos.value,
                      color: accent.withValues(alpha: isDark ? 0.09 : 0.05),
                    )
                  : null,
              child: Padding(
                padding: padding,
                child: builder(isHovered.value),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SpotlightPainter extends CustomPainter {
  final Offset position;
  final Color color;

  _SpotlightPainter({required this.position, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [color, Colors.transparent],
      ).createShader(Rect.fromCircle(center: position, radius: 180));

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant _SpotlightPainter oldDelegate) {
    return oldDelegate.position != position || oldDelegate.color != color;
  }
}
