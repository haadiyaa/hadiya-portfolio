import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme/app_theme.dart';

class HeroSection extends StatelessWidget {
  final bool isDark;
  final VoidCallback onExploreProjects;
  final VoidCallback onOpenResume;
  final VoidCallback onContactMe;

  const HeroSection({
    super.key,
    required this.isDark,
    required this.onExploreProjects,
    required this.onOpenResume,
    required this.onContactMe,
  });

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _copyEmail(BuildContext context) {
    Clipboard.setData(const ClipboardData(text: 'haadiyact@gmail.com'));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(
              Icons.check_circle_rounded,
              color: AppTheme.accentEmerald,
              size: 20,
            ),
            SizedBox(width: 10),
            Text('Email copied to clipboard: haadiyact@gmail.com'),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: isDark
            ? AppTheme.darkCardHover
            : AppTheme.lightCardHover,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 900;
    final textPrimary = isDark
        ? AppTheme.darkTextPrimary
        : AppTheme.lightTextPrimary;
    final textSecondary = isDark
        ? AppTheme.darkTextSecondary
        : AppTheme.lightTextSecondary;
    final cardBg = isDark ? AppTheme.darkCard : AppTheme.lightCard;
    final border = isDark ? AppTheme.darkBorder : AppTheme.lightBorder;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 60,
        vertical: isMobile ? 40 : 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Availability Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppTheme.accentEmerald.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: AppTheme.accentEmerald.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: AppTheme.accentEmerald,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.accentEmerald.withValues(alpha: 0.6),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  'Available for Flutter & Mobile App Opportunities',
                  style: TextStyle(
                    color: AppTheme.accentEmerald,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),

          // Main Hero Title
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 960),
            child: Column(
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: isMobile ? 36 : 56,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -1.2,
                      height: 1.15,
                      color: textPrimary,
                    ),
                    children: [
                      const TextSpan(text: 'Engineering Scalable '),
                      TextSpan(
                        text: 'Flutter ERPs',
                        style: TextStyle(
                          foreground: Paint()
                            ..shader =
                                const LinearGradient(
                                  colors: [
                                    AppTheme.primaryCyan,
                                    AppTheme.accentIndigo,
                                  ],
                                ).createShader(
                                  const Rect.fromLTWH(0.0, 0.0, 300.0, 70.0),
                                ),
                        ),
                      ),
                      const TextSpan(text: '\n& Cross-Platform Experiences'),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Hi, I'm Haadiya CT — a Flutter Developer with 3+ years of experience engineering production-grade ERP software, offline-first architectures, and responsive applications across Android, iOS, Desktop, and Web.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: textSecondary,
                    fontSize: isMobile ? 16 : 18,
                    height: 1.6,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),

