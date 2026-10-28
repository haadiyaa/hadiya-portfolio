import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

/// Underlined section header for resume documents.
class ResumeSectionTitle extends StatelessWidget {
  final String title;

  const ResumeSectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
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
}

/// Skill bullet row showing bold title and muted items list.
class ResumeSkillBullet extends StatelessWidget {
  final String title;
  final String items;
  final Color textColor;
  final Color subColor;

  const ResumeSkillBullet({
    super.key,
    required this.title,
    required this.items,
    required this.textColor,
    required this.subColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: RichText(
        text: TextSpan(
          style: TextStyle(fontSize: 13, color: textColor),
          children: [
            TextSpan(
              text: '• $title: ',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: items,
              style: TextStyle(color: subColor),
            ),
          ],
        ),
      ),
    );
  }
}

/// Job title, company, location, and period header row.
class ResumeJobHeader extends StatelessWidget {
  final String role;
  final String company;
  final String location;
  final String period;
  final Color textColor;

  const ResumeJobHeader({
    super.key,
    required this.role,
    required this.company,
    required this.location,
    required this.period,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
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
}

/// Bullet point with cyan bullet marker and formatted body text.
class ResumeBulletPoint extends StatelessWidget {
  final String text;
  final Color textColor;

  const ResumeBulletPoint({
    super.key,
    required this.text,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '• ',
            style: TextStyle(color: AppTheme.primaryCyan, fontWeight: FontWeight.bold),
          ),
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
}

/// Featured project item in resume preview.
class ResumeProjectItem extends StatelessWidget {
  final String title;
  final String tech;
  final String desc;
  final Color textColor;

  const ResumeProjectItem({
    super.key,
    required this.title,
    required this.tech,
    required this.desc,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '• $title ',
                style: TextStyle(
                  color: textColor,
                  fontSize: 13.5,
                  fontWeight: FontWeight.bold,
                ),
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
              style: TextStyle(
                color: textColor.withValues(alpha: 0.85),
                fontSize: 12.5,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

