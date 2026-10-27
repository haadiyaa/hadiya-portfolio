import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

/// Bottom modal navigation sheet for mobile viewports.
class MobileNavDrawer extends StatelessWidget {
  final bool isDark;
  final Function(int sectionIndex) onNavigateToSection;
  final VoidCallback onOpenResume;
  final VoidCallback onOpenContact;

  const MobileNavDrawer({
    super.key,
    required this.isDark,
    required this.onNavigateToSection,
    required this.onOpenResume,
    required this.onOpenContact,
  });

  static void show(
    BuildContext context, {
    required bool isDark,
    required Function(int) onNavigateToSection,
    required VoidCallback onOpenResume,
    required VoidCallback onOpenContact,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => MobileNavDrawer(
        isDark: isDark,
        onNavigateToSection: onNavigateToSection,
        onOpenResume: onOpenResume,
        onOpenContact: onOpenContact,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textColor = isDark ? AppTheme.darkTextPrimary : AppTheme.lightTextPrimary;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: Border.all(color: isDark ? AppTheme.darkBorder : AppTheme.lightBorder),
      ),
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: isDark ? Colors.white24 : Colors.black12,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 20),
          _item(context, 'About & Highlights', Icons.person_outline_rounded, 0, textColor),
          _item(context, 'Work Experience', Icons.work_outline_rounded, 1, textColor),
          _item(context, 'Featured Projects', Icons.layers_outlined, 2, textColor),
          _item(context, 'Technical Skills', Icons.code_rounded, 3, textColor),
          _item(context, 'Education', Icons.school_outlined, 4, textColor),
          _item(context, 'Get in Touch', Icons.mail_outline_rounded, 5, textColor),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    onOpenResume();
                  },
                  icon: const Icon(Icons.description_outlined, size: 16),
                  label: const Text('Resume'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    onOpenContact();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryCyan,
                    foregroundColor: const Color(0xFF090D16),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("Let's Talk", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _item(BuildContext context, String title, IconData icon, int index, Color textColor) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.primaryCyan, size: 20),
      title: Text(title, style: TextStyle(color: textColor, fontWeight: FontWeight.w600, fontSize: 15)),
      onTap: () {
        Navigator.pop(context);
        onNavigateToSection(index);
      },
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
    );
  }
}
