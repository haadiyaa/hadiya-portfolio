import 'package:flutter/material.dart';

class ProjectModel {
  final String title;
  final String subtitle;
  final String companyOrContext;
  final List<String> categories; // e.g. ['Flutter / Mobile', 'Desktop & Web']
  final String description;
  final String longDescription;
  final List<String> techStack;
  final List<String> highlights;
  final List<String> platforms;
  final IconData icon;
  final Color accentColor;
  final String? liveUrl;
  final String? liveUrlLabel;

  const ProjectModel({
    required this.title,
    required this.subtitle,
    required this.companyOrContext,
    required this.categories,
    required this.description,
    required this.longDescription,
    required this.techStack,
    required this.highlights,
    required this.platforms,
    required this.icon,
    required this.accentColor,
    this.liveUrl,
    this.liveUrlLabel,
  });

  /// Primary category getter for backwards compatibility
  String get category => categories.isNotEmpty ? categories.first : '';

  /// Returns true if this project matches the selected filter
  bool matchesFilter(String filter) {
    if (filter == 'All') return true;
    if (categories.contains(filter)) return true;
    final lowerFilter = filter.toLowerCase();
    if (lowerFilter.contains('web') &&
        platforms.any((p) => p.toLowerCase().contains('web'))) {
      return true;
    }
    if (lowerFilter.contains('desktop') &&
        platforms.any((p) => p.toLowerCase().contains('desktop'))) {
      return true;
    }
    if (lowerFilter.contains('mobile') &&
        platforms.any((p) =>
            p.toLowerCase().contains('android') ||
            p.toLowerCase().contains('ios'))) {
      return true;
    }
    return false;
  }

  static List<ProjectModel> get projects => [
        const ProjectModel(
          title: 'Isselo',
          subtitle: 'Restaurant Management ERP Suite',
          companyOrContext: 'Screl Info Pvt. Ltd.',
          categories: ['Flutter / Mobile', 'Desktop & Web'],
          description:
              'Full-featured restaurant management ERP with Sales, CRM, HR, and Accounting modules, built for Android, iOS, Desktop, and Web with offline-first capabilities.',
          longDescription:
              'Isselo was engineered from the ground up using Clean Architecture and Riverpod state management. Designed for bustling hospitality environments where connectivity drops cannot stop dining orders, it implements robust offline local storage with SQLite and an automated background synchronization engine that seamlessly reconciles transactions when network connectivity restores across mobile, desktop, and web clients.',
          techStack: [
            'Flutter',
            'Dart',
            'Riverpod',
            'SQLite',
            'Clean Architecture',
            'REST API',
            'Offline Sync',
          ],
          highlights: [
            'Multi-module architecture: Sales, CRM, HR, Table Management & Accounting',
            'Engineered offline-first SQLite local persistence with auto server synchronization',
            'Cross-platform deployment spanning Android tablets, iOS, Desktop terminals, and Web',
            'Clean Architecture separating presentation, domain, and data layers',
          ],
          platforms: ['Android', 'iOS', 'Desktop', 'Web'],
          icon: Icons.restaurant_menu_rounded,
          accentColor: Color(0xFF38BDF8),
          liveUrl: 'https://isselo.com/',
          liveUrlLabel: 'Visit Isselo Website',
        ),
        const ProjectModel(
          title: 'SincA Reports',
          subtitle: 'Executive Business Analytics & KPI Monitor',
          companyOrContext: 'Screl Info Pvt. Ltd.',
          categories: ['Flutter / Mobile', 'Desktop & Web'],
          description:
              'Real-time administrative monitoring application for executives to visualize analytics, sales funnels, and enterprise performance indicators.',
          longDescription:
              'A dedicated Flutter application tailored for business administrators and stakeholders to monitor the heartbeat of their enterprise operations. Through high-performance REST API integration and reactive state management, users can inspect real-time turnover, branch metrics, inventory health, and operational performance from anywhere.',
          techStack: [
            'Flutter',
            'Dart',
            'REST APIs',
            'Riverpod',
            'Data Visualization',
            'Responsive UI',
          ],
          highlights: [
            'Live enterprise monitoring across multi-branch ERP ecosystems',
            'Interactive charts and real-time business health indicators',
            'Optimized data parsing and caching for rapid query responses',
            'Role-based dashboard metrics for executive decision making',
          ],
          platforms: ['Android', 'iOS', 'Web'],
          icon: Icons.insights_rounded,
          accentColor: Color(0xFF10B981),
          liveUrl: 'https://apps.apple.com/in/app/sinca-reports/id6475162930',
          liveUrlLabel: 'View on App Store',
        ),
        const ProjectModel(
          title: 'Hidhayah App',
          subtitle: 'Islamic Companion & Sensor Utilities',
          companyOrContext: 'Personal Project',
          categories: ['Flutter / Mobile'],
          description:
              'Cross-platform companion offering accurate astronomical prayer times, sensor-based Qibla compass alignment, and bilingual educational resources.',
          longDescription:
              'Hidhayah combines precise astronomical computation algorithms with device hardware integration (magnetometer, accelerometer, and location services) to deliver an accurate real-time Qibla compass and calculation-based prayer schedules. Features an uncluttered, distraction-free aesthetic with bilingual Arabic and English educational libraries.',
          techStack: [
            'Flutter',
            'Dart',
            'Device Sensors',
            'Compass / Magnetometer',
            'Geolocation',
            'Bilingual UI',
          ],
          highlights: [
            'Precision astronomical calculation for dynamic daily prayer times',
            'Real-time Qibla compass utilizing device hardware sensors',
            'Curated bilingual (Arabic & English) educational library',
            'Minimalist, distraction-free visual design and offline caching',
          ],
          platforms: ['Android', 'iOS'],
          icon: Icons.explore_rounded,
          accentColor: Color(0xFF8B5CF6),
        ),
        const ProjectModel(
          title: 'SincA ERP',
          subtitle: 'Enterprise Resource Planning Core',
          companyOrContext: 'Screl Info Pvt. Ltd.',
          categories: ['Desktop & Web'],
          description:
              'Comprehensive enterprise platform covering Sales, Stock, Inventory, Finance, HRM, CRM, and Procurement with web and desktop clients.',
          longDescription:
              'SincA ERP powers large-scale operations across high-volume commercial workflows. Involved in engineering the modern web front-end and building the high-reliability WPF desktop client using C#, .NET, and XAML, closely integrating with backend REST APIs and ERP database schemas.',
          techStack: [
            'C#',
            '.NET',
            'WPF',
            'XAML',
            'REST APIs',
            'Web Frontend',
          ],
          highlights: [
            'End-to-end ERP coverage: Sales, Stock, Finance, CRM, and Procurement',
            'Engineered WPF desktop client with rich keyboard shortcuts and high throughput',
            'Collaborated on web frontend and REST API communication contracts',
            'Optimized data grid rendering for large inventory catalogs',
          ],
          platforms: ['Desktop (WPF)', 'Web'],
          icon: Icons.hub_rounded,
          accentColor: Color(0xFFF59E0B),
          liveUrl: 'https://screl.com/products',
          liveUrlLabel: 'View SincA Products',
        ),
      ];
}
