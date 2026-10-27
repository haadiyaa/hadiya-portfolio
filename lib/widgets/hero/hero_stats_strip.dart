import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../effects/spotlight_card.dart';

/// Floating stats and metrics ribbon for the Hero section.
class HeroStatsStrip extends StatelessWidget {
  final bool isDark;

  const HeroStatsStrip({super.key, required this.isDark});

  static const _stats = [
    _StatData(
      value: '3+ Years',
      label: 'Flutter & Dart',
      sublabel: 'Cross-Platform Dev',
      icon: Icons.trending_up_rounded,
      color: AppTheme.primaryCyan,
    ),
    _StatData(
      value: 'Offline-First',
      label: 'SQLite & SQFlite',
      sublabel: 'Automatic Cloud Sync',
      icon: Icons.cloud_sync_rounded,
      color: AppTheme.accentEmerald,
    ),
    _StatData(
      value: 'Clean Arch',
      label: 'Riverpod & BLoC',
      sublabel: 'Decoupled State',
      icon: Icons.account_tree_rounded,
      color: AppTheme.accentIndigo,
    ),
    _StatData(
      value: 'Multi-OS',
      label: 'iOS • Android • WPF',
      sublabel: 'Desktop & Web',
      icon: Icons.devices_rounded,
      color: AppTheme.accentAmber,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final textPrimary = isDark ? AppTheme.darkTextPrimary : AppTheme.lightTextPrimary;
    final textSecondary = isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 750;
        final itemWidth = isMobile
            ? (constraints.maxWidth - 12) / 2
            : (constraints.maxWidth - 36) / 4;

        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: _stats.map((stat) {
            return SizedBox(
              width: itemWidth,
              child: SpotlightCard(
                isDark: isDark,
                glowColor: stat.color,
                borderRadius: 16,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                builder: (_) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: stat.color.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(stat.icon, color: stat.color, size: 20),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      stat.value,
                      style: TextStyle(
                        color: textPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.4,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      stat.label,
                      style: TextStyle(
                        color: textPrimary,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      stat.sublabel,
                      style: TextStyle(
                        color: textSecondary,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class _StatData {
  final String value;
  final String label;
  final String sublabel;
  final IconData icon;
  final Color color;

  const _StatData({
    required this.value,
    required this.label,
    required this.sublabel,
    required this.icon,
    required this.color,
  });
}
