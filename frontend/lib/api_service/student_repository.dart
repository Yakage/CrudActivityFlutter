import 'package:crud_activity/model/students_model.dart';

abstract class StudentRepository {
  Future<List<StudentDataModel>> fetchStudentData();
  Future<StudentDataModel> createStudentData({
    required String firstName,
    required String lastName,
    required String course,
    required String year,
    required bool enrolled,
  });
  Future<StudentDataModel> updateStudentData({
    required String? id,
    required String firstName,
    required String lastName,
    required String course,
    required String year,
    required bool enrolled,
  });
  Future<void> deleteStudentData({required String? id});
}
