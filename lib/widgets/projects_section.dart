import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../models/project_model.dart';
import '../providers/app_providers.dart';
import '../theme/app_theme.dart';
import 'project_detail_modal.dart';
import 'shared_widgets.dart';

class ProjectsSection extends ConsumerWidget {
  final bool isDark;

  const ProjectsSection({super.key, required this.isDark});

  static const List<String> _filters = ['All', 'Flutter / Mobile', 'Desktop & Web'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedFilter = ref.watch(projectFilterProvider);

    final filteredProjects = selectedFilter == 'All'
        ? ProjectModel.projects
        : ProjectModel.projects.where((p) => p.category == selectedFilter).toList();

    return SectionContainer(
      children: [
        SectionHeader(
          tag: 'FEATURED WORK',
          title: 'Production Projects & Engineering Work',
          subtitle:
              'From offline-first restaurant management ERPs to executive analytics dashboards and utility tools.',
          isDark: isDark,
        ),
        const SizedBox(height: 24),

        // Filter Chips
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: _filters.map((filter) {
            final isSelected = selectedFilter == filter;
            return InkWell(
              onTap: () => ref.read(projectFilterProvider.notifier).state = filter,
              borderRadius: BorderRadius.circular(10),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
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
        ),

        const SizedBox(height: 36),

        // Project Cards Grid
        LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 750;
            final cardWidth = isWide ? (constraints.maxWidth - 24) / 2 : constraints.maxWidth;
            return Wrap(
              spacing: 24,
              runSpacing: 24,
              children: filteredProjects.map((project) {
                return SizedBox(
                  width: cardWidth,
                  child: _ProjectCard(
                    project: project,
                    isDark: isDark,
                    onViewDetails: () => ProjectDetailModal.show(
                      context,
                      project,
                      isDark,
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}

/// Uses shared [HoverCard] and [TechTagChip] — no StatefulWidget needed.
class _ProjectCard extends StatelessWidget {
  final ProjectModel project;
  final bool isDark;
  final VoidCallback onViewDetails;

  const _ProjectCard({
    required this.project,
    required this.isDark,
    required this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    final textPrimary = isDark ? AppTheme.darkTextPrimary : AppTheme.lightTextPrimary;
    final textSecondary = isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary;
    final border = isDark ? AppTheme.darkBorder : AppTheme.lightBorder;

    return HoverCard(
      isDark: isDark,
      hoverAccentColor: project.accentColor,
      builder: (isHovered) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Top Row: Icon + Target Platforms
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: project.accentColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  project.icon,
                  color: project.accentColor,
                  size: 24,
                ),
              ),
              const Spacer(),
              Wrap(
                spacing: 6,
                children: project.platforms.take(2).map((p) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.white.withValues(alpha: 0.06) : Colors.black.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      p,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: textSecondary,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),

          const SizedBox(height: 18),

          // Project Title & Company
          Text(
            project.title,
            style: TextStyle(
              color: textPrimary,
              fontWeight: FontWeight.w800,
              fontSize: 20,
              letterSpacing: -0.4,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${project.subtitle} • ${project.companyOrContext}',
            style: TextStyle(
              color: project.accentColor,
              fontWeight: FontWeight.w600,
              fontSize: 12.5,
            ),
          ),

          const SizedBox(height: 12),

          // Description
          Text(
            project.description,
            style: TextStyle(
              color: textSecondary,
              fontSize: 13.5,
              height: 1.55,
            ),
          ),

          const SizedBox(height: 14),

          // Tech Stack Pills — uses shared TechTagChip
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: project.techStack.take(5).map((tech) {
              return TechTagChip(label: tech, isDark: isDark);
            }).toList(),
          ),

          const SizedBox(height: 20),

          // Button to open modal
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: onViewDetails,
              icon: const Icon(Icons.arrow_forward_rounded, size: 16),
              label: const Text('Architecture & Deliverables'),
              style: OutlinedButton.styleFrom(
                foregroundColor: isHovered ? project.accentColor : textPrimary,
                side: BorderSide(
                  color: isHovered ? project.accentColor : border,
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
