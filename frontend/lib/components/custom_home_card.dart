import 'package:crud_activity/pages/update.dart';
import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String course;
  final String year;
  final bool enrolled;
  const HomeCard(
      {super.key,
      required this.firstName,
      required this.lastName,
      required this.course,
      required this.year,
      required this.enrolled});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        color: Colors.white70,
        margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2),
                child: Text(
                  'Name: $lastName, $firstName',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2),
                child: Text(
                  'Course: $course Year: $year',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2),
                child: Text(
                  'Enrolled: ${enrolled ? "Yes" : "No"}',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
