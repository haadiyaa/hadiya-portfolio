import 'package:flutter/material.dart';
import '../../models/experience_model.dart';
import '../../theme/app_theme.dart';
import '../effects/spotlight_card.dart';
import '../shared_widgets.dart';

/// Single node on the Career Timeline featuring a connected vertical node.
/// Uses a Stack-based timeline line to prevent IntrinsicHeight layout overflows.
class ExperienceTimelineNode extends StatelessWidget {
  final ExperienceModel experience;
  final bool isDark;
  final bool isLast;

  const ExperienceTimelineNode({
    super.key,
    required this.experience,
    required this.isDark,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    final textPrimary = isDark ? AppTheme.darkTextPrimary : AppTheme.lightTextPrimary;
    final textSecondary = isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary;

    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 28),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Vertical connecting line behind the node
          if (!isLast)
            Positioned(
              left: 17,
              top: 36,
              bottom: -28,
              child: Container(
                width: 2,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      experience.isCurrent ? AppTheme.accentEmerald : AppTheme.primaryCyan,
                      AppTheme.primaryCyan.withValues(alpha: 0.2),
                    ],
                  ),
                ),
              ),
            ),

          // Main timeline row content
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Node circle indicator
              Container(
                width: 18,
                height: 18,
                margin: const EdgeInsets.only(top: 24, left: 9, right: 9),
                decoration: BoxDecoration(
                  color: experience.isCurrent ? AppTheme.accentEmerald : AppTheme.primaryCyan,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: (experience.isCurrent ? AppTheme.accentEmerald : AppTheme.primaryCyan)
                          .withValues(alpha: 0.5),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Center(
                  child: Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 8),

              // Main Card Content
              Expanded(
                child: SpotlightCard(
                  isDark: isDark,
                  glowColor: experience.isCurrent ? AppTheme.accentEmerald : AppTheme.primaryCyan,
                  borderRadius: 18,
                  padding: const EdgeInsets.all(26),
                  builder: (_) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Role, Status & Period
                      Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        spacing: 12,
                        runSpacing: 10,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                spacing: 10,
                                runSpacing: 4,
                                children: [
                                  Text(
                                    experience.role,
                                    style: TextStyle(
                                      color: textPrimary,
                                      fontSize: 19,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: -0.4,
                                    ),
                                  ),
                                  if (experience.isCurrent)
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                      decoration: BoxDecoration(
                                        color: AppTheme.accentEmerald.withValues(alpha: 0.12),
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: AppTheme.accentEmerald.withValues(alpha: 0.35),
                                        ),
                                      ),
                                      child: const Text(
                                        'PRESENT',
                                        style: TextStyle(
                                          color: AppTheme.accentEmerald,
                                          fontSize: 10.5,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                spacing: 8,
                                runSpacing: 4,
                                children: [
                                  Text(
                                    experience.company,
                                    style: const TextStyle(
                                      color: AppTheme.primaryCyan,
                                      fontSize: 14.5,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text('•', style: TextStyle(color: textSecondary)),
                                  Icon(Icons.location_on_outlined, size: 14, color: textSecondary),
                                  Text(
                                    experience.location,
                                    style: TextStyle(color: textSecondary, fontSize: 13),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? Colors.white.withValues(alpha: 0.05)
                                  : Colors.black.withValues(alpha: 0.04),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: isDark ? AppTheme.darkBorder : AppTheme.lightBorder,
                              ),
                            ),
                            child: Text(
                              experience.period,
                              style: TextStyle(
                                color: textSecondary,
                                fontSize: 12.5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 18),

                      // Key Achievements Bullet Points
                      ...experience.bulletPoints.map(
                        (bp) => BulletPointRow(
                          text: bp,
                          dotColor: experience.isCurrent ? AppTheme.accentEmerald : AppTheme.primaryCyan,
                          textColor: textPrimary,
                        ),
                      ),

                      const SizedBox(height: 14),

                      // Tech Stack Tags
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: experience.techTags
                            .map((tag) => TechTagChip(label: tag, isDark: isDark))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
