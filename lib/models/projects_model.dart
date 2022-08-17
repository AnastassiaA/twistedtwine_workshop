class ProjectsModel {
  final String projectTitle;
  final DateTime dateStarted;
  final DateTime dateCompleted;
  final String craftType;
  final String status;
  final String description;

  ProjectsModel({
    required this.projectTitle,
    required this.dateStarted,
    required this.dateCompleted,
    required this.craftType,
    required this.status,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'projecttitle': projectTitle,
      'datestarted': dateStarted,
      'datecompleted': dateCompleted,
      'crafttype': craftType,
      'status': status,
      'description': description,
    };
  }

  factory ProjectsModel.fromMap(Map<String, dynamic> json) => new ProjectsModel(
      projectTitle: json['projecttitle'],
      dateStarted: DateTime.parse(json['datestarted']),
      dateCompleted: DateTime.parse(json['datecompleted']),
      craftType: json['crafttype'],
      status: json['status'],
      description: json['description']);
}
