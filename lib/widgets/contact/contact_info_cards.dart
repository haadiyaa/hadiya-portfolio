import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../theme/app_theme.dart';
import '../effects/spotlight_card.dart';

/// Left-hand info cards for the Contact section.
class ContactInfoCards extends StatelessWidget {
  final bool isDark;

  const ContactInfoCards({super.key, required this.isDark});

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
    final textPrimary = isDark ? AppTheme.darkTextPrimary : AppTheme.lightTextPrimary;
    final textSecondary = isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary;

    return Column(
      children: [
        _card(
          icon: const Icon(Icons.alternate_email_rounded, color: AppTheme.primaryCyan, size: 20),
          title: 'Direct Email',
          value: 'haadiyact@gmail.com',
          action: 'Click to Copy',
          onTap: () => _copyEmail(context),
          textPrimary: textPrimary,
          textSecondary: textSecondary,
        ),
        const SizedBox(height: 16),
        _card(
          icon: const Icon(Icons.location_on_outlined, color: AppTheme.primaryCyan, size: 20),
          title: 'Location',
          value: 'Kozhikode, Kerala, India',
          action: 'Remote & Relocation',
          onTap: () {},
          textPrimary: textPrimary,
          textSecondary: textSecondary,
        ),
        const SizedBox(height: 16),
        _card(
          icon: const FaIcon(FontAwesomeIcons.linkedinIn, color: AppTheme.primaryCyan, size: 18),
          title: 'LinkedIn',
          value: 'linkedin.com/in/haadiya-ct',
          action: 'Visit Profile',
          onTap: () => _launchUrl('https://www.linkedin.com/in/haadiya-ct-47775621b/'),
          textPrimary: textPrimary,
          textSecondary: textSecondary,
        ),
      ],
    );
  }

  Widget _card({
    required Widget icon,
    required String title,
    required String value,
    required String action,
    required VoidCallback onTap,
    required Color textPrimary,
    required Color textSecondary,
  }) {
    return SpotlightCard(
      isDark: isDark,
      glowColor: AppTheme.primaryCyan,
      borderRadius: 16,
      padding: const EdgeInsets.all(20),
      onTap: onTap,
      builder: (_) => Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.primaryCyan.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: icon,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: textSecondary, fontSize: 12, fontWeight: FontWeight.w500)),
                const SizedBox(height: 2),
                Text(value, style: TextStyle(color: textPrimary, fontSize: 15, fontWeight: FontWeight.w700)),
              ],
            ),
          ),
          Text(action, style: const TextStyle(color: AppTheme.primaryCyan, fontSize: 11, fontWeight: FontWeight.w600)),
          const SizedBox(width: 4),
          const Icon(Icons.arrow_forward_ios_rounded, size: 10, color: AppTheme.primaryCyan),
        ],
      ),
    );
  }
}
