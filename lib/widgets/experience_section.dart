import 'package:flutter/material.dart';
import '../models/experience_model.dart';
import '../theme/app_theme.dart';
import 'shared_widgets.dart';

class ExperienceSection extends StatelessWidget {
  final bool isDark;

  const ExperienceSection({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final experiences = ExperienceModel.experiences;

    return SectionContainer(
      children: [
        SectionHeader(
          tag: 'CAREER TIMELINE',
          title: 'Professional Experience',
          subtitle:
              'Demonstrated track record in building mission-critical enterprise systems and high-fidelity mobile apps.',
          isDark: isDark,
        ),
        const SizedBox(height: 36),

        // Experience List
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: experiences.length,
          separatorBuilder: (context, index) => const SizedBox(height: 24),
          itemBuilder: (context, index) {
            return _ExperienceCard(
              experience: experiences[index],
              isDark: isDark,
            );
          },
        ),
      ],
    );
  }
}

/// Now uses the reusable [HoverCard] and [BulletPointRow] / [TechTagChip].
class _ExperienceCard extends StatelessWidget {
  final ExperienceModel experience;
  final bool isDark;

  const _ExperienceCard({
    required this.experience,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final textPrimary = isDark ? AppTheme.darkTextPrimary : AppTheme.lightTextPrimary;
    final textSecondary = isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary;
    final border = isDark ? AppTheme.darkBorder : AppTheme.lightBorder;

    return HoverCard(
      isDark: isDark,
      padding: const EdgeInsets.all(28),
      builder: (_) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Header: Role, Badges, Period
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
                    runSpacing: 6,
                    children: [
                      Text(
                        experience.role,
                        style: TextStyle(
                          color: textPrimary,
                          fontSize: 20,
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
                              color: AppTheme.accentEmerald.withValues(alpha: 0.3),
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
                          fontSize: 14,
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
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.black.withValues(alpha: 0.04),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: border),
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

          const SizedBox(height: 20),

          // Bullet Points — uses shared BulletPointRow
          ...experience.bulletPoints.map(
            (bp) => BulletPointRow(text: bp, textColor: textPrimary),
          ),

          const SizedBox(height: 16),

          // Tech Tags — uses shared TechTagChip
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: experience.techTags
                .map((tag) => TechTagChip(label: tag, isDark: isDark))
                .toList(),
          ),
        ],
      ),
    );
  }
}
