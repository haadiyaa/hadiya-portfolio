import 'package:flutter/material.dart';
import '../../models/project_model.dart';
import '../../theme/app_theme.dart';
import '../effects/spotlight_card.dart';
import '../shared_widgets.dart';

/// Single project showcase card with window frame header and spotlight glow.
class ProjectCardView extends StatelessWidget {
  final ProjectModel project;
  final bool isDark;
  final VoidCallback onViewDetails;

  const ProjectCardView({
    super.key,
    required this.project,
    required this.isDark,
    required this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    final textPrimary = isDark ? AppTheme.darkTextPrimary : AppTheme.lightTextPrimary;
    final textSecondary = isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary;
    final border = isDark ? AppTheme.darkBorder : AppTheme.lightBorder;

    return SpotlightCard(
      isDark: isDark,
      glowColor: project.accentColor,
      borderRadius: 18,
      padding: const EdgeInsets.all(22),
      onTap: onViewDetails,
      builder: (isHovered) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Top Row: Icon + Target Platforms
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: project.accentColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(project.icon, color: project.accentColor, size: 22),
              ),
              const Spacer(),
              Wrap(
                spacing: 6,
                runSpacing: 4,
                children: project.platforms.take(2).map((p) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.06)
                          : Colors.black.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      p,
                      style: TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w600,
                        color: textSecondary,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Project Title & Subtitle
          Text(
            project.title,
            style: TextStyle(
              color: textPrimary,
              fontWeight: FontWeight.w800,
              fontSize: 18,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${project.subtitle} • ${project.companyOrContext}',
            style: TextStyle(
              color: project.accentColor,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),

          const SizedBox(height: 12),

          // Description
          Text(
            project.description,
            style: TextStyle(color: textSecondary, fontSize: 13, height: 1.5),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 14),

          // Tech Stack Tags
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: project.techStack.take(4).map((tech) {
              return TechTagChip(label: tech, isDark: isDark);
            }).toList(),
          ),

          const SizedBox(height: 18),

          // CTA Action
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: onViewDetails,
              icon: const Icon(Icons.arrow_forward_rounded, size: 15),
              label: const Text('Architecture & Deliverables'),
              style: OutlinedButton.styleFrom(
                foregroundColor: isHovered ? project.accentColor : textPrimary,
                side: BorderSide(color: isHovered ? project.accentColor : border),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
