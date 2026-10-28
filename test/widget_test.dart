import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/models/project_model.dart';

void main() {
  testWidgets('PortfolioApp loads correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: PortfolioApp()));
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('Haadiya CT'), findsWidgets);
    await tester.pumpWidget(const SizedBox());
  });

  test('Isselo matches Desktop & Web filter and Flutter / Mobile filter', () {
    final isselo = ProjectModel.projects.firstWhere((p) => p.title == 'Isselo');
    expect(isselo.platforms, contains('Web'));
    expect(isselo.matchesFilter('Desktop & Web'), isTrue);
    expect(isselo.matchesFilter('Flutter / Mobile'), isTrue);
    expect(isselo.matchesFilter('All'), isTrue);
  });
}
