import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../theme/app_theme.dart';

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isDark;
  final VoidCallback onToggleTheme;
  final Function(int sectionIndex) onNavigateToSection;
  final VoidCallback onOpenResume;
  final VoidCallback onOpenContact;

  const NavBar({
    super.key,
    required this.isDark,
    required this.onToggleTheme,
    required this.onNavigateToSection,
    required this.onOpenResume,
    required this.onOpenContact,
  });

  @override
  Size get preferredSize => const Size.fromHeight(72);

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;
    final cardColor = isDark ? AppTheme.darkCard.withValues(alpha: 0.85) : Colors.white.withValues(alpha: 0.85);
    final borderColor = isDark ? AppTheme.darkBorder : AppTheme.lightBorder;
    final textPrimary = isDark ? AppTheme.darkTextPrimary : AppTheme.lightTextPrimary;

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          height: 72,
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 40),
          decoration: BoxDecoration(
            color: cardColor,
            border: Border(
              bottom: BorderSide(color: borderColor, width: 1),
            ),
          ),
          child: Row(
            children: [
              // Brand Monogram
              InkWell(
                onTap: () => onNavigateToSection(0),
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [AppTheme.primaryCyan, AppTheme.accentIndigo],
                          ),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.primaryCyan.withValues(alpha: 0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Text(
                          'H.',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Haadiya CT',
                        style: TextStyle(
                          color: textPrimary,
                          fontWeight: FontWeight.w700,
                          fontSize: 17,
                          letterSpacing: -0.3,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: AppTheme.accentEmerald,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const Spacer(),

              // Desktop Menu
              if (!isMobile) ...[
                _NavItem(title: 'About', onTap: () => onNavigateToSection(0), isDark: isDark),
                _NavItem(title: 'Experience', onTap: () => onNavigateToSection(1), isDark: isDark),
                _NavItem(title: 'Projects', onTap: () => onNavigateToSection(2), isDark: isDark),
                _NavItem(title: 'Skills', onTap: () => onNavigateToSection(3), isDark: isDark),
                _NavItem(title: 'Education', onTap: () => onNavigateToSection(4), isDark: isDark),
                _NavItem(title: 'Contact', onTap: () => onNavigateToSection(5), isDark: isDark),
                const SizedBox(width: 12),
                // Resume Button
                OutlinedButton.icon(
                  onPressed: onOpenResume,
                  icon: const Icon(Icons.description_outlined, size: 16),
                  label: const Text('Resume'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: textPrimary,
                    side: BorderSide(color: borderColor),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Theme Toggle
                IconButton(
                  onPressed: onToggleTheme,
                  tooltip: isDark ? 'Switch to Light Mode' : 'Switch to Dark Mode',
                  icon: Icon(
                    isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
                    color: isDark ? AppTheme.accentAmber : textPrimary,
                    size: 20,
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Let's Talk",
                        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                      ),
                      SizedBox(width: 6),
                      Icon(Icons.arrow_forward_rounded, size: 15),
                    ],
                  ),
                ),
              ],

              // Mobile Menu Button
              if (isMobile) ...[
                IconButton(
                  onPressed: onToggleTheme,
                  icon: Icon(
                    isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
                    color: isDark ? AppTheme.accentAmber : textPrimary,
                    size: 20,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.menu_rounded, color: textPrimary),
                  onPressed: () => _showMobileMenu(context),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            border: Border.all(
              color: isDark ? AppTheme.darkBorder : AppTheme.lightBorder,
            ),
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
              _mobileItem(context, 'About & Highlights', Icons.person_outline_rounded, () {
                Navigator.pop(context);
                onNavigateToSection(0);
              }),
              _mobileItem(context, 'Work Experience', Icons.work_outline_rounded, () {
                Navigator.pop(context);
                onNavigateToSection(1);
              }),
              _mobileItem(context, 'Featured Projects', Icons.layers_outlined, () {
                Navigator.pop(context);
                onNavigateToSection(2);
              }),
              _mobileItem(context, 'Technical Skills', Icons.code_rounded, () {
                Navigator.pop(context);
                onNavigateToSection(3);
              }),
              _mobileItem(context, 'Education', Icons.school_outlined, () {
                Navigator.pop(context);
                onNavigateToSection(4);
              }),
              _mobileItem(context, 'Get in Touch', Icons.mail_outline_rounded, () {
                Navigator.pop(context);
                onNavigateToSection(5);
              }),
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
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
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
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Let's Talk",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _mobileItem(BuildContext context, String title, IconData icon, VoidCallback onTap) {
    final textColor = isDark ? AppTheme.darkTextPrimary : AppTheme.lightTextPrimary;
    return ListTile(
      leading: Icon(icon, color: AppTheme.primaryCyan, size: 20),
      title: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
      ),
      onTap: onTap,
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
    );
  }
}

/// Nav item with hover effect — now uses HookWidget + useState instead of StatefulWidget.
class _NavItem extends HookWidget {
  final String title;
  final VoidCallback onTap;
  final bool isDark;

  const _NavItem({
    required this.title,
    required this.onTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final isHovered = useState(false);
    final defaultColor = isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary;
    final hoverColor = isDark ? AppTheme.primaryCyan : AppTheme.primaryBlue;

    return MouseRegion(
      onEnter: (_) => isHovered.value = true,
      onExit: (_) => isHovered.value = false,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 150),
            style: TextStyle(
              color: isHovered.value ? hoverColor : defaultColor,
              fontWeight: isHovered.value ? FontWeight.w600 : FontWeight.w500,
              fontSize: 14,
            ),
            child: Text(title),
          ),
        ),
      ),
    );
  }
}
