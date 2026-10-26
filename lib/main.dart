import 'package:flutter/material.dart';

import 'theme/app_theme.dart';
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
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key});

  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  ThemeMode _themeMode = ThemeMode.dark;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.dark
          ? ThemeMode.light
          : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Haadiya CT | Flutter Developer',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
      themeMode: _themeMode,
      home: PortfolioHomePage(
        isDark: _themeMode == ThemeMode.dark,
        onToggleTheme: _toggleTheme,
      ),
    );
  }
}

class PortfolioHomePage extends StatefulWidget {
  final bool isDark;
  final VoidCallback onToggleTheme;

  const PortfolioHomePage({
    super.key,
    required this.isDark,
    required this.onToggleTheme,
  });

  @override
  State<PortfolioHomePage> createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage> {
  final ScrollController _scrollController = ScrollController();

  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _educationKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  bool _showBackToTop = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset > 400 && !_showBackToTop) {
        setState(() => _showBackToTop = true);
      } else if (_scrollController.offset <= 400 && _showBackToTop) {
        setState(() => _showBackToTop = false);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToKey(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 650),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _navigateToSection(int index) {
    switch (index) {
      case 0:
        _scrollToKey(_heroKey);
        break;
      case 1:
        _scrollToKey(_experienceKey);
        break;
      case 2:
        _scrollToKey(_projectsKey);
        break;
      case 3:
        _scrollToKey(_skillsKey);
        break;
      case 4:
        _scrollToKey(_educationKey);
        break;
      case 5:
        _scrollToKey(_contactKey);
        break;
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 650),
      curve: Curves.easeInOutCubic,
    );
  }

  void _openResume() {
    ResumeModal.show(context, widget.isDark);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar(
        isDark: widget.isDark,
        onToggleTheme: widget.onToggleTheme,
        onNavigateToSection: _navigateToSection,
        onOpenResume: _openResume,
        onOpenContact: () => _scrollToKey(_contactKey),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            // 0. Hero Section & About
            Container(
              key: _heroKey,
              child: HeroSection(
                isDark: widget.isDark,
                onExploreProjects: () => _scrollToKey(_projectsKey),
                onOpenResume: _openResume,
                onContactMe: () => _scrollToKey(_contactKey),
              ),
            ),

            // Highlights & Core Engineering Pillars
            HighlightsSection(isDark: widget.isDark),

            // 1. Work Experience Section
            Container(
              key: _experienceKey,
              child: ExperienceSection(isDark: widget.isDark),
            ),

            // 2. Featured Projects Section
            Container(
              key: _projectsKey,
              child: ProjectsSection(isDark: widget.isDark),
            ),

            // 3. Technical Skills Section
            Container(
              key: _skillsKey,
              child: SkillsSection(isDark: widget.isDark),
            ),

            // 4. Education & Academic Background
            Container(
              key: _educationKey,
              child: EducationSection(isDark: widget.isDark),
            ),

            // 5. Contact & Connect Section
            Container(
              key: _contactKey,
              child: ContactSection(isDark: widget.isDark),
            ),

            // Footer Section
            FooterSection(isDark: widget.isDark, onScrollToTop: _scrollToTop),
          ],
        ),
      ),
      floatingActionButton: _showBackToTop
          ? FloatingActionButton.small(
              onPressed: _scrollToTop,
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
