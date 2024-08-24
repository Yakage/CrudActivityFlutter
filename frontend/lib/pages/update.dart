import 'package:crud_activity/api_service/student_service.dart';
import 'package:crud_activity/components/custom_appbar.dart';
import 'package:crud_activity/components/custom_textfield.dart';
import 'package:crud_activity/model/students_model.dart';
import 'package:flutter/material.dart';

class UpdateStudent extends StatefulWidget {
  final StudentData studentData;
  const UpdateStudent({super.key, required this.studentData});

  @override
  State<UpdateStudent> createState() => _UpdateStudentState();
}

class _UpdateStudentState extends State<UpdateStudent> {
  final ApiService apiService = ApiService();
  final formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController courseController = TextEditingController();
  bool enrolled = false;
  String? selectedYear;

  final List<String> yearOptions = [
    'First Year',
    'Second Year',
    'Third Year',
    'Fourth Year',
    'Fifth Year'
  ];

  @override
  void initState() {
    super.initState();
    firstNameController.text = widget.studentData.firstName;
    lastNameController.text = widget.studentData.lastName;
    courseController.text = widget.studentData.course;
    enrolled = widget.studentData.enrolled;
    selectedYear = widget.studentData.year;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarAll(title: 'Update Student'),
      body: SingleChildScrollView(
        child: Container(
          constraints: const BoxConstraints(
            minHeight: 350,
            maxHeight: 500,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
              ),
            ],
          ),
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomTextField(
                    controller: firstNameController, text: "First Name"),
                const SizedBox(height: 16.0),
                CustomTextField(
                    controller: lastNameController, text: "Last Name"),
                const SizedBox(height: 16.0),
                CustomTextField(controller: courseController, text: "Course"),
                const SizedBox(height: 16.0),
                DropdownButtonFormField<String>(
                  value: selectedYear, // Set the initial value
                  decoration: InputDecoration(
                    labelText: 'Year',
                    labelStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  items: yearOptions.map((String option) {
                    return DropdownMenuItem<String>(
                      value: option,
                      child: Text(
                        option,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedYear = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a year';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Enrolled',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                        ),
                      ),
                      Switch(
                        value: enrolled,
                        activeColor: Colors.green,
                        inactiveThumbColor: Colors.red,
                        onChanged: (value) {
                          setState(() {
                            enrolled = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          await apiService.updateStudentData(
                            id: widget.studentData.id,
                            firstname: firstNameController.text,
                            lastname: lastNameController.text,
                            course: courseController.text,
                            year: selectedYear ?? '',
                            enrolled: enrolled,
                          );
                          Navigator.pop(context, true);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                      child: const Text(
                        'Update',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          await apiService.updateStudentData(
                            id: widget.studentData.id,
                            firstname: firstNameController.text,
                            lastname: lastNameController.text,
                            course: courseController.text,
                            year: selectedYear ?? '',
                            enrolled: enrolled,
                          );
                          Navigator.pop(context, true);
                        }
                      },
                      child: const Text(
                        'Delete',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
