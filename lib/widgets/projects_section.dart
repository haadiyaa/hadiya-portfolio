import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../models/project_model.dart';
import '../providers/app_providers.dart';
import 'effects/reveal_on_scroll.dart';
import 'project_detail_modal.dart';
import 'projects/project_card_view.dart';
import 'projects/project_filter_bar.dart';
import 'shared_widgets.dart';

class ProjectsSection extends ConsumerWidget {
  final bool isDark;

  const ProjectsSection({super.key, required this.isDark});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedFilter = ref.watch(projectFilterProvider);

    final filteredProjects = selectedFilter == 'All'
        ? ProjectModel.projects
        : ProjectModel.projects.where((p) => p.category == selectedFilter).toList();

    return SectionContainer(
      children: [
        RevealOnScroll(
          child: SectionHeader(
            tag: 'FEATURED WORK',
            title: 'Production Projects & Engineering Work',
            subtitle:
                'From offline-first restaurant management ERPs to executive analytics dashboards and utility tools.',
            isDark: isDark,
          ),
        ),
        const SizedBox(height: 24),

        // Filter Chips Bar
        RevealOnScroll(
          delay: const Duration(milliseconds: 100),
          child: ProjectFilterBar(isDark: isDark),
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
              children: List.generate(filteredProjects.length, (i) {
                final project = filteredProjects[i];
                return SizedBox(
                  width: cardWidth,
                  child: RevealOnScroll(
                    delay: Duration(milliseconds: 100 * (i % 4)),
                    child: ProjectCardView(
                      project: project,
                      isDark: isDark,
                      onViewDetails: () => ProjectDetailModal.show(
                        context,
                        project,
                        isDark,
                      ),
                    ),
                  ),
                );
              }),
            );
          },
        ),
      ],
    );
  }
}
