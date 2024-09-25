class StudentDataModel {
  final String? id;
  final String firstName;
  final String lastName;
  final String course;
  final String year;
  final bool enrolled;

  const StudentDataModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.course,
    required this.year,
    required this.enrolled,
  });

  factory StudentDataModel.fromJson(Map<String, dynamic> json) {
    return StudentDataModel(
      id: json['_id'] as String? ?? '',
      firstName: json['firstname'] as String? ?? '',
      lastName: json['lastname'] as String? ?? '',
      course: json['course'] as String? ?? '',
      year: json['year'] as String? ?? '',
      enrolled: json['enrolled'] as bool? ?? false,
    );
  }
}