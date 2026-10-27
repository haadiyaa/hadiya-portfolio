import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../theme/app_theme.dart';
import '../effects/spotlight_card.dart';

/// Interactive message drafting card with quick topic selection pills.
class ContactFormCard extends HookWidget {
  final bool isDark;

  const ContactFormCard({super.key, required this.isDark});

  static const _presets = [
    '💼 Full-Time Role',
    '⚡ ERP Project',
    '☕ Quick Discussion',
  ];

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController();
    final emailController = useTextEditingController();
    final messageController = useTextEditingController();

    final textPrimary = isDark ? AppTheme.darkTextPrimary : AppTheme.lightTextPrimary;
    final textSecondary = isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary;

    void sendDirectEmail() {
      final name = nameController.text.trim();
      final message = messageController.text.trim();
      final subject = Uri.encodeComponent('Inquiry from ${name.isEmpty ? 'Portfolio Visitor' : name}');
      final body = Uri.encodeComponent(
        'Hi Haadiya,\n\n$message\n\nBest regards,\n$name\n${emailController.text.trim()}',
      );
      final mailtoUri = Uri.parse('mailto:haadiyact@gmail.com?subject=$subject&body=$body');
      launchUrl(mailtoUri);
    }

    void applyPreset(String preset) {
      if (preset.contains('Role')) {
        messageController.text = "Hi Haadiya, I came across your portfolio and would like to discuss a Flutter Developer opportunity on our team.";
      } else if (preset.contains('ERP')) {
        messageController.text = "Hi Haadiya, we're building a multi-module enterprise system and would like to consult on offline-first architecture.";
      } else {
        messageController.text = "Hi Haadiya, let's connect and discuss Flutter cross-platform development!";
      }
    }

    return SpotlightCard(
      isDark: isDark,
      glowColor: AppTheme.primaryCyan,
      borderRadius: 20,
      padding: const EdgeInsets.all(28),
      builder: (_) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Send a Quick Message',
            style: TextStyle(color: textPrimary, fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          Text(
            'Select a preset topic or write your note below:',
            style: TextStyle(color: textSecondary, fontSize: 13),
          ),
          const SizedBox(height: 14),

          // Preset Chips
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _presets.map((preset) {
              return InkWell(
                onTap: () => applyPreset(preset),
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.black.withValues(alpha: 0.04),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppTheme.primaryCyan.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Text(
                    preset,
                    style: const TextStyle(
                      color: AppTheme.primaryCyan,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 20),
          _input(nameController, 'Your Name or Company', Icons.person_outline_rounded, 1),
          const SizedBox(height: 14),
          _input(emailController, 'Your Email Address', Icons.mail_outline_rounded, 1),
          const SizedBox(height: 14),
          _input(messageController, 'Tell me about your project, team, or opportunity...', Icons.chat_bubble_outline_rounded, 4),
          const SizedBox(height: 22),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: sendDirectEmail,
              icon: const Icon(Icons.send_rounded, size: 16),
              label: const Text('Send Message via Email'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryCyan,
                foregroundColor: const Color(0xFF090D16),
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                textStyle: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _input(TextEditingController c, String hint, IconData icon, int maxLines) {
    final border = isDark ? AppTheme.darkBorder : AppTheme.lightBorder;
    final fill = isDark ? AppTheme.darkBg : AppTheme.lightCardHover;
    final textPrimary = isDark ? AppTheme.darkTextPrimary : AppTheme.lightTextPrimary;

    return TextField(
      controller: c,
      maxLines: maxLines,
      style: TextStyle(color: textPrimary, fontSize: 13.5),
      decoration: InputDecoration(
        filled: true,
        fillColor: fill,
        prefixIcon: maxLines == 1 ? Icon(icon, size: 18, color: AppTheme.primaryCyan) : null,
        hintText: hint,
        hintStyle: const TextStyle(color: AppTheme.darkTextMuted, fontSize: 13),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