          // Location & Quick Info Chips
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 12,
            runSpacing: 10,
            children: [
              _infoBadge(
                icon: const Icon(
                  Icons.location_on_outlined,
                  size: 14,
                  color: AppTheme.primaryCyan,
                ),
                label: 'Kozhikode, Kerala, India',
                isDark: isDark,
              ),
              InkWell(
                onTap: () => _copyEmail(context),
                borderRadius: BorderRadius.circular(20),
                child: _infoBadge(
                  icon: const Icon(
                    Icons.alternate_email_rounded,
                    size: 14,
                    color: AppTheme.primaryCyan,
                  ),
                  label: 'haadiyact@gmail.com',
                  isDark: isDark,
                  isAction: true,
                ),
              ),
              InkWell(
                onTap: () => _launchUrl(
                  'https://www.linkedin.com/in/haadiya-ct-47775621b/',
                ),
                borderRadius: BorderRadius.circular(20),
                child: _infoBadge(
                  icon: const FaIcon(
                    FontAwesomeIcons.linkedinIn,
                    size: 13,
                    color: AppTheme.primaryCyan,
                  ),
                  label: 'LinkedIn Profile',
                  isDark: isDark,
                  isAction: true,
                ),
              ),
              InkWell(
                onTap: () => _launchUrl('https://github.com/haadiyaa'),
                borderRadius: BorderRadius.circular(20),
                child: _infoBadge(
                  icon: const FaIcon(
                    FontAwesomeIcons.github,
                    size: 13,
                    color: AppTheme.primaryCyan,
                  ),
                  label: 'GitHub',
                  isDark: isDark,
                  isAction: true,
                ),
              ),
            ],
          ),

          const SizedBox(height: 36),

          // Action Buttons
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 16,
            runSpacing: 12,
            children: [
              ElevatedButton.icon(
                onPressed: onExploreProjects,
                icon: const Icon(Icons.rocket_launch_outlined, size: 18),
                label: const Text('Explore Projects'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryCyan,
                  foregroundColor: const Color(0xFF090D16),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 26,
                    vertical: 18,
                  ),
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              OutlinedButton.icon(
                onPressed: onOpenResume,
                icon: const Icon(Icons.file_present_rounded, size: 18),
                label: const Text('View Resume'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: textPrimary,
                  side: BorderSide(color: border, width: 1.5),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 18,
                  ),
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: onContactMe,
                icon: const Icon(Icons.mail_outline_rounded, size: 18),
                label: const Text('Get in Touch'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDark
                      ? AppTheme.darkCardHover
                      : AppTheme.lightCardHover,
                  foregroundColor: textPrimary,
                  side: BorderSide(color: border),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 18,
                  ),
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 56),

          // Quick Highlights / Stat Grid
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1100),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
              decoration: BoxDecoration(
                color: cardBg,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: border),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.04),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: isMobile
                  ? Column(
                      children: [
                        _metricItem(
                          '3+ Years',
                          'Hands-on Experience in Flutter & Cross-Platform',
                          Icons.auto_graph_rounded,
                        ),
                        const Divider(height: 32),
                        _metricItem(
                          'Clean Architecture',
                          'Riverpod, BLoC, Provider & GetX State Models',
                          Icons.architecture_rounded,
                        ),
                        const Divider(height: 32),
                        _metricItem(
                          'Offline-First Sync',
                          'SQLite / SQFlite with Automatic Cloud Sync',
                          Icons.sync_rounded,
                        ),
                        const Divider(height: 32),
                        _metricItem(
                          'Multi-Platform',
                          'Mobile (iOS/Android), Desktop (WPF) & Web',
                          Icons.devices_rounded,
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        Expanded(
                          child: _metricItem(
                            '3+ Years',
                            'Flutter & Cross-Platform Experience',
                            Icons.auto_graph_rounded,
                          ),
                        ),
                        Container(width: 1, height: 48, color: border),
                        Expanded(
                          child: _metricItem(
                            'Clean Architecture',
                            'Riverpod, BLoC & Modular Code',
                            Icons.architecture_rounded,
                          ),
                        ),
                        Container(width: 1, height: 48, color: border),
                        Expanded(
                          child: _metricItem(
                            'Offline-First',
                            'SQLite & Automatic Server Sync',
                            Icons.sync_rounded,
                          ),
                        ),
                        Container(width: 1, height: 48, color: border),
                        Expanded(
                          child: _metricItem(
                            'Cross-Platform',
                            'Mobile, Desktop & Web Ecosystems',
                            Icons.devices_rounded,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoBadge({
    required Widget icon,
    required String label,
    required bool isDark,
    bool isAction = false,
  }) {
    final cardBg = isDark ? AppTheme.darkCard : AppTheme.lightCard;
    final border = isDark ? AppTheme.darkBorder : AppTheme.lightBorder;
    final textSecondary = isDark
        ? AppTheme.darkTextSecondary
        : AppTheme.lightTextSecondary;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (isAction) ...[
            const SizedBox(width: 6),
            Icon(Icons.arrow_outward_rounded, size: 12, color: textSecondary),
          ],
        ],
      ),
    );
  }

  Widget _metricItem(String value, String label, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          Icon(icon, color: AppTheme.primaryCyan, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 18,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppTheme.darkTextMuted,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
