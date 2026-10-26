import 'package:flutter/material.dart';
import '../models/skill_model.dart';
import '../theme/app_theme.dart';

class SkillsSection extends StatelessWidget {
  final bool isDark;

  const SkillsSection({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 900;
    final textPrimary = isDark ? AppTheme.darkTextPrimary : AppTheme.lightTextPrimary;
    final textSecondary = isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary;

    final categories = SkillCategory.categories;
    final coreHighlights = SkillCategory.coreHighlights;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 60,
        vertical: 60,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Tag
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
                  const Text(
                    'TECHNICAL EXPERTISE',
                    style: TextStyle(
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
                'Skills, Frameworks & Architecture',
                style: TextStyle(
                  color: textPrimary,
                  fontSize: isMobile ? 26 : 34,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.8,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Comprehensive toolkit covering cross-platform client development, modern state architectures, and robust local persistence.',
                style: TextStyle(
                  color: textSecondary,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 32),

              // Core Strengths Pill Carousel / Banner
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isDark
                        ? [
                            AppTheme.primaryCyan.withValues(alpha: 0.08),
                            AppTheme.accentIndigo.withValues(alpha: 0.08),
                          ]
                        : [
                            AppTheme.primaryBlue.withValues(alpha: 0.05),
                            AppTheme.accentIndigo.withValues(alpha: 0.05),
                          ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppTheme.primaryCyan.withValues(alpha: 0.2),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.stars_rounded, color: AppTheme.primaryCyan, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          'CORE VALUE PROPOSITIONS',
                          style: TextStyle(
                            color: isDark ? AppTheme.primaryCyan : AppTheme.primaryBlue,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: coreHighlights.map((highlight) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: isDark ? AppTheme.darkCard : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: isDark ? AppTheme.darkBorder : AppTheme.lightBorder,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.check_circle_outline_rounded,
                                color: AppTheme.accentEmerald,
                                size: 15,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                highlight,
                                style: TextStyle(
                                  color: textPrimary,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 36),

              // Categories Grid
              LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth > 700;
                  final cardWidth = isWide ? (constraints.maxWidth - 24) / 2 : constraints.maxWidth;
                  return Wrap(
                    spacing: 24,
                    runSpacing: 24,
                    children: categories.map((category) {
                      return SizedBox(
                        width: cardWidth,
                        child: _SkillCategoryCard(
                          category: category,
                          isDark: isDark,
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SkillCategoryCard extends StatefulWidget {
  final SkillCategory category;
  final bool isDark;

  const _SkillCategoryCard({
    required this.category,
    required this.isDark,
  });

  @override
  State<_SkillCategoryCard> createState() => _SkillCategoryCardState();
}

class _SkillCategoryCardState extends State<_SkillCategoryCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final cardBg = widget.isDark ? AppTheme.darkCard : AppTheme.lightCard;
    final cardHoverBg = widget.isDark ? AppTheme.darkCardHover : AppTheme.lightCardHover;
    final border = widget.isDark ? AppTheme.darkBorder : AppTheme.lightBorder;
    final textPrimary = widget.isDark ? AppTheme.darkTextPrimary : AppTheme.lightTextPrimary;

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(26),
        decoration: BoxDecoration(
          color: isHovered ? cardHoverBg : cardBg,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isHovered ? AppTheme.primaryCyan.withValues(alpha: 0.5) : border,
            width: 1,
          ),
          boxShadow: isHovered
              ? [
                  BoxShadow(
                    color: AppTheme.primaryCyan.withValues(alpha: 0.08),
                    blurRadius: 20,
                    offset: const Offset(0, 6),
                  ),
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryCyan.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(widget.category.icon, color: AppTheme.primaryCyan, size: 22),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    widget.category.title,
                    style: TextStyle(
                      color: textPrimary,
                      fontWeight: FontWeight.w700,
                      fontSize: 17,
                      letterSpacing: -0.3,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.category.skills.map((skill) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: widget.isDark ? AppTheme.darkBg : AppTheme.lightCardHover,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: border),
                  ),
                  child: Text(
                    skill,
                    style: TextStyle(
                      color: textPrimary,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
