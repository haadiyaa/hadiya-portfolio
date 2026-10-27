import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'providers/app_providers.dart';
import 'theme/app_theme.dart';
import 'widgets/effects/ambient_mesh_background.dart';
import 'widgets/effects/scroll_progress_bar.dart';
import 'widgets/nav_bar.dart';
import 'widgets/hero_section.dart';
import 'widgets/highlights_section.dart';
import 'widgets/experience_section.dart';
import 'widgets/projects_section.dart';
import 'widgets/skills_section.dart';
import 'widgets/education_section.dart';
import 'widgets/contact_section.dart';
import 'widgets/footer_section.dart';
import 'widgets/resume_modal.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: PortfolioApp()));
}

class PortfolioApp extends ConsumerWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(isDarkModeProvider);

    return MaterialApp(
      title: 'Haadiya CT | Flutter Developer',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      home: const PortfolioHomePage(),
    );
  }
}

class PortfolioHomePage extends HookConsumerWidget {
  const PortfolioHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(isDarkModeProvider);
    final scrollProgress = ref.watch(scrollProgressProvider);
    final showBackToTop = ref.watch(showBackToTopProvider);

    final scrollController = useScrollController();

    final heroKey = useMemoized(() => GlobalKey(), const []);
    final highlightsKey = useMemoized(() => GlobalKey(), const []);
    final experienceKey = useMemoized(() => GlobalKey(), const []);
    final projectsKey = useMemoized(() => GlobalKey(), const []);
    final skillsKey = useMemoized(() => GlobalKey(), const []);
    final educationKey = useMemoized(() => GlobalKey(), const []);
    final contactKey = useMemoized(() => GlobalKey(), const []);

    // Listen to scroll offset to update scroll progress and FAB visibility
    useEffect(() {
      void listener() {
        if (!scrollController.hasClients) return;
        final maxScroll = scrollController.position.maxScrollExtent;
        final currentOffset = scrollController.offset;
        final progress = maxScroll > 0 ? (currentOffset / maxScroll).clamp(0.0, 1.0) : 0.0;
        ref.read(scrollProgressProvider.notifier).state = progress;

        final shouldShow = currentOffset > 400;
        if (shouldShow != ref.read(showBackToTopProvider)) {
          ref.read(showBackToTopProvider.notifier).state = shouldShow;
        }
      }

      scrollController.addListener(listener);
      return () => scrollController.removeListener(listener);
    }, [scrollController]);

    void scrollToKey(GlobalKey key) {
      final ctx = key.currentContext;
      if (ctx != null) {
        Scrollable.ensureVisible(
          ctx,
          duration: const Duration(milliseconds: 650),
          curve: Curves.easeInOutCubic,
        );
      }
    }

    void navigateToSection(int index) {
      final keys = [
        heroKey,
        highlightsKey,
        experienceKey,
        projectsKey,
        skillsKey,
        educationKey,
        contactKey,
      ];
      if (index >= 0 && index < keys.length) {
        scrollToKey(keys[index]);
      }
    }

    void scrollToTop() {
      scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 650),
        curve: Curves.easeInOutCubic,
      );
    }

    void openResume() {
      ResumeModal.show(context, isDark);
    }

    return Scaffold(
      appBar: NavBar(
        isDark: isDark,
        onToggleTheme: () =>
            ref.read(isDarkModeProvider.notifier).state = !isDark,
        onNavigateToSection: navigateToSection,
        onOpenResume: openResume,
        onOpenContact: () => scrollToKey(contactKey),
      ),
      body: AmbientMeshBackground(
        isDark: isDark,
        child: Stack(
          children: [
            SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  // 0. Hero Section
                  Container(
                    key: heroKey,
                    child: HeroSection(
                      isDark: isDark,
                      onExploreProjects: () => scrollToKey(projectsKey),
                      onOpenResume: openResume,
                      onContactMe: () => scrollToKey(contactKey),
                    ),
                  ),

                  // 1. Engineering Highlights & Core Pillars
                  Container(
                    key: highlightsKey,
                    child: HighlightsSection(isDark: isDark),
                  ),

                  // 2. Career Experience Timeline
                  Container(
                    key: experienceKey,
                    child: ExperienceSection(isDark: isDark),
                  ),

                  // 3. Featured Projects
                  Container(
                    key: projectsKey,
                    child: ProjectsSection(isDark: isDark),
                  ),

                  // 4. Technical Skills Matrix
                  Container(
                    key: skillsKey,
                    child: SkillsSection(isDark: isDark),
                  ),

                  // 5. Academic Foundations
                  Container(
                    key: educationKey,
                    child: EducationSection(isDark: isDark),
                  ),

                  // 6. Contact & Collaboration
                  Container(
                    key: contactKey,
                    child: ContactSection(isDark: isDark),
                  ),

                  // Footer Section
                  FooterSection(isDark: isDark, onScrollToTop: scrollToTop),
                ],
              ),
            ),

            // Top Scroll Progress Bar
            ScrollProgressBar(progress: scrollProgress),
          ],
        ),
      ),
      floatingActionButton: showBackToTop
          ? FloatingActionButton.small(
              onPressed: scrollToTop,
              backgroundColor: AppTheme.primaryCyan,
              foregroundColor: const Color(0xFF090D16),
              elevation: 4,
              tooltip: 'Back to Top',
              child: const Icon(Icons.arrow_upward_rounded),
            )
          : null,
    );
  }
}
