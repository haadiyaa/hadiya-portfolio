import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme/app_theme.dart';

class FooterSection extends StatelessWidget {
  final bool isDark;
  final VoidCallback onScrollToTop;

  const FooterSection({
    super.key,
    required this.isDark,
    required this.onScrollToTop,
  });

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final border = isDark ? AppTheme.darkBorder : AppTheme.lightBorder;
    final textSecondary = isDark
        ? AppTheme.darkTextSecondary
        : AppTheme.lightTextSecondary;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 36),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.darkBg : AppTheme.lightCard,
        border: Border(top: BorderSide(color: border)),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Brand & details
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              AppTheme.primaryCyan,
                              AppTheme.accentIndigo,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'H.',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Haadiya CT • Flutter Developer',
                        style: TextStyle(
                          color: isDark
                              ? AppTheme.darkTextPrimary
                              : AppTheme.lightTextPrimary,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),

                  // Back to Top button
                  IconButton(
                    onPressed: onScrollToTop,
                    tooltip: 'Back to Top',
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: isDark
                            ? AppTheme.darkCardHover
                            : AppTheme.lightCardHover,
                        shape: BoxShape.circle,
                        border: Border.all(color: border),
                      ),
                      child: const Icon(
                        Icons.arrow_upward_rounded,
                        size: 16,
                        color: AppTheme.primaryCyan,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Divider(height: 1),
              const SizedBox(height: 20),
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 16,
                runSpacing: 12,
                children: [
                  Text(
                    'Built with Flutter Web • Clean Code & Architecture',
                    style: TextStyle(color: textSecondary, fontSize: 12.5),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () => _launchUrl(
                          'https://www.linkedin.com/in/haadiya-ct-47775621b/',
                        ),
                        icon: const FaIcon(
                          FontAwesomeIcons.linkedinIn,
                          size: 15,
                        ),
                        color: textSecondary,
                      ),
                      IconButton(
                        onPressed: () =>
                            _launchUrl('https://github.com/haadiyaa'),
                        icon: const FaIcon(FontAwesomeIcons.github, size: 15),
                        color: textSecondary,
                      ),
                      IconButton(
                        onPressed: () =>
                            _launchUrl('mailto:haadiyact@gmail.com'),
                        icon: const Icon(Icons.mail_outline_rounded, size: 17),
                        color: textSecondary,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
