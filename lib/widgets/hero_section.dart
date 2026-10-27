import 'package:flutter/material.dart';
import 'effects/reveal_on_scroll.dart';
import 'hero/hero_text_content.dart';
import 'hero/hero_console_card.dart';
import 'hero/hero_stats_strip.dart';

class HeroSection extends StatelessWidget {
  final bool isDark;
  final VoidCallback onExploreProjects;
  final VoidCallback onOpenResume;
  final VoidCallback onContactMe;

  const HeroSection({
    super.key,
    required this.isDark,
    required this.onExploreProjects,
    required this.onOpenResume,
    required this.onContactMe,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width >= 1050;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 60 : 20,
        vertical: isDesktop ? 60 : 36,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1140),
          child: Column(
            children: [
              RevealOnScroll(
                duration: const Duration(milliseconds: 700),
                child: isDesktop
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 6,
                            child: HeroTextContent(
                              isDark: isDark,
                              onExploreProjects: onExploreProjects,
                              onOpenResume: onOpenResume,
                              onContactMe: onContactMe,
                            ),
                          ),
                          const SizedBox(width: 48),
                          Expanded(
                            flex: 5,
                            child: HeroConsoleCard(isDark: isDark),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          HeroTextContent(
                            isDark: isDark,
                            onExploreProjects: onExploreProjects,
                            onOpenResume: onOpenResume,
                            onContactMe: onContactMe,
                          ),
                          const SizedBox(height: 36),
                          HeroConsoleCard(isDark: isDark),
                        ],
                      ),
              ),

              const SizedBox(height: 48),

              // Floating Stats Strip
              RevealOnScroll(
                delay: const Duration(milliseconds: 200),
                child: HeroStatsStrip(isDark: isDark),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
