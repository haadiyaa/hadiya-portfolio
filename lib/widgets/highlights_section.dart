import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class HighlightsSection extends StatelessWidget {
  final bool isDark;

  const HighlightsSection({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 900;
    final textPrimary = isDark ? AppTheme.darkTextPrimary : AppTheme.lightTextPrimary;
    final textSecondary = isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary;

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

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 60,
        vertical: 40,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
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
                    'CORE PILLARS',
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
                'Architected for Stability, Built for Growth',
                style: TextStyle(
                  color: textPrimary,
                  fontSize: isMobile ? 26 : 34,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.8,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Key engineering foundations that drive every application from prototype to mission-critical production.',
                style: TextStyle(
                  color: textSecondary,
                  fontSize: 15,
                ),
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
                        child: _PillarCard(
                          pillar: pillar,
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

class _PillarCard extends StatefulWidget {
  final _PillarItem pillar;
  final bool isDark;

  const _PillarCard({
    required this.pillar,
    required this.isDark,
  });

  @override
  State<_PillarCard> createState() => _PillarCardState();
}

class _PillarCardState extends State<_PillarCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final cardBg = widget.isDark ? AppTheme.darkCard : AppTheme.lightCard;
    final cardHoverBg = widget.isDark ? AppTheme.darkCardHover : AppTheme.lightCardHover;
    final border = widget.isDark ? AppTheme.darkBorder : AppTheme.lightBorder;
    final textPrimary = widget.isDark ? AppTheme.darkTextPrimary : AppTheme.lightTextPrimary;
    final textSecondary = widget.isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary;

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isHovered ? cardHoverBg : cardBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isHovered ? widget.pillar.color.withValues(alpha: 0.5) : border,
            width: 1,
          ),
          boxShadow: isHovered
              ? [
                  BoxShadow(
                    color: widget.pillar.color.withValues(alpha: 0.12),
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
                    color: widget.pillar.color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(widget.pillar.icon, color: widget.pillar.color, size: 22),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: widget.pillar.color.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: widget.pillar.color.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Text(
                    widget.pillar.tag,
                    style: TextStyle(
                      color: widget.pillar.color,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              widget.pillar.title,
              style: TextStyle(
                color: textPrimary,
                fontWeight: FontWeight.w700,
                fontSize: 17,
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.pillar.description,
              style: TextStyle(
                color: textSecondary,
                fontSize: 13.5,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
