import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

/// Desktop action buttons: Resume, animated theme toggle, and Contact CTA.
class NavActionButtons extends StatelessWidget {
  final bool isDark;
  final VoidCallback onToggleTheme;
  final VoidCallback onOpenResume;
  final VoidCallback onOpenContact;

  const NavActionButtons({
    super.key,
    required this.isDark,
    required this.onToggleTheme,
    required this.onOpenResume,
    required this.onOpenContact,
  });

  @override
  Widget build(BuildContext context) {
    final textPrimary = isDark ? AppTheme.darkTextPrimary : AppTheme.lightTextPrimary;
    final borderColor = isDark ? AppTheme.darkBorder : AppTheme.lightBorder;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Resume Button
        OutlinedButton.icon(
          onPressed: onOpenResume,
          icon: const Icon(Icons.description_outlined, size: 15),
          label: const Text('Resume'),
          style: OutlinedButton.styleFrom(
            foregroundColor: textPrimary,
            side: BorderSide(color: borderColor),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        const SizedBox(width: 12),

        // Theme Toggle with rotation
        IconButton(
          onPressed: onToggleTheme,
          tooltip: isDark ? 'Switch to Light Mode' : 'Switch to Dark Mode',
          icon: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            transitionBuilder: (child, anim) => RotationTransition(turns: anim, child: child),
            child: Icon(
              isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
              key: ValueKey(isDark),
              color: isDark ? AppTheme.accentAmber : textPrimary,
              size: 20,
            ),
          ),
        ),
        const SizedBox(width: 8),

        // Contact CTA Button
        ElevatedButton(
          onPressed: onOpenContact,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primaryCyan,
            foregroundColor: const Color(0xFF090D16),
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Let's Talk", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
              SizedBox(width: 6),
              Icon(Icons.arrow_forward_rounded, size: 15),
            ],
          ),
        ),
      ],
    );
  }
}
