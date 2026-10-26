import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme/app_theme.dart';
import 'shared_widgets.dart';

class ContactSection extends HookWidget {
  final bool isDark;

  const ContactSection({super.key, required this.isDark});

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
            Text('Copied: haadiyact@gmail.com'),
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
    final nameController = useTextEditingController();
    final emailController = useTextEditingController();
    final messageController = useTextEditingController();

    final cardBg = isDark ? AppTheme.darkCard : AppTheme.lightCard;
    final border = isDark ? AppTheme.darkBorder : AppTheme.lightBorder;
    final textPrimary = isDark ? AppTheme.darkTextPrimary : AppTheme.lightTextPrimary;
    final textSecondary = isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary;

    void sendDirectEmail() {
      final name = nameController.text.trim();
      final message = messageController.text.trim();

      final subject = Uri.encodeComponent('Project Inquiry from $name');
      final body = Uri.encodeComponent(
        'Hi Haadiya,\n\n$message\n\nBest regards,\n$name\n${emailController.text.trim()}',
      );

      final mailtoUri = Uri.parse(
        'mailto:haadiyact@gmail.com?subject=$subject&body=$body',
      );
      launchUrl(mailtoUri);
    }

    return SectionContainer(
      children: [
        SectionHeader(
          tag: 'GET IN TOUCH',
          title: "Let's Build Something Exceptional Together",
          subtitle:
              'Available for Flutter Developer roles, enterprise cross-platform contracts, and technical discussions.',
          isDark: isDark,
        ),
        const SizedBox(height: 36),

        LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 800;
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Contact info left column
                Expanded(
                  flex: isWide ? 4 : 1,
                  child: Column(
                    children: [
                      _ContactCard(
                        icon: const Icon(
                          Icons.alternate_email_rounded,
                          color: AppTheme.primaryCyan,
                          size: 20,
                        ),
                        title: 'Email Directly',
                        value: 'haadiyact@gmail.com',
                        actionLabel: 'Click to copy',
                        onTap: () => _copyEmail(context),
                        isDark: isDark,
                      ),
                      const SizedBox(height: 16),
                      _ContactCard(
                        icon: const Icon(
                          Icons.location_on_outlined,
                          color: AppTheme.primaryCyan,
                          size: 20,
                        ),
                        title: 'Location',
                        value: 'Kozhikode, Kerala, India',
                        actionLabel: 'Open to Remote / On-site',
                        onTap: () {},
                        isDark: isDark,
                      ),
                      const SizedBox(height: 16),
                      _ContactCard(
                        icon: const FaIcon(
                          FontAwesomeIcons.linkedinIn,
                          color: AppTheme.primaryCyan,
                          size: 18,
                        ),
                        title: 'LinkedIn',
                        value: 'Connect with Haadiya CT',
                        actionLabel: 'Visit Profile',
                        onTap: () => _launchUrl(
                          'https://www.linkedin.com/in/haadiya-ct-47775621b/',
                        ),
                        isDark: isDark,
                      ),
                    ],
                  ),
                ),

                if (isWide) const SizedBox(width: 32),

                // Direct message interactive simulator
                if (isWide)
                  Expanded(
                    flex: 5,
                    child: Container(
                      padding: const EdgeInsets.all(28),
                      decoration: BoxDecoration(
                        color: cardBg,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Send a Quick Message',
                            style: TextStyle(
                              color: textPrimary,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Draft a note below to open your email client pre-filled:',
                            style: TextStyle(
                              color: textSecondary,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 20),
                          _InputField(
                            controller: nameController,
                            hint: 'Your Name or Company',
                            icon: Icons.person_outline_rounded,
                            isDark: isDark,
                          ),
                          const SizedBox(height: 14),
                          _InputField(
                            controller: emailController,
                            hint: 'Your Email Address',
                            icon: Icons.mail_outline_rounded,
                            isDark: isDark,
                          ),
                          const SizedBox(height: 14),
                          _InputField(
                            controller: messageController,
                            hint: 'Tell me about your project, team, or opportunity...',
                            icon: Icons.chat_bubble_outline_rounded,
                            maxLines: 4,
                            isDark: isDark,
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: sendDirectEmail,
                              icon: const Icon(
                                Icons.send_rounded,
                                size: 16,
                              ),
                              label: const Text('Send Message via Email'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.primaryCyan,
                                foregroundColor: const Color(0xFF090D16),
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}

/// Extracted reusable contact info card (was a private method).
class _ContactCard extends StatelessWidget {
  final Widget icon;
  final String title;
  final String value;
  final String actionLabel;
  final VoidCallback onTap;
  final bool isDark;

  const _ContactCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.actionLabel,
    required this.onTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final cardBg = isDark ? AppTheme.darkCard : AppTheme.lightCard;
    final border = isDark ? AppTheme.darkBorder : AppTheme.lightBorder;
    final textPrimary = isDark ? AppTheme.darkTextPrimary : AppTheme.lightTextPrimary;
    final textSecondary = isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: border),
        ),
        child: Row(
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
                  Text(
                    title,
                    style: TextStyle(
                      color: textSecondary,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: TextStyle(
                      color: textPrimary,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              actionLabel,
              style: const TextStyle(
                color: AppTheme.primaryCyan,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 10,
              color: AppTheme.primaryCyan,
            ),
          ],
        ),
      ),
    );
  }
}

/// Extracted reusable input field (was a private method).
class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final int maxLines;
  final bool isDark;

  const _InputField({
    required this.controller,
    required this.hint,
    required this.icon,
    this.maxLines = 1,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final border = isDark ? AppTheme.darkBorder : AppTheme.lightBorder;
    final fill = isDark ? AppTheme.darkBg : AppTheme.lightCardHover;
    final textPrimary = isDark ? AppTheme.darkTextPrimary : AppTheme.lightTextPrimary;

    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: TextStyle(color: textPrimary, fontSize: 13.5),
      decoration: InputDecoration(
        filled: true,
        fillColor: fill,
        prefixIcon: maxLines == 1
            ? Icon(icon, size: 18, color: AppTheme.primaryCyan)
            : null,
        hintText: hint,
        hintStyle: const TextStyle(color: AppTheme.darkTextMuted, fontSize: 13),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppTheme.primaryCyan),
        ),
      ),
    );
  }
}
