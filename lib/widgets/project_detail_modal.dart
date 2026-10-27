import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/project_model.dart';
import '../theme/app_theme.dart';
import 'shared_widgets.dart';

class ProjectDetailModal extends StatelessWidget {
  final ProjectModel project;
  final bool isDark;

  const ProjectDetailModal({
    super.key,
    required this.project,
    required this.isDark,
  });

  static void show(BuildContext context, ProjectModel project, bool isDark) {
    showDialog(
      context: context,
      builder: (context) => ProjectDetailModal(project: project, isDark: isDark),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 700;
    final cardBg = isDark ? AppTheme.darkCard : AppTheme.lightCard;
    final border = isDark ? AppTheme.darkBorder : AppTheme.lightBorder;
    final textPrimary = isDark ? AppTheme.darkTextPrimary : AppTheme.lightTextPrimary;
    final textSecondary = isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary;
    final isScrelProduct = project.companyOrContext.toLowerCase().contains('screl');

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 40,
        vertical: 24,
      ),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 750, maxHeight: 850),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: border, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.4),
              blurRadius: 40,
              offset: const Offset(0, 15),
            ),
          ],
        ),
        child: Column(
          children: [
            // Header bar
            Padding(
              padding: const EdgeInsets.fromLTRB(28, 24, 20, 16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: project.accentColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(project.icon, color: project.accentColor, size: 26),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          project.title,
                          style: TextStyle(
                            color: textPrimary,
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.4,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${project.subtitle} • ${project.companyOrContext}',
                          style: TextStyle(
                            color: project.accentColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.close_rounded, color: textSecondary),
                    style: IconButton.styleFrom(
                      backgroundColor: isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.05),
                    ),
                  ),
                ],
              ),
            ),

            const Divider(height: 1),

            // Modal Body (Scrollable)
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Target Platforms Row
                    Text(
                      'TARGET PLATFORMS',
                      style: TextStyle(
                        color: textSecondary,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        ...project.platforms.map((p) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: project.accentColor.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: project.accentColor.withValues(alpha: 0.2),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  p.contains('Android')
                                      ? Icons.android_rounded
                                      : p.contains('iOS')
                                          ? Icons.apple_rounded
                                          : p.contains('Desktop')
                                              ? Icons.desktop_windows_rounded
                                              : Icons.language_rounded,
                                  size: 14,
                                  color: project.accentColor,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  p,
                                  style: TextStyle(
                                    color: project.accentColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),

                    if (project.liveUrl != null) ...[
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: () => _launchUrl(project.liveUrl!),
                        icon: const Icon(Icons.open_in_new_rounded, size: 15),
                        label: Text(project.liveUrlLabel ?? 'Open Live Product'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: project.accentColor.withValues(alpha: 0.15),
                          foregroundColor: project.accentColor,
                          side: BorderSide(color: project.accentColor.withValues(alpha: 0.4)),
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                        ),
                      ),
                    ],

                    const SizedBox(height: 24),

                    // Deep Dive Overview
                    Text(
                      'ARCHITECTURE & IMPLEMENTATION',
                      style: TextStyle(
                        color: textSecondary,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      project.longDescription,
                      style: TextStyle(
                        color: textPrimary,
                        fontSize: 14.5,
                        height: 1.65,
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Key Architectural Highlights
                    Text(
                      'KEY DELIVERABLES & TECHNICAL ACHIEVEMENTS',
                      style: TextStyle(
                        color: textSecondary,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...project.highlights.map(
                      (h) => BulletPointRow(
                        text: h,
                        dotColor: project.accentColor,
                        textColor: textPrimary,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Tech Stack Tags
                    Text(
                      'TECHNOLOGIES & TOOLS USED',
                      style: TextStyle(
                        color: textSecondary,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: project.techStack
                          .map((tech) => TechTagChip(label: tech, isDark: isDark))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),

            // Footer
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                color: isDark ? Colors.black26 : Colors.grey.withValues(alpha: 0.04),
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
                border: Border(top: BorderSide(color: border)),
              ),
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 12,
                runSpacing: 10,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isScrelProduct) ...[
                        Icon(
                          Icons.verified_outlined,
                          size: 15,
                          color: project.accentColor,
                        ),
                        const SizedBox(width: 6),
                      ],
                      Text(
                        isScrelProduct
                            ? 'A SCREL Product'
                            : 'Personal Project • Developed by Haadiya CT',
                        style: TextStyle(
                          color: isScrelProduct ? project.accentColor : textSecondary,
                          fontWeight: isScrelProduct ? FontWeight.w600 : FontWeight.normal,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  Wrap(
                    spacing: 10,
                    runSpacing: 8,
                    children: [
                      if (project.liveUrl != null)
                        ElevatedButton.icon(
                          onPressed: () => _launchUrl(project.liveUrl!),
                          icon: const Icon(Icons.open_in_new_rounded, size: 15),
                          label: Text(project.liveUrlLabel ?? 'Open Live Product'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: project.accentColor,
                            foregroundColor: const Color(0xFF090D16),
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                          ),
                        ),
                      OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: textPrimary,
                          side: BorderSide(color: border),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text('Close'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
