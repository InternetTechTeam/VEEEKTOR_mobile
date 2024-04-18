import 'package:veeektor/model/teacher.dart';

class Course {
  int id;
  String name;
  int term;
  String department;
  Teacher teacher;

  Course({
    required this.id,
    required this.name,
    required this.term,
    required this.department,
    required this.teacher,
  });

  factory Course.fromJson(Map<String, dynamic> json) => Course(
        id: json["id"] as int,
        name: json["name"] as String,
        term: json["term"] as int,
        department: json["department"] as String,
        teacher: Teacher.fromJson(json["teacher"]),
      );
}
