import 'package:flutter/material.dart';
import '../widgets/reveal_on_scroll.dart';
import '../theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  final Map<String, List<String>> skillsets = const {
    "Languages & Frameworks": ["Flutter", "Dart"],
    "State Management": ["GetX", "Bloc", "Riverpod", "RxDart"],
    "Backend & Integrations": [
      "Firebase",
      "REST APIs",
      "Agora SDK",
      "Google Maps",
      "In-App Purchases",
    ],
    "Media & Advanced": [
      "Audio/Video Streaming",
      "Text-to-Speech",
      "Localization",
      "OCR",
    ],
    "AI Tools": [
      "Cursor",
      "ChatGPT",
      "Claude",
      "Antigravity",
      "Workik",
      "Rocket.new",
    ],
  };

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 900;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 100 : 20,
        vertical: 100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RevealOnScroll(
            child: SectionHeader(number: "03", title: "My Toolkit"),
          ),
          const SizedBox(height: 40),
          isDesktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildSkillColumn(0, 2)),
                    const SizedBox(width: 40),
                    Expanded(child: _buildSkillColumn(2, 4)),
                    const SizedBox(width: 40),
                    Expanded(child: _buildSkillColumn(4, 5)),
                  ],
                )
              : _buildSkillColumn(0, 5),
        ],
      ),
    );
  }

  Widget _buildSkillColumn(int start, int end) {
    final keys = skillsets.keys.toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: keys.sublist(start, end).map((key) {
        return RevealOnScroll(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  key,
                  style: GoogleFonts.firaCode(
                    color: AppTheme.primaryColor,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 15),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: skillsets[key]!.map((skill) {
                    return _SkillChip(label: skill);
                  }).toList(),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _SkillChip extends StatefulWidget {
  final String label;
  const _SkillChip({required this.label});

  @override
  State<_SkillChip> createState() => _SkillChipState();
}

class _SkillChipState extends State<_SkillChip> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: _isHovered
              ? AppTheme.primaryColor.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: _isHovered
                ? AppTheme.primaryColor
                : AppTheme.primaryColor.withOpacity(0.3),
          ),
        ),
        child: Text(
          widget.label,
          style: GoogleFonts.firaCode(
            color: _isHovered ? AppTheme.primaryColor : AppTheme.textColor,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
