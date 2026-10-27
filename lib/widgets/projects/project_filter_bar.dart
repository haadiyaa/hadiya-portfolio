import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../providers/app_providers.dart';
import '../../theme/app_theme.dart';

/// Filter selection bar for projects with animated indicator pills.
class ProjectFilterBar extends ConsumerWidget {
  final bool isDark;

  const ProjectFilterBar({super.key, required this.isDark});

  static const List<String> _filters = [
    'All',
    'Flutter / Mobile',
    'Desktop & Web',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedFilter = ref.watch(projectFilterProvider);

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: _filters.map((filter) {
        final isSelected = selectedFilter == filter;
        return InkWell(
          onTap: () => ref.read(projectFilterProvider.notifier).state = filter,
          borderRadius: BorderRadius.circular(10),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppTheme.primaryCyan
                  : (isDark ? AppTheme.darkCard : AppTheme.lightCard),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isSelected
                    ? AppTheme.primaryCyan
                    : (isDark ? AppTheme.darkBorder : AppTheme.lightBorder),
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: AppTheme.primaryCyan.withValues(alpha: 0.35),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : null,
            ),
            child: Text(
              filter,
              style: TextStyle(
                color: isSelected
                    ? const Color(0xFF090D16)
                    : (isDark ? AppTheme.darkTextPrimary : AppTheme.lightTextPrimary),
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                fontSize: 13,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
