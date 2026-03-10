import 'package:flutter/material.dart';
import '../models/portfolio_models.dart';
import '../widgets/reveal_on_scroll.dart';
import '../theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  final List<ProjectModel> projects = const [
    ProjectModel(
      title: "DOT.we - Biker App",
      description:
          "India’s ultimate biker app for ride planning, live GPS tracking, SOS alerts, and club management. Developed with insights from 1,000+ bikers.",
      technologies: [
        "Flutter",
        "Google Maps",
        "Firebase",
        "Real-time Tracking",
      ],
      link: "https://play.google.com/store/apps/details?id=com.app.dotwe",
    ),
    ProjectModel(
      title: "Breathwork.ai",
      description:
          "Guided wellness application for mental clarity and stress reduction through structured breathwork, pranayama videos, and progress tracking.",
      technologies: ["Flutter", "In-app purchase", "Video player"],
      link:
          "https://play.google.com/store/apps/details?id=com.app.breathwork_ai",
    ),
    ProjectModel(
      title: "Makkok - Shipping",
      description:
          "On-demand shipping platform connecting transporters and shippers. Features journey publishing, route management, and parcel tracking.",
      technologies: ["Flutter", "Socket.io", "Google Maps"],
      link: "https://play.google.com/store/apps/details?id=net.app.makkok",
    ),
    ProjectModel(
      title: "SmartPantryPal",
      description:
          "Smart pantry management system to reduce food waste. Features freshness dashboards, smart shopping lists, and recipe suggestions.",
      technologies: ["Flutter", "Barcode Scanner", "Local Notifications"],
      link: "https://apps.apple.com/us/app/smartpantrypal/id6752896529",
    ),
    ProjectModel(
      title: "Mind Body Warrior",
      description:
          "Astrology-powered wellness merging natal charts with personalized AI coaching, horoscopes, and habit tracking for sign-based guidance.",
      technologies: ["Flutter", "Chat System", "In-app purchase", "Firebase"],
    ),
    ProjectModel(
      title: "Just One Moment",
      description:
          "Memory hub for creating stunning photo albums, scheduling memories, and interacting through built-in chat, calls, and digital photobooks.",
      technologies: [
        "Flutter",
        "Firebase",
        "Real-time Chat",
        "Audio-video calling",
      ],
    ),
    ProjectModel(
      title: "Kick It - Sports",
      description:
          "Premium sports management platform for clubs, coaches, and players. Implements BloC architecture, fl_chart, and role-based routing.",
      technologies: ["Flutter", "BloC", "FCM", "fl_chart"],
    ),
    ProjectModel(
      title: "Argosy QR",
      description:
          "Smart storage organization system using QR labels and digital inventory. Professional-level organization for homes and businesses.",
      technologies: ["Flutter", "QR Scanner", "Database", "Offline Mode"],
      link:
          "https://play.google.com/store/apps/details?id=com.argosy_app&hl=en_IN",
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
              crossAxisCount: isDesktop ? 3 : (size.width > 600 ? 2 : 1),
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

  Future<void> _launchURL() async {
    if (widget.project.link == null) return;
    final Uri url = Uri.parse(widget.project.link!);
    if (!await launchUrl(url)) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Could not launch URL')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.project.link != null ? _launchURL : null,
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
                  if (widget.project.link != null)
                    IconButton(
                      icon: Icon(
                        Icons.launch_outlined,
                        color: _isHovered
                            ? AppTheme.primaryColor
                            : AppTheme.textSecondaryColor,
                        size: 24,
                      ),
                      onPressed: _launchURL,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                ],
              ),
              const SizedBox(height: 25),
              Text(
                widget.project.title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: _isHovered ? AppTheme.primaryColor : Colors.white,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 15),
              Expanded(
                child: Text(
                  widget.project.description,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(height: 1.5),
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 12,
                runSpacing: 10,
                children: widget.project.technologies.map((tech) {
                  return Text(
                    tech,
                    style: GoogleFonts.firaCode(
                      color: AppTheme.textSecondaryColor.withOpacity(0.8),
                      fontSize: 12,
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
