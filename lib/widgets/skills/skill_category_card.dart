import 'package:flutter/material.dart';
import '../../models/skill_model.dart';
import '../../theme/app_theme.dart';
import '../effects/spotlight_card.dart';

/// Interactive skill category card using SpotlightCard.
class SkillCategoryCard extends StatelessWidget {
  final SkillCategory category;
  final bool isDark;

  const SkillCategoryCard({
    super.key,
    required this.category,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final textPrimary = isDark ? AppTheme.darkTextPrimary : AppTheme.lightTextPrimary;
    final border = isDark ? AppTheme.darkBorder : AppTheme.lightBorder;

    return SpotlightCard(
      isDark: isDark,
      glowColor: AppTheme.primaryCyan,
      borderRadius: 18,
      padding: const EdgeInsets.all(24),
      builder: (_) => Column(
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
                child: Icon(category.icon, color: AppTheme.primaryCyan, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  category.title,
                  style: TextStyle(
                    color: textPrimary,
                    fontWeight: FontWeight.w700,
                    fontSize: 16.5,
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
            children: category.skills.map((skill) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
                decoration: BoxDecoration(
                  color: isDark ? AppTheme.darkBg : AppTheme.lightCardHover,
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
    );
  }
}
