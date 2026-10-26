import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme/app_theme.dart';

class ContactSection extends StatefulWidget {
  final bool isDark;

  const ContactSection({super.key, required this.isDark});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _copyEmail() {
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
        backgroundColor: widget.isDark
            ? AppTheme.darkCardHover
            : AppTheme.lightCardHover,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _sendDirectEmail() {
    final name = _nameController.text.trim();
    final message = _messageController.text.trim();

    final subject = Uri.encodeComponent('Project Inquiry from $name');
    final body = Uri.encodeComponent(
      'Hi Haadiya,\n\n$message\n\nBest regards,\n$name\n${_emailController.text.trim()}',
    );

    final mailtoUri = Uri.parse(
      'mailto:haadiyact@gmail.com?subject=$subject&body=$body',
    );
    launchUrl(mailtoUri);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 900;
    final textPrimary = widget.isDark
        ? AppTheme.darkTextPrimary
        : AppTheme.lightTextPrimary;
    final textSecondary = widget.isDark
        ? AppTheme.darkTextSecondary
        : AppTheme.lightTextSecondary;
    final cardBg = widget.isDark ? AppTheme.darkCard : AppTheme.lightCard;
    final border = widget.isDark ? AppTheme.darkBorder : AppTheme.lightBorder;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 60,
        vertical: 60,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Tag
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
                  const Text(
                    'GET IN TOUCH',
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
                "Let's Build Something Exceptional Together",
                style: TextStyle(
                  color: textPrimary,
                  fontSize: isMobile ? 26 : 34,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.8,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Available for Flutter Developer roles, enterprise cross-platform contracts, and technical discussions.',
                style: TextStyle(color: textSecondary, fontSize: 15),
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
                            _contactCard(
                              icon: const Icon(
                                Icons.alternate_email_rounded,
                                color: AppTheme.primaryCyan,
                                size: 20,
                              ),
                              title: 'Email Directly',
                              value: 'haadiyact@gmail.com',
                              actionLabel: 'Click to copy',
                              onTap: _copyEmail,
                              isDark: widget.isDark,
                            ),
                            const SizedBox(height: 16),
                            _contactCard(
                              icon: const Icon(
                                Icons.location_on_outlined,
                                color: AppTheme.primaryCyan,
                                size: 20,
                              ),
                              title: 'Location',
                              value: 'Kozhikode, Kerala, India',
                              actionLabel: 'Open to Remote / On-site',
                              onTap: () {},
                              isDark: widget.isDark,
                            ),
                            const SizedBox(height: 16),
                            _contactCard(
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
                              isDark: widget.isDark,
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
                                _inputField(
                                  controller: _nameController,
                                  hint: 'Your Name or Company',
                                  icon: Icons.person_outline_rounded,
                                ),
                                const SizedBox(height: 14),
                                _inputField(
                                  controller: _emailController,
                                  hint: 'Your Email Address',
                                  icon: Icons.mail_outline_rounded,
                                ),
                                const SizedBox(height: 14),
                                _inputField(
                                  controller: _messageController,
                                  hint: 'Tell me about your project, team, or opportunity...',
                                  icon: Icons.chat_bubble_outline_rounded,
                                  maxLines: 4,
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton.icon(
                                    onPressed: _sendDirectEmail,
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
          ),
        ),
      ),
    );
  }

  Widget _contactCard({
    required Widget icon,
    required String title,
    required String value,
    required String actionLabel,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    final cardBg = isDark ? AppTheme.darkCard : AppTheme.lightCard;
    final border = isDark ? AppTheme.darkBorder : AppTheme.lightBorder;
    final textPrimary = isDark
        ? AppTheme.darkTextPrimary
        : AppTheme.lightTextPrimary;
    final textSecondary = isDark
        ? AppTheme.darkTextSecondary
        : AppTheme.lightTextSecondary;

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

  Widget _inputField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    int maxLines = 1,
  }) {
    final border = widget.isDark ? AppTheme.darkBorder : AppTheme.lightBorder;
    final fill = widget.isDark ? AppTheme.darkBg : AppTheme.lightCardHover;
    final textPrimary = widget.isDark
        ? AppTheme.darkTextPrimary
        : AppTheme.lightTextPrimary;

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
