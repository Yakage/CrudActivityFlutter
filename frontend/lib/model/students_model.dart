class StudentData {
  final int? id;
  final String firstName;
  final String lastName;
  final String course;
  final String year;
  final bool enrolled;

  const StudentData({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.course,
    required this.year,
    required this.enrolled,
  });

  factory StudentData.fromJson(Map<String, dynamic> json) {
    return StudentData(
      id: json['id'] as int?,
      firstName: json['firstname'] as String,
      lastName: json['lastname'] as String,
      course: json['course'] as String,
      year: json['year'] as String,
      enrolled: json['enrolled'] == 1,
    );
  }
}
