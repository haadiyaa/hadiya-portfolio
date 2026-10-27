import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../theme/app_theme.dart';
import 'hero_badge.dart';

/// Left-hand narrative content for the Hero section.
class HeroTextContent extends HookWidget {
  final bool isDark;
  final VoidCallback onExploreProjects;
  final VoidCallback onOpenResume;
  final VoidCallback onContactMe;

  const HeroTextContent({
    super.key,
    required this.isDark,
    required this.onExploreProjects,
    required this.onOpenResume,
    required this.onContactMe,
  });

  static const _roles = [
    'Flutter Engineer',
    'ERP Systems Architect',
    'Offline-First Specialist',
    'Cross-Platform Builder',
  ];

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
            Icon(Icons.check_circle_rounded, color: AppTheme.accentEmerald, size: 20),
            SizedBox(width: 10),
            Text('Copied: haadiyact@gmail.com'),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: isDark ? AppTheme.darkCardHover : AppTheme.lightCardHover,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;
    final textPrimary = isDark ? AppTheme.darkTextPrimary : AppTheme.lightTextPrimary;
    final textSecondary = isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary;

    final roleIndex = useState(0);

    useEffect(() {
      final timer = Timer.periodic(const Duration(seconds: 3), (t) {
        roleIndex.value = (roleIndex.value + 1) % _roles.length;
      });
      return timer.cancel;
    }, const []);

    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        const HeroBadge(),
        const SizedBox(height: 24),

        // Main Title
        RichText(
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          text: TextSpan(
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: isMobile ? 36 : 52,
              fontWeight: FontWeight.w800,
              letterSpacing: -1.2,
              height: 1.15,
              color: textPrimary,
            ),
            children: [
              const TextSpan(text: 'Building High-Performance\n'),
              WidgetSpan(
                alignment: PlaceholderAlignment.baseline,
                baseline: TextBaseline.alphabetic,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 0.4),
                        end: Offset.zero,
                      ).animate(animation),
                      child: FadeTransition(opacity: animation, child: child),
                    );
                  },
                  child: ShaderMask(
                    key: ValueKey(roleIndex.value),
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [AppTheme.primaryCyan, AppTheme.accentIndigo],
                    ).createShader(bounds),
                    child: Text(
                      _roles[roleIndex.value],
                      style: TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        fontSize: isMobile ? 36 : 52,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -1.2,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const TextSpan(text: '\nfor Enterprise & Scale'),
            ],
          ),
        ),

        const SizedBox(height: 18),

        // Subtitle Narrative
        Text(
          "Hi, I'm Haadiya CT — an experienced Flutter developer engineering mission-critical ERP solutions, offline-first sync engines, and seamless cross-platform apps across iOS, Android, Desktop, and Web.",
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: TextStyle(
            color: textSecondary,
            fontSize: isMobile ? 15.5 : 17,
            height: 1.6,
          ),
        ),

        const SizedBox(height: 24),

        // Social & Info Chips
        Wrap(
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          spacing: 10,
          runSpacing: 10,
          children: [
            _chip(
              icon: const Icon(Icons.location_on_outlined, size: 14, color: AppTheme.primaryCyan),
              label: 'Kozhikode, India',
            ),
            InkWell(
              onTap: () => _copyEmail(context),
              borderRadius: BorderRadius.circular(20),
              child: _chip(
                icon: const Icon(Icons.alternate_email_rounded, size: 14, color: AppTheme.primaryCyan),
                label: 'haadiyact@gmail.com',
                isAction: true,
              ),
            ),
            InkWell(
              onTap: () => _launchUrl('https://github.com/haadiyaa'),
              borderRadius: BorderRadius.circular(20),
              child: _chip(
                icon: const FaIcon(FontAwesomeIcons.github, size: 13, color: AppTheme.primaryCyan),
                label: 'GitHub',
                isAction: true,
              ),
            ),
            InkWell(
              onTap: () => _launchUrl('https://www.linkedin.com/in/haadiya-ct-47775621b/'),
              borderRadius: BorderRadius.circular(20),
              child: _chip(
                icon: const FaIcon(FontAwesomeIcons.linkedinIn, size: 13, color: AppTheme.primaryCyan),
                label: 'LinkedIn',
                isAction: true,
              ),
            ),
          ],
        ),

        const SizedBox(height: 32),

        // Buttons
        Wrap(
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          spacing: 14,
          runSpacing: 12,
          children: [
            ElevatedButton.icon(
              onPressed: onExploreProjects,
              icon: const Icon(Icons.rocket_launch_outlined, size: 17),
              label: const Text('Explore Projects'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryCyan,
                foregroundColor: const Color(0xFF090D16),
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14.5),
              ),
            ),
            OutlinedButton.icon(
              onPressed: onOpenResume,
              icon: const Icon(Icons.file_present_rounded, size: 17),
              label: const Text('View Resume'),
              style: OutlinedButton.styleFrom(
                foregroundColor: textPrimary,
                side: BorderSide(
                  color: isDark ? AppTheme.darkBorder : AppTheme.lightBorder,
                  width: 1.5,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14.5),
              ),
            ),
            ElevatedButton.icon(
              onPressed: onContactMe,
              icon: const Icon(Icons.mail_outline_rounded, size: 17),
              label: const Text("Let's Talk"),
              style: ElevatedButton.styleFrom(
                backgroundColor: isDark ? AppTheme.darkCardHover : AppTheme.lightCardHover,
                foregroundColor: textPrimary,
                elevation: 0,
                side: BorderSide(color: isDark ? AppTheme.darkBorder : AppTheme.lightBorder),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14.5),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _chip({required Widget icon, required String label, bool isAction = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isDark ? AppTheme.darkBorder : AppTheme.lightBorder),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          const SizedBox(width: 7),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.5,
              color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (isAction) ...[
            const SizedBox(width: 4),
            Icon(Icons.arrow_outward_rounded, size: 11, color: isDark ? AppTheme.darkTextMuted : AppTheme.lightTextMuted),
          ],
        ],
      ),
    );
  }
}
