import 'package:flutter/material.dart';
import '../models/portfolio_models.dart';
import '../widgets/reveal_on_scroll.dart';
import '../theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class ExperienceSection extends StatefulWidget {
  const ExperienceSection({super.key});

  @override
  State<ExperienceSection> createState() => _ExperienceSectionState();
}

class _ExperienceSectionState extends State<ExperienceSection> {
  int _selectedIndex = 0;

  final List<ExperienceModel> experiences = [
    ExperienceModel(
      company: "Openxcell Technolabs",
      role: "Flutter Developer",
      period: "June 2022 – Present",
      responsibilities: [
        "Designing, developing, and maintaining complex cross-platform mobile applications using Flutter.",
        "Collaborating with UI/UX designers and backend teams to deliver high-quality products.",
        "Leveraging AI tools (Cursor, ChatGPT, Claude) to accelerate development and debugging cycles.",
        "Ensuring code quality through rigorous testing and documentation.",
      ],
    ),
    ExperienceModel(
      company: "Finite Core",
      role: "Flutter Trainee",
      period: "Jan 2022 – May 2022",
      responsibilities: [
        "Assisted in UI development and API integration for mobile apps.",
        "Gained hands-on experience in debugging and performance optimization.",
        "Participated in agile ceremonies and team planning sessions.",
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 900;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 100 : 20,
        vertical: 100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const RevealOnScroll(
            child: SectionHeader(number: "01", title: "Where I've Worked"),
          ),
          const SizedBox(height: 40),
          RevealOnScroll(
            delay: const Duration(milliseconds: 200),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tab List
                SizedBox(
                  width: 150,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: experiences.length,
                    itemBuilder: (context, index) {
                      final isSelected = _selectedIndex == index;
                      return InkWell(
                        onTap: () => setState(() => _selectedIndex = index),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                color: isSelected
                                    ? AppTheme.primaryColor
                                    : const Color(0xFF233554),
                                width: 2,
                              ),
                            ),
                            color: isSelected
                                ? AppTheme.primaryColor.withOpacity(0.1)
                                : Colors.transparent,
                          ),
                          child: Text(
                            experiences[index].company,
                            style: GoogleFonts.firaCode(
                              color: isSelected
                                  ? AppTheme.primaryColor
                                  : AppTheme.textSecondaryColor,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 30),
                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: experiences[_selectedIndex].role,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            TextSpan(
                              text: " @ ${experiences[_selectedIndex].company}",
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(color: AppTheme.primaryColor),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        experiences[_selectedIndex].period,
                        style: GoogleFonts.firaCode(
                          color: AppTheme.textSecondaryColor,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 25),
                      ...experiences[_selectedIndex].responsibilities.map((
                        res,
                      ) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 8),
                                child: Icon(
                                  Icons.play_arrow,
                                  color: AppTheme.primaryColor,
                                  size: 12,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  res,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
