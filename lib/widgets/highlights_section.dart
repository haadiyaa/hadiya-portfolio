import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'shared_widgets.dart';

class HighlightsSection extends StatelessWidget {
  final bool isDark;

  const HighlightsSection({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final pillars = [
      _PillarItem(
        title: 'Enterprise ERP Architecture',
        description:
            'Extensive hands-on experience engineering scalable, high-throughput ERP modules spanning Sales, Inventory, CRM, and Finance.',
        icon: Icons.business_center_rounded,
        tag: 'Core Specialization',
        color: AppTheme.primaryCyan,
      ),
      _PillarItem(
        title: 'Offline-First & Auto-Sync',
        description:
            'Designing resilient local persistence systems with SQLite and SQFlite, equipped with seamless background server synchronization.',
        icon: Icons.cloud_sync_rounded,
        tag: 'Data Reliability',
        color: AppTheme.accentEmerald,
      ),
      _PillarItem(
        title: 'Clean Architecture & State',
        description:
            'Production mastery of Riverpod, Hooks Riverpod, BLoC, and Provider with decoupled domain, data, and presentation layers.',
        icon: Icons.layers_rounded,
        tag: 'Scalability',
        color: AppTheme.accentIndigo,
      ),
      _PillarItem(
        title: 'Pixel-Perfect Figma to Flutter',
        description:
            'Translating design tokens, micro-interactions, and complex wireframes into responsive Flutter widgets across desktop, tablets, and mobile.',
        icon: Icons.design_services_rounded,
        tag: 'Design Engineering',
        color: AppTheme.accentAmber,
      ),
    ];

    return SectionContainer(
      verticalPadding: 40,
      children: [
        SectionHeader(
          tag: 'CORE PILLARS',
          title: 'Architected for Stability, Built for Growth',
          subtitle:
              'Key engineering foundations that drive every application from prototype to mission-critical production.',
          isDark: isDark,
        ),
        const SizedBox(height: 32),
        LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 700;
            final cardWidth = isWide ? (constraints.maxWidth - 20) / 2 : constraints.maxWidth;
            return Wrap(
              spacing: 20,
              runSpacing: 20,
              children: pillars.map((pillar) {
                return SizedBox(
                  width: cardWidth,
                  child: _PillarCard(pillar: pillar, isDark: isDark),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}

class _PillarItem {
  final String title;
  final String description;
  final IconData icon;
  final String tag;
  final Color color;

  _PillarItem({
    required this.title,
    required this.description,
    required this.icon,
    required this.tag,
    required this.color,
  });
}

/// Now uses the reusable [HoverCard] instead of a custom StatefulWidget.
class _PillarCard extends StatelessWidget {
  final _PillarItem pillar;
  final bool isDark;

  const _PillarCard({
    required this.pillar,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final textPrimary = isDark ? AppTheme.darkTextPrimary : AppTheme.lightTextPrimary;
    final textSecondary = isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary;

    return HoverCard(
      isDark: isDark,
      hoverAccentColor: pillar.color,
      borderRadius: 16,
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
                  color: pillar.color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(pillar.icon, color: pillar.color, size: 22),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: pillar.color.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: pillar.color.withValues(alpha: 0.2),
                  ),
                ),
                child: Text(
                  pillar.tag,
                  style: TextStyle(
                    color: pillar.color,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            pillar.title,
            style: TextStyle(
              color: textPrimary,
              fontWeight: FontWeight.w700,
              fontSize: 17,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            pillar.description,
            style: TextStyle(
              color: textSecondary,
              fontSize: 13.5,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
