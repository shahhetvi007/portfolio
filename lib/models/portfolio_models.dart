class ProjectModel {
  final String title;
  final String description;
  final List<String> technologies;
  final String? link;

  const ProjectModel({
    required this.title,
    required this.description,
    required this.technologies,
    this.link,
  });
}

class ExperienceModel {
  final String company;
  final String role;
  final String period;
  final List<String> responsibilities;

  const ExperienceModel({
    required this.company,
    required this.role,
    required this.period,
    required this.responsibilities,
  });
}
