import 'package:flutter/material.dart';
import '../models/skill_model.dart';
import '../theme/app_theme.dart';
import 'effects/reveal_on_scroll.dart';
import 'shared_widgets.dart';
import 'skills/skill_category_card.dart';

class SkillsSection extends StatelessWidget {
  final bool isDark;

  const SkillsSection({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final textPrimary = isDark ? AppTheme.darkTextPrimary : AppTheme.lightTextPrimary;
    final categories = SkillCategory.categories;
    final coreHighlights = SkillCategory.coreHighlights;

    return SectionContainer(
      children: [
        RevealOnScroll(
          child: SectionHeader(
            tag: 'TECHNICAL EXPERTISE',
            title: 'Skills, Frameworks & Architecture',
            subtitle:
                'Comprehensive toolkit covering cross-platform client development, modern state architectures, and robust local persistence.',
            isDark: isDark,
          ),
        ),
        const SizedBox(height: 32),

        // Core Strengths Banner
        RevealOnScroll(
          delay: const Duration(milliseconds: 100),
          child: Container(
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
                color: AppTheme.primaryCyan.withValues(alpha: 0.25),
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
                      'ENGINEERING VALUE PROPOSITIONS',
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
              children: List.generate(categories.length, (i) {
                return SizedBox(
                  width: cardWidth,
                  child: RevealOnScroll(
                    delay: Duration(milliseconds: 100 * (i % 4)),
                    child: SkillCategoryCard(
                      category: categories[i],
                      isDark: isDark,
                    ),
                  ),
                );
              }),
            );
          },
        ),
      ],
    );
  }
}
