<div align="center">

  # ⚡ Haadiya CT — Portfolio Web

  <p align="center">
    <strong>A sleek, minimal, and high-performance cross-platform portfolio built with Flutter Web.</strong>
  </p>

  <p align="center">
    <a href="https://flutter.dev"><img src="https://img.shields.io/badge/Flutter-3.47+-02569B?logo=flutter&logoColor=white&style=for-the-badge" alt="Flutter"></a>
    <a href="https://dart.dev"><img src="https://img.shields.io/badge/Dart-3.13+-0175C2?logo=dart&logoColor=white&style=for-the-badge" alt="Dart"></a>
    <a href="https://github.com/haadiyaa/hadiya-portfolio"><img src="https://img.shields.io/badge/Platform-Web%20%7C%20Cross--Platform-38BDF8?style=for-the-badge" alt="Platform"></a>
    <a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/License-MIT-10B981?style=for-the-badge" alt="License"></a>
  </p>

  <p align="center">
    <a href="#-features">Features</a> •
    <a href="#-featured-projects">Featured Projects</a> •
    <a href="#-tech-stack">Tech Stack</a> •
    <a href="#-architecture">Architecture</a> •
    <a href="#-getting-started">Getting Started</a> •
    <a href="#-connect">Connect</a>
  </p>

  <br>

</div>

---

## 🌟 Overview

Welcome to the personal portfolio of **Haadiya CT**, a **Flutter Developer & Cross-Platform Engineer** with 3+ years of experience engineering production-grade enterprise ERPs, offline-first architectures, and snappy mobile/desktop applications.

This web portfolio showcases a modern **Cyber-Clean minimalist aesthetic**, seamless responsive design across all devices, interactive project deep-dives, and an in-app resume previewer.

---

## ✨ Features

- 🎨 **Minimalist & Catchy Aesthetic**: Curated color harmony featuring deep slate dark mode (`#090D16`), vibrant cyan (`#38BDF8`) & indigo accents, and frosted glass navigation with dynamic backdrop blur (`ImageFilter.blur`).
- 🌓 **Instant Dark / Light Mode**: Smooth theme toggling with custom-tailored color schemes for both modes.
- 📱 **100% Fluid Responsiveness**: Handcrafted adaptive layout ensuring flawless presentation across mobile screens, tablets, laptops, and ultra-wide displays.
- 🚀 **Interactive Project Showcase**:
  - Filter by category (*All*, *Flutter / Mobile*, *Desktop & Web*).
  - Target platform badges (*Android*, *iOS*, *Desktop*, *Web*).
  - Dedicated **"Architecture & Deliverables"** deep-dive modal detailing implementation highlights and technical challenges solved.
- 💼 **Career Timeline**: Interactive experience cards featuring roles at **Screl Info Pvt. Ltd.** and **Self Stack** with tech tags and key deliverables.
- 🛠️ **Categorized Skills Matrix**: Visual pill grid spanning Languages, Frameworks, State Management (Riverpod, BLoC, Provider, GetX), Databases (SQLite, Hive, Firebase), and APIs.
- 📄 **Interactive Resume Modal**: In-app formatted resume viewer with a 1-click **"Copy Resume Text"** button and direct hiring CTA.
- 📬 **Seamless Contact Section**: 1-click clipboard copy for `haadiyact@gmail.com`, direct mailto launcher, location badge (*Kozhikode, Kerala, India*), and an interactive pre-filled message composer.
- ⚡ **SEO & Performance Optimized**: Custom SVG & PNG brand favicon, social Open Graph metadata, and tree-shaken assets for blazing fast load times.

---

## 🚀 Featured Projects

| Project | Domain / Platform | Architecture & Stack |
| :--- | :--- | :--- |
| **Isselo** | Restaurant ERP • Android, iOS, Desktop | Flutter, Dart, Riverpod, SQLite, Clean Architecture, Offline Auto-Sync |
| **SincA Reports** | Executive Business Analytics • Android, iOS, Web | Flutter, Dart, REST APIs, Riverpod, Real-Time Visualizations |
| **Hidhayah App** | Islamic Companion & Utilities • Mobile | Flutter, Dart, Device Sensors, Magnetometer, Geolocation |
| **SincA ERP** | Enterprise ERP Suite • Desktop (WPF), Web | C#, .NET, WPF, XAML, REST APIs, Web Frontend |

---

## 🛠️ Tech Stack & Tools

- **Core**: Flutter 3.x, Dart 3.x
- **Typography**: Plus Jakarta Sans ([google_fonts](https://pub.dev/packages/google_fonts))
- **Icons**: Material Icons, [font_awesome_flutter](https://pub.dev/packages/font_awesome_flutter)
- **Utilities**: [url_launcher](https://pub.dev/packages/url_launcher)
- **Deployment**: Flutter Web (CanvasKit / HTML renderer), GitHub Pages / Vercel

---

## 📂 Project Architecture

```plaintext
portfolio/
├── lib/
│   ├── main.dart                  # App entry point, smooth scroll & theme state
│   ├── theme/
│   │   └── app_theme.dart         # Design tokens, dark/light themes, typography
│   ├── models/
│   │   ├── project_model.dart     # Project data model & descriptions
│   │   ├── experience_model.dart  # Career timeline & work experience
│   │   └── skill_model.dart       # Skills matrix & core competency tags
│   └── widgets/
│       ├── nav_bar.dart           # Frosted glass header & mobile drawer
│       ├── hero_section.dart      # Hero headline, stats bar, quick badges
│       ├── highlights_section.dart# 4 core engineering pillars
│       ├── projects_section.dart  # Filterable project cards & grid
│       ├── project_detail_modal.dart # Architectural deep-dive dialog
│       ├── experience_section.dart# Career timeline cards
│       ├── skills_section.dart    # Categorized skill chips
│       ├── education_section.dart # Academic background & coursework
│       ├── contact_section.dart   # Email copy, location, message composer
│       ├── resume_modal.dart      # In-app resume viewer & copy action
│       └── footer_section.dart    # Footer branding, social links, back-to-top
└── web/
    ├── favicon.svg                # Custom brand SVG monogram
    ├── favicon.png                # 64x64 PNG favicon
    ├── index.html                 # SEO tags, theme color, open graph meta
    ├── manifest.json              # PWA manifest
    └── icons/                     # Brand app icons (192x192, 512x512)
```

---

## 💻 Getting Started

### Prerequisites

Ensure you have the Flutter SDK installed on your system:
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (`^3.13.0` or higher)
- Google Chrome (for web debugging)

### 1. Clone the repository

```bash
git clone https://github.com/haadiyaa/hadiya-portfolio.git
cd hadiya-portfolio
```

### 2. Install dependencies

```bash
flutter pub get
```

### 3. Run locally

```bash
flutter run -d chrome
```

### 4. Build for production

```bash
flutter build web --release
```
The compiled production bundle will be generated in `build/web/`.

---

## 🧪 Testing & Code Quality

Run static analysis and smoke tests:

```bash
flutter analyze
flutter test
```

---

## 📬 Connect with Haadiya

- **Email**: [haadiyact@gmail.com](mailto:haadiyact@gmail.com)
- **LinkedIn**: [linkedin.com/in/haadiya-ct](https://www.linkedin.com/in/haadiya-ct-47775621b/)
- **GitHub**: [@haadiyaa](https://github.com/haadiyaa)
- **Location**: Kozhikode, Kerala, India

---

<div align="center">
  <sub>Designed & Handcrafted with ❤️ using Flutter & Dart. © 2026 Haadiya CT.</sub>
</div>
