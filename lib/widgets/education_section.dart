import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'effects/reveal_on_scroll.dart';
import 'effects/spotlight_card.dart';
import 'shared_widgets.dart';

class EducationSection extends StatelessWidget {
  final bool isDark;

  const EducationSection({super.key, required this.isDark});

  static const _curriculum = [
    'Data Structures & Algorithms',
    'Object-Oriented Programming (OOP)',
    'Relational Database Management (RDBMS)',
    'Software Engineering & SDLC',
    'Operating Systems & Networking',
    'Web & Mobile Development Principles',
  ];

  @override
  Widget build(BuildContext context) {
    final textPrimary = isDark ? AppTheme.darkTextPrimary : AppTheme.lightTextPrimary;
    final textSecondary = isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary;

    return SectionContainer(
      children: [
        RevealOnScroll(
          child: SectionHeader(
            tag: 'ACADEMIC BACKGROUND',
            title: 'Education & Foundations',
            subtitle:
                'Computer science principles underpinning high-performance cross-platform engineering.',
            isDark: isDark,
          ),
        ),
        const SizedBox(height: 36),

        RevealOnScroll(
          delay: const Duration(milliseconds: 150),
          child: SpotlightCard(
            isDark: isDark,
            glowColor: AppTheme.primaryCyan,
            borderRadius: 20,
            padding: const EdgeInsets.all(32),
            builder: (_) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryCyan.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.school_rounded,
                        color: AppTheme.primaryCyan,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'B.Sc. in Computer Science',
                            style: TextStyle(
                              color: textPrimary,
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.4,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            "Providence Women's College, Kozhikode • University of Calicut",
                            style: TextStyle(
                              color: AppTheme.primaryCyan,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: 12,
                            runSpacing: 6,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.calendar_today_rounded, size: 14, color: textSecondary),
                                  const SizedBox(width: 6),
                                  Text(
                                    '2020 – 2023',
                                    style: TextStyle(color: textSecondary, fontSize: 13.5),
                                  ),
                                ],
                              ),
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
                                  'CGPA: 7.6 / 10',
                                  style: TextStyle(
                                    color: AppTheme.accentEmerald,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const Divider(height: 1),
                const SizedBox(height: 20),
                Text(
                  'Core Curriculum & Focus Areas:',
                  style: TextStyle(
                    color: textSecondary,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: _curriculum.map((item) {
                    return TechTagChip(label: item, isDark: isDark);
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
