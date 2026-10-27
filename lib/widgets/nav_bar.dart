import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../theme/app_theme.dart';
import 'nav/mobile_nav_drawer.dart';
import 'nav/nav_action_buttons.dart';

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
    final isMobile = MediaQuery.of(context).size.width < 1040;
    final cardColor = isDark
        ? AppTheme.darkCard.withValues(alpha: 0.85)
        : Colors.white.withValues(alpha: 0.85);
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
            border: Border(bottom: BorderSide(color: borderColor, width: 1)),
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
                const SizedBox(width: 16),
                NavActionButtons(
                  isDark: isDark,
                  onToggleTheme: onToggleTheme,
                  onOpenResume: onOpenResume,
                  onOpenContact: onOpenContact,
                ),
              ],

              // Mobile Menu Buttons
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
                  onPressed: () => MobileNavDrawer.show(
                    context,
                    isDark: isDark,
                    onNavigateToSection: onNavigateToSection,
                    onOpenResume: onOpenResume,
                    onOpenContact: onOpenContact,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends HookWidget {
  final String title;
  final VoidCallback onTap;
  final bool isDark;

  const _NavItem({required this.title, required this.onTap, required this.isDark});

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
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
