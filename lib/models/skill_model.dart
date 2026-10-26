import 'package:flutter/material.dart';

class SkillCategory {
  final String title;
  final IconData icon;
  final List<String> skills;

  const SkillCategory({
    required this.title,
    required this.icon,
    required this.skills,
  });

  static List<SkillCategory> get categories => [
        const SkillCategory(
          title: 'Languages & Frameworks',
          icon: Icons.code_rounded,
          skills: [
            'Dart',
            'Flutter (Android, iOS, Web, Desktop)',
            'C#',
            '.NET',
            'XAML / WPF',
            'HTML5 & CSS3',
          ],
        ),
        const SkillCategory(
          title: 'State Management & Architecture',
          icon: Icons.account_tree_rounded,
          skills: [
            'Riverpod',
            'Hooks Riverpod',
            'BLoC / Cubit',
            'Provider',
            'GetX',
            'Flutter Hooks',
            'Clean Architecture',
            'MVVM & MVC',
            'API-Driven Development',
          ],
        ),
        const SkillCategory(
          title: 'Databases & Storage',
          icon: Icons.storage_rounded,
          skills: [
            'SQLite',
            'SQFlite',
            'Offline-First Data Sync',
            'Hive',
            'Firebase',
            'Local Caching',
          ],
        ),
        const SkillCategory(
          title: 'APIs, Tools & Workflow',
          icon: Icons.build_circle_rounded,
          skills: [
            'REST API Integration',
            'Git & GitHub',
            'Postman',
            'Figma to UI',
            'Freezed',
            'Code Generation',
            'Cross-Platform Debugging',
          ],
        ),
      ];

  static List<String> get coreHighlights => [
        '3+ Years Building Production Apps',
        'Enterprise ERP Specialist (Sales, CRM, Finance)',
        'Offline-First SQLite Synchronization',
        'Clean Architecture & Riverpod / BLoC',
        'Pixel-Perfect Responsive UI from Figma',
        'Multi-Platform: Mobile, Desktop & Web',
      ];
}
