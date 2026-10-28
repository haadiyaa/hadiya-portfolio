import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import 'resume_components.dart';

/// Complete formatted resume document container.
class ResumeDocumentView extends StatelessWidget {
  final bool isDark;

  const ResumeDocumentView({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 750;
    final border = isDark ? AppTheme.darkBorder : AppTheme.lightBorder;
    final textPrimary = isDark ? AppTheme.darkTextPrimary : AppTheme.lightTextPrimary;
    final textSecondary = isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary;

    return Container(
      padding: EdgeInsets.all(isMobile ? 18 : 32),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.darkBg : const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header info
          Center(
            child: Column(
              children: [
                Text(
                  'Haadiya CT',
                  style: TextStyle(
                    color: textPrimary,
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Flutter Developer & Cross-Platform Engineer',
                  style: TextStyle(
                    color: AppTheme.primaryCyan,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Kozhikode, Kerala, India • haadiyact@gmail.com • linkedin.com',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: textSecondary,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),
          const Divider(height: 1),
          const SizedBox(height: 20),

          // Professional Summary
          const ResumeSectionTitle(title: 'PROFESSIONAL SUMMARY'),
          const SizedBox(height: 8),
          Text(
            'Flutter Developer with 3+ years of experience building cross-platform applications and enterprise ERP software with Flutter. Experienced in REST API integration, offline-first data handling with SQLite, state management with Riverpod, BLoC, Provider and GetX, and Clean Architecture. Skilled in turning Figma designs into responsive UIs and maintaining production-grade ERP modules across Sales, Inventory, CRM and Finance.',
            style: TextStyle(color: textPrimary, fontSize: 13.5, height: 1.6),
          ),

          const SizedBox(height: 20),

          // Technical Skills
          const ResumeSectionTitle(title: 'TECHNICAL SKILLS'),
          const SizedBox(height: 8),
          ResumeSkillBullet(
            title: 'Languages',
            items: 'Dart, C#, XAML, HTML, CSS',
            textColor: textPrimary,
            subColor: textSecondary,
          ),
          ResumeSkillBullet(
            title: 'Frameworks & Platforms',
            items: 'Flutter, .NET, WPF, Cross-Platform (Android, iOS, Desktop, Web)',
            textColor: textPrimary,
            subColor: textSecondary,
          ),
          ResumeSkillBullet(
            title: 'State Management & Architecture',
            items: 'Riverpod, Hooks Riverpod, BLoC, Provider, GetX, Clean Architecture, MVVM',
            textColor: textPrimary,
            subColor: textSecondary,
          ),
          ResumeSkillBullet(
            title: 'Database & Storage',
            items: 'SQLite, SQFlite, Hive, Firebase',
            textColor: textPrimary,
            subColor: textSecondary,
          ),
          ResumeSkillBullet(
            title: 'APIs & Tools',
            items: 'REST API Integration, Git, GitHub, Postman, Figma, Freezed',
            textColor: textPrimary,
            subColor: textSecondary,
          ),

          const SizedBox(height: 20),

          // Professional Experience
          const ResumeSectionTitle(title: 'PROFESSIONAL EXPERIENCE'),
          const SizedBox(height: 12),
          ResumeJobHeader(
            role: 'Flutter Developer',
            company: 'Screl Info Pvt. Ltd.',
            location: 'Kozhikode, Kerala',
            period: 'Nov 2024 – Present',
            textColor: textPrimary,
          ),
          const SizedBox(height: 8),
          ResumeBulletPoint(
            text: 'Develop and maintain cross-platform ERP applications using Flutter and Dart, covering Sales, Inventory, CRM and Finance modules.',
            textColor: textPrimary,
          ),
          ResumeBulletPoint(
            text: 'Built Isselo, a restaurant management ERP for Android, iOS, desktop and web, using Clean Architecture and Riverpod, with offline SQLite storage and automatic server synchronization.',
            textColor: textPrimary,
          ),
          ResumeBulletPoint(
            text: 'Developed SincA Reports, a Flutter application for administrators to monitor business reports and analytics from the SincA ERP ecosystem through REST API integration.',
            textColor: textPrimary,
          ),
          ResumeBulletPoint(
            text: 'Develop the web front end and WPF desktop application for SincA ERP using C#, .NET and XAML.',
            textColor: textPrimary,
          ),
          ResumeBulletPoint(
            text: 'Integrate REST APIs and collaborate with backend teams to implement and optimize API-driven features.',
            textColor: textPrimary,
          ),
          ResumeBulletPoint(
            text: 'Build reusable Flutter components and apply state management to improve maintainability and performance.',
            textColor: textPrimary,
          ),

          const SizedBox(height: 16),
          ResumeJobHeader(
            role: 'Flutter Developer Intern',
            company: 'Self Stack',
            location: 'Kozhikode, Kerala',
            period: 'Sept 2023 – Nov 2024',
            textColor: textPrimary,
          ),
          const SizedBox(height: 8),
          ResumeBulletPoint(
            text: 'Developed Flutter applications using Provider, GetX and BLoC state management.',
            textColor: textPrimary,
          ),
          ResumeBulletPoint(
            text: 'Implemented user interfaces from Figma designs and integrated them with backend REST APIs.',
            textColor: textPrimary,
          ),
          ResumeBulletPoint(
            text: 'Worked with HTML and CSS.',
            textColor: textPrimary,
          ),
          ResumeBulletPoint(
            text: 'Handled debugging, API integration and maintenance on real-world application features.',
            textColor: textPrimary,
          ),
          ResumeBulletPoint(
            text: 'Collaborated with team members to troubleshoot issues and deliver features within project requirements.',
            textColor: textPrimary,
          ),

          const SizedBox(height: 20),

          // Featured Projects
          const ResumeSectionTitle(title: 'FEATURED PROJECTS'),
          const SizedBox(height: 10),
          ResumeProjectItem(
            title: 'Isselo (Screl Info Pvt. Ltd.)',
            tech: 'Flutter, Dart, Riverpod, SQLite, Clean Architecture',
            desc: 'Restaurant management ERP with Sales, CRM, HR and accounting modules, built for Android, iOS, desktop and web with offline data storage and automatic server synchronization.',
            textColor: textPrimary,
          ),
          ResumeProjectItem(
            title: 'SincA ERP (Screl Info Pvt. Ltd.)',
            tech: 'C#, .NET, WPF, XAML',
            desc: 'Enterprise ERP covering Sales, Stock, Inventory, Finance, HRM, CRM and Procurement. Developed web front end and WPF desktop application.',
            textColor: textPrimary,
          ),
          ResumeProjectItem(
            title: 'SincA Reports (Screl Info Pvt. Ltd.)',
            tech: 'Flutter, Dart, REST APIs',
            desc: 'Monitoring application for administrators to visualize and track real-time business analytics and reports from the SincA ERP ecosystem.',
            textColor: textPrimary,
          ),
          ResumeProjectItem(
            title: 'Hidhayah App',
            tech: 'Flutter, Dart',
            desc: 'Islamic application with prayer time calculation, Qibla direction using device sensors, and Arabic and English educational resources.',
            textColor: textPrimary,
          ),

          const SizedBox(height: 20),

          // Education
          const ResumeSectionTitle(title: 'EDUCATION'),
          const SizedBox(height: 8),
          Text(
            "B.Sc. in Computer Science | Providence Women's College, Kozhikode (University of Calicut) | 2020 – 2023 | CGPA: 7.6",
            style: TextStyle(color: textPrimary, fontSize: 13.5, fontWeight: FontWeight.w600),
          ),

          const SizedBox(height: 20),

          // Additional Information
          const ResumeSectionTitle(title: 'ADDITIONAL INFORMATION'),
          const SizedBox(height: 8),
          ResumeBulletPoint(
            text: 'Core strengths: Cross-platform development, ERP application development, API integration, offline-first data handling, UI implementation, debugging and application maintenance.',
            textColor: textPrimary,
          ),
          ResumeBulletPoint(
            text: 'Availability: Open to Flutter Developer and Mobile Application developer opportunities.',
            textColor: textPrimary,
          ),
        ],
      ),
    );
  }
}

