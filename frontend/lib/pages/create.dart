import 'package:crud_activity/api_service/student_service.dart';
import 'package:crud_activity/components/custom_appbar.dart';
import 'package:crud_activity/components/custom_textfield.dart';
import 'package:flutter/material.dart';

class CreateStudent extends StatefulWidget {
  const CreateStudent({super.key});

  @override
  State<CreateStudent> createState() => _CreateStudentState();
}

class _CreateStudentState extends State<CreateStudent> {
  final StudentRepositoryImpl apiService = StudentRepositoryImpl();
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarAll(title: 'Add Student'),
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
                CustomTextField(controller: firstNameController, text: "First Name"),
                const SizedBox(height: 16.0),
                CustomTextField(controller: lastNameController, text: "Last Name"),
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
                      child: Text(option),
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
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      await apiService.createStudentData(
                        firstName: firstNameController.text,
                        lastName: lastNameController.text,
                        course: courseController.text,
                        year: selectedYear ?? '',
                        enrolled: enrolled,
                      );
                      Navigator.pop(context, true);
                    } 
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
