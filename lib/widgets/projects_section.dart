import 'package:flutter/material.dart';
import '../models/project_model.dart';
import '../theme/app_theme.dart';
import 'project_detail_modal.dart';

class ProjectsSection extends StatefulWidget {
  final bool isDark;

  const ProjectsSection({super.key, required this.isDark});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  String selectedFilter = 'All';

  final List<String> filters = ['All', 'Flutter / Mobile', 'Desktop & Web'];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 900;
    final textPrimary = widget.isDark ? AppTheme.darkTextPrimary : AppTheme.lightTextPrimary;
    final textSecondary = widget.isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary;

    final filteredProjects = selectedFilter == 'All'
        ? ProjectModel.projects
        : ProjectModel.projects.where((p) => p.category == selectedFilter).toList();

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
                    'FEATURED WORK',
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
                'Production Projects & Engineering Work',
                style: TextStyle(
                  color: textPrimary,
                  fontSize: isMobile ? 26 : 34,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.8,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'From offline-first restaurant management ERPs to executive analytics dashboards and utility tools.',
                style: TextStyle(
                  color: textSecondary,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 24),

              // Filter Chips
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: filters.map((filter) {
                  final isSelected = selectedFilter == filter;
                  return InkWell(
                    onTap: () => setState(() => selectedFilter = filter),
                    borderRadius: BorderRadius.circular(10),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppTheme.primaryCyan
                            : (widget.isDark ? AppTheme.darkCard : AppTheme.lightCard),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: isSelected
                              ? AppTheme.primaryCyan
                              : (widget.isDark ? AppTheme.darkBorder : AppTheme.lightBorder),
                        ),
                      ),
                      child: Text(
                        filter,
                        style: TextStyle(
                          color: isSelected
                              ? const Color(0xFF090D16)
                              : (widget.isDark ? AppTheme.darkTextPrimary : AppTheme.lightTextPrimary),
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
                          isDark: widget.isDark,
                          onViewDetails: () => ProjectDetailModal.show(
                            context,
                            project,
                            widget.isDark,
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final ProjectModel project;
  final bool isDark;
  final VoidCallback onViewDetails;

  const _ProjectCard({
    required this.project,
    required this.isDark,
    required this.onViewDetails,
  });

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final cardBg = widget.isDark ? AppTheme.darkCard : AppTheme.lightCard;
    final cardHoverBg = widget.isDark ? AppTheme.darkCardHover : AppTheme.lightCardHover;
    final border = widget.isDark ? AppTheme.darkBorder : AppTheme.lightBorder;
    final textPrimary = widget.isDark ? AppTheme.darkTextPrimary : AppTheme.lightTextPrimary;
    final textSecondary = widget.isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary;

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(26),
        decoration: BoxDecoration(
          color: isHovered ? cardHoverBg : cardBg,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isHovered ? widget.project.accentColor.withValues(alpha: 0.6) : border,
            width: isHovered ? 1.5 : 1,
          ),
          boxShadow: isHovered
              ? [
                  BoxShadow(
                    color: widget.project.accentColor.withValues(alpha: 0.15),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Top Row: Icon + Target Platforms
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: widget.project.accentColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    widget.project.icon,
                    color: widget.project.accentColor,
                    size: 24,
                  ),
                ),
                const Spacer(),
                Wrap(
                  spacing: 6,
                  children: widget.project.platforms.take(2).map((p) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: widget.isDark ? Colors.white.withValues(alpha: 0.06) : Colors.black.withValues(alpha: 0.05),
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
              widget.project.title,
              style: TextStyle(
                color: textPrimary,
                fontWeight: FontWeight.w800,
                fontSize: 20,
                letterSpacing: -0.4,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${widget.project.subtitle} • ${widget.project.companyOrContext}',
              style: TextStyle(
                color: widget.project.accentColor,
                fontWeight: FontWeight.w600,
                fontSize: 12.5,
              ),
            ),

            const SizedBox(height: 12),

            // Description
            Text(
              widget.project.description,
              style: TextStyle(
                color: textSecondary,
                fontSize: 13.5,
                height: 1.55,
              ),
            ),

            const SizedBox(height: 14),

            // Tech Stack Pills
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: widget.project.techStack.take(5).map((tech) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: widget.isDark ? AppTheme.darkBg : AppTheme.lightCardHover,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: widget.isDark ? AppTheme.darkBorder : AppTheme.lightBorder,
                    ),
                  ),
                  child: Text(
                    tech,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: textSecondary,
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            // Button to open modal
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: widget.onViewDetails,
                icon: const Icon(Icons.arrow_forward_rounded, size: 16),
                label: const Text('Architecture & Deliverables'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: isHovered ? widget.project.accentColor : textPrimary,
                  side: BorderSide(
                    color: isHovered ? widget.project.accentColor : border,
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
      ),
    );
  }
}
