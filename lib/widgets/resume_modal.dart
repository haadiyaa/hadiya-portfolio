import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import '../utils/file_download.dart';

class ResumeModal extends StatelessWidget {
  final bool isDark;

  const ResumeModal({super.key, required this.isDark});

  static void show(BuildContext context, bool isDark) {
    showDialog(
      context: context,
      builder: (context) => ResumeModal(isDark: isDark),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 750;
    final cardBg = isDark ? AppTheme.darkCard : AppTheme.lightCard;
    final border = isDark ? AppTheme.darkBorder : AppTheme.lightBorder;
    final textPrimary = isDark ? AppTheme.darkTextPrimary : AppTheme.lightTextPrimary;
    final textSecondary = isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(
        horizontal: isMobile ? 12 : 40,
        vertical: 24,
      ),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 850, maxHeight: 900),
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
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  const Icon(Icons.description_rounded, color: AppTheme.primaryCyan, size: 24),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Haadiya CT — Resume Preview',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: textPrimary,
                        fontSize: isMobile ? 16 : 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  IconButton(
                    tooltip: 'Open PDF in new tab',
                    onPressed: () {
                      launchUrl(
                        Uri.parse('resume.pdf'),
                        webOnlyWindowName: '_blank',
                      );
                    },
                    icon: Icon(Icons.open_in_new_rounded, color: textSecondary, size: 20),
                  ),
                  IconButton(
                    tooltip: 'Close',
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.close_rounded, color: textSecondary),
                  ),
                ],
              ),
            ),

            const Divider(height: 1),

            // Resume Document Body
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(isMobile ? 18 : 32),
                child: Container(
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

                      _resumeSectionTitle('PROFESSIONAL SUMMARY', textPrimary),
                      const SizedBox(height: 8),
                      Text(
                        'Flutter Developer with 3+ years of experience building cross-platform applications and enterprise ERP software with Flutter. Experienced in REST API integration, offline-first data handling with SQLite, state management with Riverpod, BLoC, Provider and GetX, and Clean Architecture. Skilled in turning Figma designs into responsive UIs and maintaining production-grade ERP modules across Sales, Inventory, CRM and Finance.',
                        style: TextStyle(color: textPrimary, fontSize: 13.5, height: 1.6),
                      ),

                      const SizedBox(height: 20),
                      _resumeSectionTitle('TECHNICAL SKILLS', textPrimary),
                      const SizedBox(height: 8),
                      _skillBullet('Languages', 'Dart, C#, XAML, HTML, CSS', textPrimary, textSecondary),
                      _skillBullet('Frameworks & Platforms', 'Flutter, .NET, WPF, Cross-Platform (Android, iOS, Desktop, Web)', textPrimary, textSecondary),
                      _skillBullet('State Management & Architecture', 'Riverpod, Hooks Riverpod, BLoC, Provider, GetX, Clean Architecture, MVVM', textPrimary, textSecondary),
                      _skillBullet('Database & Storage', 'SQLite, SQFlite, Hive, Firebase', textPrimary, textSecondary),
                      _skillBullet('APIs & Tools', 'REST API Integration, Git, GitHub, Postman, Figma, Freezed', textPrimary, textSecondary),

                      const SizedBox(height: 20),
                      _resumeSectionTitle('PROFESSIONAL EXPERIENCE', textPrimary),
                      const SizedBox(height: 12),
                      _jobHeader('Flutter Developer', 'Screl Info Pvt. Ltd.', 'Kozhikode, Kerala', 'Nov 2024 – Present', textPrimary),
                      const SizedBox(height: 8),
                      _bulletPoint('Develop and maintain cross-platform ERP applications using Flutter and Dart, covering Sales, Inventory, CRM and Finance modules.', textPrimary),
                      _bulletPoint('Built Isselo, a restaurant management ERP for Android, iOS, desktop and web, using Clean Architecture and Riverpod, with offline SQLite storage and automatic server synchronization.', textPrimary),
                      _bulletPoint('Developed SincA Reports, a Flutter application for administrators to monitor business reports and analytics from the SincA ERP ecosystem through REST API integration.', textPrimary),
                      _bulletPoint('Develop the web front end and WPF desktop application for SincA ERP using C#, .NET and XAML.', textPrimary),
                      _bulletPoint('Integrate REST APIs and collaborate with backend teams to implement and optimize API-driven features.', textPrimary),
                      _bulletPoint('Build reusable Flutter components and apply state management to improve maintainability and performance.', textPrimary),

                      const SizedBox(height: 16),
                      _jobHeader('Flutter Developer Intern', 'Self Stack', 'Kozhikode, Kerala', 'Sept 2023 – Nov 2024', textPrimary),
                      const SizedBox(height: 8),
                      _bulletPoint('Developed Flutter applications using Provider, GetX and BLoC state management.', textPrimary),
                      _bulletPoint('Implemented user interfaces from Figma designs and integrated them with backend REST APIs.', textPrimary),
                      _bulletPoint('Worked with HTML and CSS.', textPrimary),
                      _bulletPoint('Handled debugging, API integration and maintenance on real-world application features.', textPrimary),
                      _bulletPoint('Collaborated with team members to troubleshoot issues and deliver features within project requirements.', textPrimary),

                      const SizedBox(height: 20),
                      _resumeSectionTitle('FEATURED PROJECTS', textPrimary),
                      const SizedBox(height: 10),
                      _projectItem('Isselo (Screl Info Pvt. Ltd.)', 'Flutter, Dart, Riverpod, SQLite, Clean Architecture', 'Restaurant management ERP with Sales, CRM, HR and accounting modules, built for Android, iOS, desktop and web with offline data storage and automatic server synchronization.', textPrimary),
                      _projectItem('SincA ERP (Screl Info Pvt. Ltd.)', 'C#, .NET, WPF, XAML', 'Enterprise ERP covering Sales, Stock, Inventory, Finance, HRM, CRM and Procurement. Developed web front end and WPF desktop application.', textPrimary),
                      _projectItem('SincA Reports (Screl Info Pvt. Ltd.)', 'Flutter, Dart, REST APIs', 'Monitoring application for administrators to visualize and track real-time business analytics and reports from the SincA ERP ecosystem.', textPrimary),
                      _projectItem('Hidhayah App', 'Flutter, Dart', 'Islamic application with prayer time calculation, Qibla direction using device sensors, and Arabic and English educational resources.', textPrimary),

                      const SizedBox(height: 20),
                      _resumeSectionTitle('EDUCATION', textPrimary),
                      const SizedBox(height: 8),
                      Text(
                        "B.Sc. in Computer Science | Providence Women's College, Kozhikode (University of Calicut) | 2020 – 2023 | CGPA: 7.6",
                        style: TextStyle(color: textPrimary, fontSize: 13.5, fontWeight: FontWeight.w600),
                      ),

                      const SizedBox(height: 20),
                      _resumeSectionTitle('ADDITIONAL INFORMATION', textPrimary),
                      const SizedBox(height: 8),
                      _bulletPoint('Core strengths: Cross-platform development, ERP application development, API integration, offline-first data handling, UI implementation, debugging and application maintenance.', textPrimary),
                      _bulletPoint('Availability: Open to Flutter Developer and Mobile Application developer opportunities.', textPrimary),
                    ],
                  ),
                ),
              ),
            ),

            // Footer actions
            Container(
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 24, vertical: 14),
              decoration: BoxDecoration(
                color: isDark ? Colors.black26 : Colors.grey.withValues(alpha: 0.04),
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
                border: Border(top: BorderSide(color: border)),
              ),
              child: isMobile
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        OutlinedButton.icon(
                          onPressed: () {
                            downloadResumePdf();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Row(
                                  children: [
                                    Icon(Icons.check_circle_rounded, color: AppTheme.accentEmerald, size: 20),
                                    SizedBox(width: 10),
                                    Text('Downloading resume.pdf...'),
                                  ],
                                ),
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                backgroundColor: isDark ? AppTheme.darkCardHover : AppTheme.lightCardHover,
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          },
                          icon: const Icon(Icons.download_rounded, size: 18),
                          label: const Text('Download Resume'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: textPrimary,
                            side: BorderSide(color: border),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton.icon(
                          onPressed: () {
                            final mailto = Uri.parse('mailto:haadiyact@gmail.com?subject=Job%20Opportunity%20for%20Haadiya%20CT');
                            launchUrl(mailto);
                          },
                          icon: const Icon(Icons.mail_outline_rounded, size: 18),
                          label: const Text('Hire Haadiya'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryCyan,
                            foregroundColor: const Color(0xFF090D16),
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        OutlinedButton.icon(
                          onPressed: () {
                            downloadResumePdf();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Row(
                                  children: [
                                    Icon(Icons.check_circle_rounded, color: AppTheme.accentEmerald, size: 20),
                                    SizedBox(width: 10),
                                    Text('Downloading resume.pdf...'),
                                  ],
                                ),
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                backgroundColor: isDark ? AppTheme.darkCardHover : AppTheme.lightCardHover,
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          },
                          icon: const Icon(Icons.download_rounded, size: 18),
                          label: const Text('Download Resume'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: textPrimary,
                            side: BorderSide(color: border),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          ),
                        ),
                        const Spacer(),
                        ElevatedButton.icon(
                          onPressed: () {
                            final mailto = Uri.parse('mailto:haadiyact@gmail.com?subject=Job%20Opportunity%20for%20Haadiya%20CT');
                            launchUrl(mailto);
                          },
                          icon: const Icon(Icons.mail_outline_rounded, size: 18),
                          label: const Text('Hire Haadiya'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryCyan,
                            foregroundColor: const Color(0xFF090D16),
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _resumeSectionTitle(String title, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppTheme.primaryCyan,
            fontSize: 13,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.1,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: 30,
          height: 2,
          color: AppTheme.primaryCyan,
        ),
      ],
    );
  }

  Widget _skillBullet(String title, String items, Color textColor, Color subColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: RichText(
        text: TextSpan(
          style: TextStyle(fontSize: 13, color: textColor),
          children: [
            TextSpan(text: '• $title: ', style: const TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: items, style: TextStyle(color: subColor)),
          ],
        ),
      ),
    );
  }

  Widget _jobHeader(String role, String company, String location, String period, Color textColor) {
    return Row(
      children: [
        Expanded(
          child: Text(
            '$role | $company | $location',
            style: TextStyle(
              color: textColor,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Text(
          period,
          style: const TextStyle(
            color: AppTheme.primaryCyan,
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _bulletPoint(String text, Color textColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(color: AppTheme.primaryCyan, fontWeight: FontWeight.bold)),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: textColor, fontSize: 13, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _projectItem(String title, String tech, String desc, Color textColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '• $title ',
                style: TextStyle(color: textColor, fontSize: 13.5, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Text(
                  '| $tech',
                  style: const TextStyle(color: AppTheme.primaryCyan, fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              desc,
              style: TextStyle(color: textColor.withValues(alpha: 0.85), fontSize: 12.5, height: 1.45),
            ),
          ),
        ],
      ),
    );
  }
}
