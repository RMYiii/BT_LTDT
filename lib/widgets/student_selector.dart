// widgets/student_selector.dart
import 'package:flutter/material.dart';
import '../models/students.dart';

class StudentSelectorSheet extends StatelessWidget {
  final List<Student> students;
  final ValueChanged<Student> onStudentSelected;

  const StudentSelectorSheet({
    super.key,
    required this.students,
    required this.onStudentSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: students.length,
      itemBuilder: (_, index) {
        final student = students[index];
        return ListTile(
          title: Text(student.name),
          onTap: () {
            Navigator.of(context).pop();
            onStudentSelected(student);
          },
        );
      },
    );
  }
}
