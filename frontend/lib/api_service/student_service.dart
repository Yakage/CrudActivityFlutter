import 'dart:convert';
import 'package:crud_activity/api_service/student_repository.dart';
import 'package:crud_activity/model/students_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class StudentRepositoryImpl implements StudentRepository{
  final String url = 'https://crudactivityflutter-1.onrender.com/api/';

  @override
  Future<List<StudentDataModel>> fetchStudentData() async {
    final response = await http.get(Uri.parse('${url}students'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => StudentDataModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load student data');
    }
  }

  @override
  Future<StudentDataModel> createStudentData({
    required String firstName,
    required String lastName,
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
        'firstname': firstName,
        'lastname': lastName,
        'course': course,
        'year': year,
        'enrolled': enrolled,
      }),
    );

    if (response.statusCode == 200) {
      return StudentDataModel.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to create student data');
    }
  }

  @override
  Future<StudentDataModel> updateStudentData({
    required String? id,
    required String firstName,
    required String lastName,
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
        'firstname': firstName,
        'lastname': lastName,
        'course': course,
        'year': year,
        'enrolled': enrolled,
      }),
    );

    if (response.statusCode == 200) {
      return StudentDataModel.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to update student data');
    }
  }

  @override
  Future<void> deleteStudentData({required String? id}) async {
    final response = await http.delete(
      Uri.parse('${url}student/deleteStudent/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('Student data deleted succcessfully');
      }
    } else {
      throw Exception('Failed to delete student data');
    }
  }
}
