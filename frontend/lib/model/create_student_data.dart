class CreateStudentData {
  final String firstname;
  final String lastname;
  final String course;
  final String year;
  final bool enrolled;

  const CreateStudentData({
    required this.firstname,
    required this.lastname,
    required this.course,
    required this.year,
    required this.enrolled,
  });

  factory CreateStudentData.fromJson(Map<String, dynamic> json) {
    return CreateStudentData(
      firstname: json['firstname'] as String? ?? '',
      lastname: json['lastname'] as String? ?? '',
      course: json['course'] as String? ?? '',
      year: json['year'] as String? ?? '',
      enrolled: json['enrolled'] as bool? ?? false,
    );
  }
}
