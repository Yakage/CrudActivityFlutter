import 'dart:async';

import 'package:crud_activity/api_service/student_service.dart';
import 'package:crud_activity/components/custom_appbar.dart';
import 'package:crud_activity/components/custom_home_card.dart';
import 'package:crud_activity/model/students_model.dart';
import 'package:crud_activity/pages/create.dart';
import 'package:crud_activity/pages/update.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  Future<List<StudentDataModel>> futureStudentDataModel = StudentRepositoryImpl().fetchStudentData();
  final StudentRepositoryImpl apiService = StudentRepositoryImpl();

  @override
  void initState() {
    super.initState();
    futureStudentDataModel = apiService.fetchStudentData();
  }

  void refreshStudentData() {
    setState(() {
      futureStudentDataModel = apiService.fetchStudentData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarAll(title: 'Student Info'),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateStudent()),
          );

          if (result == true) {
            refreshStudentData();
          }
        },
        backgroundColor: Colors.blue[200],
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: FutureBuilder<List<StudentDataModel>>(
          future: futureStudentDataModel,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text('No data available');
            } else {
              final students = snapshot.data!;
              return ListView.builder(
                itemCount: students.length,
                itemBuilder: (context, index) {
                  final student = students[index];
                  return GestureDetector(
                    onTap: () async {
                      final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UpdateStudent(studentData: student),
                          ),
                      );

                      if (result == true) {
                        refreshStudentData();
                      }
                    },
                    child: HomeCard(
                        firstName: student.firstName,
                        lastName: student.lastName,
                        course: student.course,
                        year: student.year,
                        enrolled: student.enrolled),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
