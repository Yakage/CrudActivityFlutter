import 'dart:convert';
import 'package:crud_activity/model/create_student_data.dart';
import 'package:crud_activity/model/students_model.dart';
import 'package:crud_activity/model/update_student_data.dart';
import 'package:crud_activity/pages/update.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String url = 'http://localhost:3000/api/';

  Future<List<StudentData>> fetchStudentData() async {
    final response = await http.get(Uri.parse('${url}students'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => StudentData.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load student data');
    }
  }

  Future<CreateStudentData> createStudentData({
    required String firstname,
    required String lastname,
    required String course,
    required String year,
    required bool enrolled,
  }) async {
    final response = await http.post(
      Uri.parse('${url}student/createStudent'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'firstname': firstname,
        'lastname': lastname,
        'course': course,
        'year': year,
        'enrolled': enrolled,
      }),
    );

    if (response.statusCode == 200) {
      return CreateStudentData.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to create student data');
    }
  }

  Future<UpdateStudentData> updateStudentData({
    required int? id,
    required String firstname,
    required String lastname,
    required String course,
    required String year,
    required bool enrolled,
  }) async {
    final response = await http.put(
      Uri.parse('${url}student/updateStudent/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'firstname': firstname,
        'lastname': lastname,
        'course': course,
        'year': year,
        'enrolled': enrolled,
      }),
    );

    if (response.statusCode == 200) {
      return UpdateStudentData.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to update student data');
    }
  }
}
