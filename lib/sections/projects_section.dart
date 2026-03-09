import 'package:flutter/material.dart';
import '../models/portfolio_models.dart';
import '../widgets/reveal_on_scroll.dart';
import '../theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  final List<ProjectModel> projects = const [
    ProjectModel(
      title: "DOTwe – Biker Community",
      description:
          "A comprehensive ride management platform featuring live GPS tracking, SOS alerts, and club management. Built with Google Maps integration and custom markers.",
      technologies: [
        "Flutter",
        "Google Maps",
        "Firebase",
        "Real-time Tracking",
      ],
    ),
    ProjectModel(
      title: "Mind Body Warrior (MBW)",
      description:
          "Modular wellness app with persistence audio player, video streaming, and Agora SDK for real-time communication. Implements GetX for state management.",
      technologies: ["Flutter", "GetX", "Agora SDK", "Firebase Realtime DB"],
    ),
    ProjectModel(
      title: "SmartPantryPal",
      description:
          "AI-powered pantry management system featuring barcode scanning, OCR bill processing, and intelligent expiry alerts.",
      technologies: [
        "Flutter",
        "OCR",
        "Barcode Scanner",
        "Local Notifications",
      ],
    ),
  ];

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
          const RevealOnScroll(
            child: SectionHeader(number: "02", title: "Something I've Built"),
          ),
          const SizedBox(height: 40),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isDesktop ? 3 : 1,
              childAspectRatio: 1,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            itemCount: projects.length,
            itemBuilder: (context, index) {
              return RevealOnScroll(
                child: ProjectCard(project: projects[index]),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ProjectCard extends StatefulWidget {
  final ProjectModel project;
  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: AppTheme.cardColor,
          borderRadius: BorderRadius.circular(4),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ]
              : [],
          border: _isHovered
              ? Border.all(
                  color: AppTheme.primaryColor.withOpacity(0.5),
                  width: 1,
                )
              : null,
        ),
        transform: _isHovered
            ? (Matrix4.identity()..translate(0, -10))
            : Matrix4.identity(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.folder_open_outlined,
                  color: AppTheme.primaryColor,
                  size: 40,
                ),
                Icon(
                  Icons.launch_outlined,
                  color: AppTheme.textSecondaryColor,
                  size: 24,
                ),
              ],
            ),
            const SizedBox(height: 25),
            Text(
              widget.project.title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: _isHovered ? AppTheme.primaryColor : Colors.white,
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: Text(
                widget.project.description,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: widget.project.technologies.map((tech) {
                return Text(
                  tech,
                  style: GoogleFonts.firaCode(
                    color: AppTheme.textSecondaryColor,
                    fontSize: 12,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
