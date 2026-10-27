import 'package:flutter/material.dart';
import 'contact/contact_form_card.dart';
import 'contact/contact_info_cards.dart';
import 'effects/reveal_on_scroll.dart';
import 'shared_widgets.dart';

class ContactSection extends StatelessWidget {
  final bool isDark;

  const ContactSection({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      children: [
        RevealOnScroll(
          child: SectionHeader(
            tag: 'GET IN TOUCH',
            title: "Let's Build Something Exceptional Together",
            subtitle:
                'Available for Flutter Developer roles, enterprise cross-platform contracts, and technical discussions.',
            isDark: isDark,
          ),
        ),
        const SizedBox(height: 36),

        LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 800;
            return isWide
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 4,
                        child: RevealOnScroll(
                          delay: const Duration(milliseconds: 100),
                          child: ContactInfoCards(isDark: isDark),
                        ),
                      ),
                      const SizedBox(width: 32),
                      Expanded(
                        flex: 5,
                        child: RevealOnScroll(
                          delay: const Duration(milliseconds: 200),
                          child: ContactFormCard(isDark: isDark),
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      RevealOnScroll(
                        delay: const Duration(milliseconds: 100),
                        child: ContactInfoCards(isDark: isDark),
                      ),
                      const SizedBox(height: 24),
                      RevealOnScroll(
                        delay: const Duration(milliseconds: 200),
                        child: ContactFormCard(isDark: isDark),
                      ),
                    ],
                  );
          },
        ),
      ],
    );
  }
}
