import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../theme/app_theme.dart';

/// A reusable card with iOS liquid glass backdrop blur and specular highlights.
class HoverCard extends HookWidget {
  final Widget Function(bool isHovered) builder;
  final bool isDark;
  final Color? hoverAccentColor;
  final double borderRadius;
  final EdgeInsets padding;

  const HoverCard({
    super.key,
    required this.builder,
    required this.isDark,
    this.hoverAccentColor,
    this.borderRadius = 22,
    this.padding = const EdgeInsets.all(26),
  });

  @override
  Widget build(BuildContext context) {
    final isHovered = useState(false);
    final accent = hoverAccentColor ?? AppTheme.primaryCyan;

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

    final glassBorderColor = isHovered.value
        ? accent.withValues(alpha: isDark ? 0.65 : 0.55)
        : (isDark
            ? Colors.white.withValues(alpha: 0.13)
            : Colors.white.withValues(alpha: 0.85));

    return MouseRegion(
      onEnter: (_) => isHovered.value = true,
      onExit: (_) => isHovered.value = false,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 240),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0.0, isHovered.value ? -5.0 : 0.0, 0.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.35 : 0.07),
              blurRadius: isHovered.value ? 30 : 16,
              offset: Offset(0, isHovered.value ? 14 : 6),
            ),
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
              padding: padding,
              decoration: BoxDecoration(
                gradient: glassGradient,
                borderRadius: BorderRadius.circular(borderRadius),
                border: Border.all(
                  color: glassBorderColor,
                  width: isHovered.value ? 1.4 : 1.1,
                ),
              ),
              child: builder(isHovered.value),
            ),
          ),
        ),
      ),
    );
  }
}

/// The repeated section header pattern (tag bar ▸ title ▸ subtitle).
class SectionHeader extends StatelessWidget {
  final String tag;
  final String title;
  final String subtitle;
  final bool isDark;

  const SectionHeader({
    super.key,
    required this.tag,
    required this.title,
    required this.subtitle,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;
    final textPrimary = isDark ? AppTheme.darkTextPrimary : AppTheme.lightTextPrimary;
    final textSecondary = isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 4,
              height: 20,
              decoration: BoxDecoration(
                color: AppTheme.primaryCyan,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              tag,
              style: const TextStyle(
                color: AppTheme.primaryCyan,
                fontSize: 13,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          title,
          style: TextStyle(
            color: textPrimary,
            fontSize: isMobile ? 26 : 34,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.8,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: TextStyle(
            color: textSecondary,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}

/// Reusable small pill / tag used for tech stacks, skills, etc.
class TechTagChip extends StatelessWidget {
  final String label;
  final bool isDark;

  const TechTagChip({super.key, required this.label, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final border = isDark ? AppTheme.darkBorder : AppTheme.lightBorder;
    final textColor = isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.darkBg : AppTheme.lightCardHover,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: border),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

/// Reusable bullet-point row (cyan dot + text).
class BulletPointRow extends StatelessWidget {
  final String text;
  final Color dotColor;
  final Color textColor;

  const BulletPointRow({
    super.key,
    required this.text,
    this.dotColor = AppTheme.primaryCyan,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: dotColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 14,
                height: 1.55,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Section wrapper providing standard responsive padding and max-width constraint.
class SectionContainer extends StatelessWidget {
  final List<Widget> children;
  final double verticalPadding;

  const SectionContainer({
    super.key,
    required this.children,
    this.verticalPadding = 60,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 60,
        vertical: verticalPadding,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ),
      ),
    );
  }
}
