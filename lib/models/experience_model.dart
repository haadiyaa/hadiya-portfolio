class ExperienceModel {
  final String role;
  final String company;
  final String location;
  final String period;
  final bool isCurrent;
  final List<String> bulletPoints;
  final List<String> techTags;

  const ExperienceModel({
    required this.role,
    required this.company,
    required this.location,
    required this.period,
    required this.isCurrent,
    required this.bulletPoints,
    required this.techTags,
  });

  static List<ExperienceModel> get experiences => [
        const ExperienceModel(
          role: 'Flutter Developer',
          company: 'Screl Info Pvt. Ltd.',
          location: 'Kozhikode, Kerala',
          period: 'Nov 2024 – Present',
          isCurrent: true,
          bulletPoints: [
            'Architect and maintain enterprise cross-platform ERP solutions using Flutter and Dart across Sales, Inventory, CRM, and Finance modules.',
            'Engineered Isselo, a restaurant management ERP for Android, iOS, Desktop, and Web utilizing Clean Architecture, Riverpod, and offline-first SQLite synchronization.',
            'Developed SincA Reports, enabling administrative stakeholders to track live analytics and executive business metrics from the SincA ERP ecosystem.',
            'Contributed to the web frontend and developed WPF desktop clients for SincA ERP using C#, .NET, and XAML.',
            'Integrated complex RESTful APIs, designed reusable Flutter component libraries, and optimized multi-platform rendering performance.',
          ],
          techTags: [
            'Flutter',
            'Dart',
            'Riverpod',
            'Clean Architecture',
            'SQLite',
            'C# / .NET',
            'WPF / XAML',
            'REST APIs',
          ],
        ),
        const ExperienceModel(
          role: 'Flutter Developer Intern',
          company: 'Self Stack',
          location: 'Kozhikode, Kerala',
          period: 'Sept 2023 – Nov 2024',
          isCurrent: false,
          bulletPoints: [
            'Built responsive, production-ready Flutter applications utilizing Provider, GetX, and BLoC state management patterns.',
            'Faithfully translated high-fidelity Figma designs into pixel-perfect, responsive mobile UI code.',
            'Connected front-end clients to backend REST APIs, handled error states, and established clean asynchronous workflows.',
            'Worked with HTML and CSS for web view integrations and cross-functional support.',
            'Collaborated closely with engineering team members for code reviews, QA debugging, and rapid issue resolution.',
          ],
          techTags: [
            'Flutter',
            'Dart',
            'BLoC',
            'Provider',
            'GetX',
            'REST APIs',
            'Figma to Flutter',
            'HTML/CSS',
          ],
        ),
      ];
}
