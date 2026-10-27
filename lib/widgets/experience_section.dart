import 'package:flutter/material.dart';
import '../models/experience_model.dart';
import 'effects/reveal_on_scroll.dart';
import 'shared_widgets.dart';
import 'timeline/experience_timeline_node.dart';

class ExperienceSection extends StatelessWidget {
  final bool isDark;

  const ExperienceSection({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final experiences = ExperienceModel.experiences;

    return SectionContainer(
      children: [
        RevealOnScroll(
          child: SectionHeader(
            tag: 'CAREER TIMELINE',
            title: 'Professional Experience',
            subtitle:
                'Demonstrated track record in building mission-critical enterprise systems and high-fidelity mobile apps.',
            isDark: isDark,
          ),
        ),
        const SizedBox(height: 36),

        // Timeline Nodes List
        ...List.generate(experiences.length, (index) {
          return RevealOnScroll(
            delay: Duration(milliseconds: 150 * index),
            child: ExperienceTimelineNode(
              experience: experiences[index],
              isDark: isDark,
              isLast: index == experiences.length - 1,
            ),
          );
        }),
      ],
    );
  }
}
